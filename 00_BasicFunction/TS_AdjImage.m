function [output,varargout] = TS_AdjImage(Image,varargin)
% [output,Signal,Noise] = TS_AdjustImage(Image)
% [output,Signal,Noise] = TS_AdjustImage(Image,Reso,'figure')
% input:Image 3Dimage --> Input is enable ndims... but you can not view
%  Signal and Noise...
% output:Adjusted Image by Signal and Noise Ratio (class : uint8)
%        Signal Maximum value of Each slice
%        Noise ... mode value of Each slice except minimum and maximum*Signal_Coef in whole slice
%               (Noise is ,,,��Â̓�l����CFalse�̈�̍ŕp�l���擾)
%      edit ... Nose Term 2017 01 07
%          bw = imbinarize(im,graythrersh(im));
%          N = mode(im(and(im>0,bw)));

Signal_Coef = 0.95; %%

%% nargin check
if nargin>1 ,  Reso = varargin{1};
else     Reso = ones(1,3);
end
if nargin>2 
    if and(strcmpi(varargin{2},'figure'),ndims(Image)==3)
        FigureON = true;
    else
        FigureON = false;
    end
else
    FigureON = false;
end
Reso(isnan(Reso)) = 1;
Reso(isinf(abs(Reso))) = 1;

%% Waitbar
 Mfile_Name = mfilename;
    Mfile_Name(Mfile_Name=='_') = ' ';
%  wh = waitbar(0,...
%      ['wait...Analysis Signal(Max.) and Noise(mode(0<image<Max.' num2str(Signal_Coef)  '))']);
%     set(wh,'name',Mfile_Name)
%     drawnow

%% ndims check
if ndims(Image)>3
    siz = size(Image);
    [y,x,z,num] = size(Image);
    Image = reshape(Image,y,x,z,num);
    output = zeros(y,x,z,num,'Like',uint8(1));
    for nd = 1:num
        output(:,:,:,nd) = TS_AdjImage(squeeze(Image(:,:,:,nd)),varargin{:});
%         waitbar(nd/num,wh)
    end
    output = reshape(output,siz);
%     close(wh)
    drawnow
else
%% Main Func
    siz_z = size(Image,3);
    S = zeros(siz_z,1);
    N = zeros(siz_z,1);
    
   
    %% Analysis S and N
%    disp('Analysis S and N')
%    NumelsXY = numel(Image(:,:,1,1,1));
    if ~isempty(gcp('nocreate'))
        parfor n = 1:siz_z
            im = double(Image(:,:,n));
            bw = imbinarize(Image(:,:,n),graythresh(Image(:,:,n)));
            if sum(bw(:)) == 0
                continue
            end
            sort_im = sort(im(bw));
    %         S(n) = mean(sort_im(round(NumelsXY * Signal_Coef ):end));
            S(n) = mean(sort_im(round(length(sort_im) * Signal_Coef ):end));
    %         N(n) = mode(im(and(im>0,~bw)));
    %         N(n) = TS_GetBackgroundValue(im);
            N(n) = mode(im(and(im>0,im<S(n))));
    %         N(n) = mode(round(im(and(~bw,im>0))*10)/10)
        end

    else

        for n = 1:siz_z
            im = double(Image(:,:,n));
            bw = imbinarize(Image(:,:,n),graythresh(Image(:,:,n)));
            if sum(bw(:)) == 0
                continue
            end
            sort_im = sort(im(bw));
    %         S(n) = mean(sort_im(round(NumelsXY * Signal_Coef ):end));
            S(n) = mean(sort_im(round(length(sort_im) * Signal_Coef ):end));
    %         N(n) = mode(im(and(im>0,~bw)));
    %         N(n) = TS_GetBackgroundValue(im);
            N(n) = mode(im(and(im>0,im<S(n))));
    %         N(n) = mode(round(im(and(~bw,im>0))*10)/10)
        end
    end
    N(isnan(N)) = 0;

    %% Adjust Image for S
%     disp(' .  . .  . ...Adjust Image from N to S....')
    output = zeros(size(Image),'Like',uint8(1));
%     waitbar(0,wh,['wait...Now Adjusting Image...  ' Mfile_Name]);
    if ~isempty(gcp('nocreate'))
        parfor n = 1:siz_z
            im = double(Image(:,:,n));
            im = uint8((im-N(n))/(S(n) - N(n)) * 255);
            output(:,:,n) = im;
        end
    else
        for n = 1:siz_z
            im = double(Image(:,:,n));
            im = uint8((im-N(n))/(S(n) - N(n)) * 255);
            output(:,:,n) = im;
        end
    end
%     close(wh)
%     drawnow
    if nargout>1,  varargout{1} = S; end
    if nargout>2,  varargout{2} = N; end
end

%% Check figure
if FigureON
fgh = figure('Posi',[10 10 900 900]);
 centerfig(fgh)

axes('posi',[.1 .69 .85 .3])
    plot(S,'r.:')
    hold on
    plot(N,'k.:')
    legend('Signla : maximum','Noise : mode value(min, max,)'...
        ,'location','Best')    
    grid on 
    axis tight
    xlabel('each slice')
    ylabel('pixels value [a.u.]')
    
ydata = (0:size(Image,2)-1) * Reso(2);
zdata = (0:size(Image,3)-1) * Reso(3);
axes('posi',[0.05 .33 .9 .3])
    imagesc(squeeze(max(Image,[],2)),'Xdata',zdata,'Ydata',ydata),
    axis('image')
    colormap(gray)
    colorbar
axes('posi',[0.05 .01 .9 .3])
    imagesc(squeeze(max(output,[],2)),'Xdata',zdata,'Ydata',ydata),
    axis('image')
    colorbar
drawnow
end

    
