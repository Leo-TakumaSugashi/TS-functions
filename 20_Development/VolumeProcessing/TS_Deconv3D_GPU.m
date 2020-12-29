function [output,LoopNum] = TS_Deconv3D_GPU(Image,PSF,varargin)
%% output = TS_Deconv3D_GPU(Image,PSF,{loopNUM})
% output : single
% Input  : 1 Image
%          2 PSF(X,Y,Z) voxles data
% edit Input ndims Image can processe.. by sugashi, 2019,09,23

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
        [pwdata,LoopNum] = TS_Deconv3D_GPU(Image(:,:,:,T),PSF,LoopNum);
        output(:,:,:,T) = pwdata;
    end
    output = reshape(output,siz);
    fprintf('  ---> Total ')
    toc(Time4D)
    return
else
    KernelSize = [size(PSF,1),size(PSF,2),size(PSF,3)];
    PadSiz = floor( KernelSize/2 );
    Image = padarray(single(Image),PadSiz,'symmetric');
    Image = Image./max(Image(:));
    siz = size(Image);
end


GPUobj = gpuDevice;
GPUmem = GPUobj.AvailableMemory;
Margin =  300 * 2^20;
Processing_Value = 4;
OneSingleMem = 4;
XYMem = prod(siz(1:2)) * OneSingleMem;
zstack = floor((GPUmem - Margin) / (XYMem * Processing_Value));
if nargin==3
    LoopNum = varargin{1};
else
    LoopNum = (ceil(siz(3) / zstack)) ;
end
Erro_message = 'GPU memory error or Cant those Kernel Size..';
fprintf(1,'#######################################\n     ...Setting up Piece wise data...\n')
TryingTF  = true;
OldZsiz = size(Image,3);
while TryingTF
    try
       %% %%%%%%%%%%%%%%%%%%%%%%%%%%% CORE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        pw_data = TS_imageprocessing_forpallarelcomputingdata(...
            Image,ones(1,1,KernelSize(3)),LoopNum,'noImage');        
        if size(Image(:,:,pw_data(1).Index),3) < KernelSize(3)
            error(Erro_message)
        end
        if size(Image(:,:,pw_data(1).Index),3) == OldZsiz
            error('Same Zsize....')
        else
            OldZsiz = size(Image(:,:,pw_data(1).Index),3);
        end
        fprintf(1,'%c',['    Kernel Size : ' num2str(KernelSize)]),fprintf('\n')
        fprintf(1,'%c',['    Loop Num    : ' num2str(LoopNum)]),fprintf('\n')
        fprintf(1,'%c',['    Piece Wise  : ' ...
            num2str(size(Image(:,:,pw_data(1).Index)),'%4d %4d %4d ')]),fprintf('\n')
        fprintf(1,'%c','     ...Start GPU(CUDA) Processing.'),fprintf('\n')
        fprintf(1,'%c','                    Progress in ...  0%')
        output = zeros(size(Image),'like',single(1));
        for n = 1:LoopNum             
            pwImage = TS_deconvlucy(...
                gpuArray(single(Image(:,:,pw_data(n).Index))),...
                gpuArray(single(PSF)));
            output(:,:,pw_data(n).Index(pw_data(n).cut_Ind)) = pwImage(:,:,pw_data(n).cut_Ind);
            fprintf(1,'\b\b\b\b%3d',round(n/LoopNum*100))
            fprintf(1,'%c','%')    
        end         
        output = output(...
            PadSiz(1)+1:end-PadSiz(1),...
            PadSiz(2)+1:end-PadSiz(2),...
            PadSiz(3)+1:end-PadSiz(3));
        fprintf(' DONE\n#######################################\n')
        TryingTF = false;
%% %%%%%%%%%%%%%%%%%%%%%%%%%% CORE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    catch err
        if strcmpi(err.message,Erro_message)
            error(Erro_message)
        end
%         TFJPN = contains(err.message,' ');
        TFJPN = true;
        TFENG = contains(lower(err.message),'out of memory');
        OutOfMem = or(TFJPN,TFENG);
        if ~OutOfMem
            error(Erro_message)
        end
%         fprintf('Ups,, out of memory,,\n')
        disp(['!!! ' err.message])
        reset(GPUobj)
%         fprintf('...Change LoopNum \n')
        LoopNum = LoopNum + 1;
%         keyboard
    end
end
toc
%% 



