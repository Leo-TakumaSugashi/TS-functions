function [output,LoopNum] = TS_fevalimprocessing3D_GPU(fname,zKernelSize,LoopNum,varargin)
% output = TS_fevalimprocessing3D_GPU(fname,zKernelSize,LoopNum,varargin)
%  
% example,,,
%  oImage = TS_fevalimprocessing3D_GPU('imopen',3,1,Image,strel('ball',1,1,0));
%  
%  Created by Sugashi, 2019,07,08


tic
Image = varargin{1};
if ndims(Image)~=3
    if or(isscalar(Image),isvector(Image))
        error('Input Image is scalor or vector')
    end
    siz = size(Image);
    siz(3) = size(Image,3);
    siz(4) = size(Image,4);
    Image = reshape(Image,[siz(1) siz(2) siz(3) prod(siz(4:end))]);
    output = zeros(size(Image),'like',single(1));
    for T = 1:size(Image,4)
        [pwdata,LoopNum] = TS_fevalimprocessing3D_GPU(fname,zKernelSize,LoopNum,Image(:,:,:,T),varargin{2:end});
        output(:,:,:,T) = pwdata;
    end
    output = reshape(output,siz);
    return
end
KernelSize = ones([1,1,zKernelSize]);

GPUobj = gpuDevice;
Erro_message = 'GPU memory error or Cant those Kernel Size..';
fprintf(1,'#######################################\n     ...Setting up Piece wise data...\n')
TryingTF  = true;
while TryingTF
    try
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CORE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        pw_data = TS_imageprocessing_forpallarelcomputingdata(...
            Image,KernelSize,LoopNum);
        if size(pw_data(1).Image,3) < size(KernelSize,3)
            error(Erro_message)
        end
        fprintf(1,'%c',['    Kernel ZSize: ' num2str(size(KernelSize,3))]),fprintf('\n')
        fprintf(1,'%c',['    Loop Num    : ' num2str(LoopNum)]),fprintf('\n')
        fprintf(1,'%c',['    Piece Wise  : ' num2str(size(pw_data(1).Image),'%4d %4d %4d ')]),fprintf('\n')
        fprintf(1,'%c','     ...Start GPU(CUDA) Processing.'),fprintf('\n')
        fprintf(1,'%c',['          ' fname ' Progress in ...  0%'])
        for n = 1:LoopNum    
            GPU_Array = gpuArray(pw_data(n).Image);
            output = feval(fname,GPU_Array,varargin{2:end});
            pw_data(n).Image = gather(output);
            reset(GPUobj)
            fprintf(1,'\b\b\b\b%3d',round(n/LoopNum*100))
            fprintf(1,'%c','%')    
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
        
        fprintf('\nUps,, out of memory,??\n')      
        disp(['!!! ' err.message])
        reset(GPUobj)
        fprintf('...Change LoopNum \n\n')
        LoopNum = LoopNum + 1;        
    end
end
toc
