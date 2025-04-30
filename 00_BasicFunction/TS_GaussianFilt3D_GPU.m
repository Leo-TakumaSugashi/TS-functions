function [output,LoopNum] = TS_GaussianFilt3D_GPU(Image,Reso,ObjSize,varargin)
%% output = TS_GaussianFilt(Image,Reso,ObjSize,{loopNUM})
% output : single
% Input  : 1 Image
%          2 Reso(X,Y,Z) um/pix.
%          3 ObjSize(X,Y,Z) um
% edit Input ndims Image can processe.. by sugashi, 2019,0708

tic
if ndims(Image)~=3
    if or(isscalar(Image),isvector(Image))
        error('Input Image is scalor or vector')
    end
    siz = size(Image);
    siz(3) = size(Image,3);
    siz(4) = size(Image,4);
    Image = reshape(Image,[siz(1) siz(2) siz(3) prod(siz(4:end))]);
    output = zeros(size(Image),'like',single(1));
    LoopNum = 1;
    Time4D = tic;
    for T = 1:size(Image,4)
        [pwdata,LoopNum] = TS_GaussianFilt3D_GPU(Image(:,:,:,T),Reso,ObjSize,LoopNum);
        output(:,:,:,T) = pwdata;
    end
    output = reshape(output,siz);
    fprintf('  ---> Total ')
    toc(Time4D)
    return
else
    siz = size(Image);
end

GaussFil_sigma_coef = 1;
sigma_array = [ObjSize(2)/Reso(2)/(2*sqrt(2*log(2)))*GaussFil_sigma_coef ...
    ObjSize(1)/Reso(1)/(2*sqrt(2*log(2)))*GaussFil_sigma_coef ...
    ObjSize(3)/Reso(3)/(2*sqrt(2*log(2)))*GaussFil_sigma_coef];
KernelSize = 2*ceil(2*sigma_array)+1; %% default of imgaussianfilt3 

GPUobj = gpuDevice;
GPUmem = GPUobj.AvailableMemory;
Margin =  0 ; %(1536) * 2^20;
OneSingleMem = 4;
XYMem = prod(siz(1:2)) * OneSingleMem;
zstack = floor((GPUmem - Margin) / XYMem);
if nargin==4
    LoopNum = varargin{1};
else
    LoopNum = (ceil(siz(3) / zstack)+1) ;
end
Erro_message = 'GPU memory error or Cant those Kernel Size..';
fprintf(1,'#######################################\n     ...Setting up Piece wise data...\n')
TryingTF  = true;
OldZsiz = size(Image,3);
while TryingTF
    try
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CORE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        pw_data = TS_imageprocessing_forpallarelcomputingdata(...
            Image,ones(1,1,KernelSize(3)),LoopNum);        
        if size(pw_data(1).Image,3) < KernelSize(3)
            error(Erro_message)
        end
        if size(pw_data(1).Image,3) == OldZsiz
            error('Same Zsize....')
        else
            OldZsiz = size(pw_data(1).Image,3);
        end
        fprintf(1,'%c',['    Kernel Size : ' num2str(KernelSize)]),fprintf('\n')
        fprintf(1,'%c',['    Loop Num    : ' num2str(LoopNum)]),fprintf('\n')
        fprintf(1,'%c',['    Piece Wise  : ' num2str(size(pw_data(1).Image),'%4d %4d %4d ')]),fprintf('\n')
        fprintf(1,'%c','     ...Start GPU(CUDA) Processing.'),fprintf('\n')
        fprintf(1,'%c','                    Progress in ...  0%')
        if LoopNum==1
            n = 1;
            GPU_Array = gpuArray(single(pw_data(n).Image));
            output = imgaussfilt3(GPU_Array,sigma_array,'Padding','symmetric');
            pw_data(n).Image = gather(output);
            reset(GPUobj)
        else
            NumberLine = 1:LoopNum;
            NumberLine(1:2) = NumberLine([2 1]);
            for n = NumberLine
                GPU_Array = gpuArray(single(pw_data(n).Image));
                output = imgaussfilt3(GPU_Array,sigma_array,'Padding','symmetric');
                pw_data(n).Image = gather(output);
                reset(GPUobj)
                fprintf(1,'\b\b\b\b%3d',round(n/LoopNum*100))
                fprintf(1,'%c','%')    
            end
        end
        fprintf('DONE\n')
        fprintf(1,'%c','       Stacking Piece wise data ...  0%')
        output = [];
        for n = 1:LoopNum
            cat_Image = pw_data(n).Image(:,:,pw_data(n).cut_Ind,:,:);
            output = cat(3,output,cat_Image);
            fprintf(1,'\b\b\b\b%3d',round(n/LoopNum*100))
            fprintf(1,'%c','%')    
        end
        fprintf(' DONE\n#######################################\n')
        TryingTF = false;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CORE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    catch err        
        if strcmpi(err.message,Erro_message)
            error(Erro_message)
        end
%         TFJPN = contains(err.message,' ');
%         TFJPN = false;
%         TFENG = contains(lower(err.message),'out of memory');
%         OutOfMem = or(TFJPN,TFENG);
%         if ~OutOfMem
%             error(Erro_message)
%         end
        fprintf('Ups,, out of memory,,\n')
        disp(['!!! ' err.message])
        reset(GPUobj)
        fprintf('...Change LoopNum \n\n')
        LoopNum = LoopNum + 1;        
    end
end
toc
