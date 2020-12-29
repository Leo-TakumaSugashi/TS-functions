function output = TS_GaussianFilt2D_GPU(Image,Reso,ObjSize,varargin)
%% output = TS_GaussianFilt(Image,Reso,ObjSize)
% output : single
% Input  : 1 Image
%          2 Reso(X,Y) um/pix.
%          3 ObjSize(X,Y) um
tic
if ndims(Image)>3
    error('Input Image Dim. needs less than 3 dim. ')
else
    siz = size(Image,[1 2 3]);
%     siz(3) = size(Image,3);
end

GaussFil_sigma_coef = 1;
sigma_array = [ObjSize(2)/Reso(2)/(2*sqrt(2*log(2)))*GaussFil_sigma_coef ...
    ObjSize(1)/Reso(1)/(2*sqrt(2*log(2)))*GaussFil_sigma_coef];
KernelSize = 2*ceil(2*sigma_array)+1; %% default of imgaussianfilt3 

GPUobj = gpuDevice;
% GPUmem = GPUobj.AvailableMemory;
% Margin =  0 ; %(1536) * 2^20;
% OneSingleMem = 4;
% XYMem = prod(siz(1:2)) * OneSingleMem;
% zstack = floor((GPUmem - Margin) / XYMem);
% LoopNum = (ceil(siz(3) / zstack)+1) ;
if nargin == 3
    LoopNum = 1;
else
    LoopNum = varargin{1};
end
Erro_message = 'GPU memory error or Cant those Kernel Size..';
fprintf(1,'#######################################\n     ...Setting up Piece wise data...\n')
TryingTF  = true;
zdata = 1:siz(3);
while TryingTF
    try
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CORE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Step = linspace(1,siz(3),LoopNum+1);
        output = zeros(siz,'like',single(1));
        for n = 1:LoopNum
            zind = and(zdata>=(Step(n)),zdata<Step(n+1)+1);
            GPU_Array = gpuArray(single(Image(:,:,zind)));
            outGPU = imgaussfilt(GPU_Array,sigma_array,'Padding','symmetric');
            output(:,:,zind) = gather(outGPU);
            reset(GPUobj)            
        end
        fprintf(' DONE\n#######################################\n')
        TryingTF = false;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CORE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    catch err
        reset(GPUobj)
        keyboard
        if strcmpi(err.message,Erro_message)
            error(Erro_message)
        end
        LoopNum = LoopNum + 1;
        disp(['Next Loop Num.' num2str(LoopNum)])
    end
end
toc
