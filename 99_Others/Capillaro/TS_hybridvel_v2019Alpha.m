function [angle,utheta,uvar,TIMEdata,Veldata] = TS_hybridvel_v2019Alpha(...
    inputimg,showimg,saveimg,delx,delt,hi,lineskip,xrange,ID)
% Blood velocity measurement on linescan images based on the paper titled:
% Improved blood velocity measurements with a hybrid image filtering and 
% iterative Radon transform algorithm
% published in:
% Frontiers in Brain Imaging Methods / Frontiers in Neuroscience
% 
% Syntax:
% [angle,utheta,uvar] = hybridvel(inputimg,showimg,saveimg,delx,delt,hi,lineskip,xrange)
% 
% Where,
% inputimg = linescan/space-time image with space in X-axis and time in Y-axis
% showimg = display image comparing the effect of elementwise demeaning,
%   vertical demeaning and 3x3 vertical Sobel filtering
% saveimg = save image in various formats (.fig,.jpg,.eps,.ai)
% delx = DeltaX, microns/pixel
% delt = DeltaT, ms/line
% hi = height of image segment to be processed in pixels
% lineskip = number of lines before next image segment starts
% xrange = 2-element vector specifying range of pixels in space-dimension
%   to use in the image segment
% 
% Outputs:
% angle: [angle(deg), minstep(deg), location(pixel), dels1(deg), deln(deg), %dv/v, iter, irl, speed (mm/s)]
% utheta: angles used to process the image segments
% uvar: variance on Radon transform at each angle at each image segment
% 
% Example:
% The linescan image used in the Figure 9 of the paper named 'fig9im.tif'
% is located in the same folder as this code. This image can be used as:
% [angle,utheta,uvar] = hybridvel(imread('fig9im.tif'),1,[],0.47,1,100,25,[1 125]);
% 
% by Pratik Chhatbar, Kara Lab @ MUSC Neurosciences
% Charleston, SC. 5/29/2013
% chhatbar@musc.edu
% pratikchhatbar@gmail.com

% editor log
% 2019.11.09  T.Niizawa

%% Initialize
imsize = size(inputimg);
inputimg = double(inputimg);
anglineth = 3; 
dvov = 0.1/100; % dv/v to determine minimum step-size
firstthetastep = 45; thetarange = [0 179];
ds = 4; % 4 um streak distance
if exist('showimg','var') && ~isempty(showimg) && showimg, showimg = 1; else showimg = 0; end
if exist('saveimg','var') && ~isempty(saveimg) && saveimg, saveimg = 1; showimg = 1; else saveimg = 0; end
if exist('delx','var') && ~isempty(delx) && delx, else delx = 1; end
if exist('delt','var') && ~isempty(delt) && delt, else delt = 1; end
if exist('hi','var') && ~isempty(hi) && hi, else hi = imsize(1)-2; end
if exist('lineskip','var') && ~isempty(lineskip) && lineskip, else lineskip = hi; end
if exist('xrange','var') && ~isempty(xrange) && length(xrange)<3
    if length(xrange)==1
        wi = xrange; xrange = [1 wi];
    else
        if xrange(1)>imsize(2)-1
            xrange(1)=1;
        end
        if xrange(2)>imsize(2)-1
            xrange(2)=imsize(2)-2;
        end
        if xrange(2)<xrange(1)
            xrange = [xrange(1) xrange(2)];
        end
        wi = xrange(2)-xrange(1)+1;
    end
else
    wi = imsize(2)-2; xrange = [1 wi];
end
if showimg
    imgtitle = {inputname(1);['HybridVel-SEGID ',num2str(ID)]};
end

%% Process the image with different filters
curimtitle = {'Sugashi','Sobel Filter','Frequency Space'}; 
% curcolor = {'b','g','k','r','c','m'};
curcolor = [0 0 1;0 1 0;0 0 0;1 0 0] * 0.6;
% % Demeaned
% imgseg(:,:,1) = inputimg(2:end-1,2:end-1)-mean(mean(inputimg(2:end-1,2:end-1))); % element-wise demean
% h = fspecial('laplacian',.2);
h = [1 2 1; 0.5 0 -0.5; -1 -2 -1];
% h = imresize(h,[3,5]);
% h = h./sum(h(:))
imgseg(:,:,1) = imfilter(inputimg(2:end-1,2:end-1),h); % Sugashi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% imgseg(:,:,2) = bsxfun(@minus,inputimg(2:end-1,2:end-1),...      %%%%%%%
%     mean(inputimg(2:end-1,2:end-1),1)); % vertical demean        %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Sobel
% imgseg(:,:,3) = filter2([1 2 1; 0 0 0; -1 -2 -1],inputimg,'valid');  % 3x3 vertical Sobel filter, Eq. 5,6
imgseg(:,:,2) = filter2([1 2 1; 0 0 0; -1 -2 -1],inputimg,'valid');  % 3x3 vertical Sobel filter, Eq. 5,6
% % Bandpass
min_velo = 50; %microm/sec
th_rad = atan(1/(min_velo/(delx*delt)));
% [f1,f2] = freqspace([imsize(1) imsize(2)],'meshgrid');
% % [x,y] = meshgrid(1:imsize(2),1:imsize(1));
% % x = x - imsize(2)/2;
% % % y = y - imsize(1)/2;
% r = sqrt(f1.^2 + f2.^2);
% % Hd = ones(imsize(1),imsize(2));
% % Hd((r<0.1|(r>0.5))) = 0;
F = fftshift(fft2(inputimg));
% F(r>0.3) = 0;
% F(or(atan(x./y)>th_rad,atan(x./y)<-th_rad)) = 0;

F2 = real(ifft2(ifftshift(F)));
imgseg(:,:,3) = F2(2:end-1,2:end-1);

imgsegsz = size(imgseg);
firstiter = (thetarange(1):firstthetastep:thetarange(2));
firstiter = firstiter-(firstiter(end)-firstiter(1))/2+1;
segend = hi:lineskip:imgsegsz(1);
segstart = segend-hi+1;
segn = length(segstart);
angle = nan(segn,9,imgsegsz(3)); % angle = [angle,minstep,loc(pix),dels1,deln,%dv/v,iter,irl,speed(mm/s)]
utheta = cell(segn,imgsegsz(3)); 
uvar = cell(segn,imgsegsz(3));

%% Iterative Radon transform
tdata = 1:size(inputimg,1);
Markers = 'svod';
LineWidth = 2;
for ii = 1:imgsegsz(3) % eachimg(1: demean 2: sobel 3: Bandpass)
    for jj = 1:segn
        irl = 1; % iterative radon level
        curangle = 0; alltheta = []; allvar = []; iter = 0; thetastep = firstthetastep; curvarmax = 0;
        tind = and(tdata>=segstart(jj),tdata<=segend(jj));
        curimgseg = imgseg(tind,xrange(1):xrange(2),ii);
%         curimgseg = imgseg(segstart(jj):segend(jj),xrange(1):xrange(2),ii);
%         if ii==1
%             curimgseg = curimgseg-mean(curimgseg(:)); % element-wise demean
%         end
%         if ii==2
%             curimgseg = bsxfun(@minus,curimgseg,mean(curimgseg,1)); % vertical demean
%         end
        if ii == 3
%             [f1,f2] = freqspace([size(curimgseg,1) size(curimgseg,2)],'meshgrid');
%             r = sqrt(f1.^2 + f2.^2);
            F = fftshift(fft2(curimgseg));
%             F(r>0.5) = 0;
            curimgseg = real(F);
        end
        
       while irl
            before_irl = irl;
            iter = iter+1;
            % smart iterative radon function with graded angle steps
            if iter==1
                theta = firstiter;
            else
                thetastep = thetastep/2;
                theta = (-3*thetastep+curangle):thetastep*2:(3*thetastep+curangle);
            end
            theta = mod(theta+90,180)-90; % ensures angle range of [-90,+90)
            R = radon(curimgseg,theta); % Eq. 7
            R(R==0) = nan; % avoids influence of non-participant pixels
            alltheta = [alltheta theta];
            
            if ii == 3
            curvar = nansum(R);
            else
            curvar = nanvar(R);
            end
            
            allvar = [allvar curvar];
            [Rvarmaxval,Rvarmaxin] = max(curvar);
            
            if Rvarmaxval>curvarmax
                curangle = theta(Rvarmaxin); % Eq. 8
                curvarmax = Rvarmaxval;
            end
            if irl==1 && thetastep<1 % angle resolution less than 1 deg
                irl=2; % iterative radon level 2, where step-size is decided for given dv/v
                curmpa = abs(atand((dvov+1)*tand(curangle))-curangle); % Eq. 17
                ws = min(wi,ceil(hi*abs(tand(curangle)))); % Eq. 14
                hs = min(hi,ceil(wi*abs(cotd(curangle)))); % Eq. 14
                ns = floor(wi*delx/ds)*(hs==hi)+((hi*delx*ws)/(ds*hs))*(ws==wi); % Eq. 13
                dels1 = abs(atand(ws/hs)-atand((ws-1)/hs)*(ws>hs)-atand(ws/(hs-1))*(ws<=hs)); % Eq. 12
                deln = dels1/ns; % Eq. 11
                
            end
            if irl>1 && thetastep<deln % Eq. 11
                ws = min(wi,ceil(hi*abs(tand(curangle)))); % Eq. 14
                hs = min(hi,ceil(wi*abs(cotd(curangle)))); % Eq. 14
                ns = floor(wi*delx/ds)*(hs==hi)+((hi*delx*ws)/(ds*hs))*(ws==wi); % Eq. 13
                dels1 = abs(atand(ws/hs)-atand((ws-1)/hs)*(ws>hs)-atand(ws/(hs-1))*(ws<=hs)); % Eq. 12
                deln = dels1/ns; % Eq. 11
                if thetastep<deln
                    break
                end
            end
                
            if irl>1 && thetastep<curmpa % Eq. 17
                % actual dv/v calculation
                actdvovper = abs(tand(thetastep+curangle)/tand(curangle)-1)*100; % Eq. 16
                if dvov>actdvovper/100
                    break
                else
                    irl = irl+1;
                    curmpa = atand((dvov+1)*tand(abs(curangle)))-abs(curangle); % Eq. 17
                end
            end
            
       end
        if ii == 3
            curangle = 90 - curangle;
        end
        angle(jj,1,ii) = curangle;
        % actual dv/v 
        actdvovper = abs(tand(thetastep+curangle)/tand(curangle)-1)*100; % Eq. 16
        % deln
        ws = min(wi,ceil(hi*abs(tand(curangle)))); % Eq. 14
        hs = min(hi,ceil(wi*abs(cotd(curangle)))); % Eq. 14
        ns = floor(wi*delx/ds)*(hs==hi)+((hi*delx*ws)/(ds*hs))*(ws==wi); % Eq. 13
        dels1 = abs(atand(ws/hs)-atand((ws-1)/hs)*(ws>hs)-atand(ws/(hs-1))*(ws<=hs)); % Eq. 12
        deln = dels1/ns; % Eq. 11
        angle(jj,2:9,ii) = [thetastep segstart(jj)+hi/2 dels1 deln actdvovper iter irl tand(curangle)*delx/delt];
        % unique angles used for radon and variance measured
        [utheta{jj,ii},um] = sort(alltheta);
        uvar{jj,ii} = allvar(um);
    end
    if showimg
        if ii == 1 
        fgh = figure;
        fgh.Position = [61 123  1600 650];
        end
        % linescan plot with angle
        subplot(6,6,[3+ii 33+ii]);
        imagesc(imgseg(:,:,ii)); axis image; title(curimtitle{ii},'FontSize',20);
        colormap(gray)
        set(gca,'XTickLabel',[],'YTickLabel',[],'FontSize',18);
        hold on;
        for jj=1:segn
        [xp,yp] = pol2cart(mod(angle(jj,1,ii)*pi/180-pi/2,pi),wi/2);
        line(xrange(1)+wi/2+[-xp xp],angle(jj,3,ii)-[-yp yp],'Color','black','LineWidth',anglineth);
        drawnow;
        end
        hold off;
        if ii==1
            ylabel(['\Deltat = ' num2str(round(delt,1)) ...
                ' ms/frame, h = ' num2str(imgsegsz(1)) ' pixels'],'FontSize',20);
        elseif ii==2
            xlabel(['w = ' num2str(wi),...
                ' pixels; \Deltax = ' num2str(round(delx,2)) ' \mum/pixel'],'FontSize',20);
        end
        
        % angle plot
%         subplot(2,imgsegsz(3)*2,+(1:imgsegsz(3)))
        if ii ==1
            axh(1) = subplot(6,6,[1 15]);
            axh(1).Position(4) = 0.34;
            axh(1).Position(2) = 0.57;
            axh(1).Position(1) = 0.1;
        end
         
        plot(axh(1),angle(:,3,ii)*delt,angle(:,1,ii),['-' Markers(ii)],...
            'Color',curcolor(ii,:),'LineWidth',LineWidth); hold on;
        if ii==imgsegsz(3)
            lh = legend(axh(1),curimtitle{1:ii},'Location','best','FontSize',12); 
%             lh.Position = [0.3529    0.4496    0.1409    0.0747];
%             xlabel(axh(1),'time (ms)'); 
            ylabel(axh(1),'\theta (^o)'); hold off
            title (axh(1),imgtitle);
        end
        
        axh(1).XTickLabel = [];    
        % velocity plot
%         subplot(2,imgsegsz(3)*2,imgsegsz(3)*2+(1:imgsegsz(3)))
        if ii ==1
            axh(2) = subplot(6,6,[19 33]);
            axh(2).Position(4) = 0.34;
            axh(2).Position(2) = 0.17;
            axh(2).Position(1) = 0.1;
        end
        plot(axh(2),angle(:,3,ii)*delt,angle(:,9,ii),['-' Markers(ii)],...
            'Color',curcolor(ii,:),'LineWidth',LineWidth); hold on;
        if ii==imgsegsz(3)
%             legend(curimtitle{1:ii},'location','eastoutside'); 
            xlabel(axh(2),'time (ms)'); ylabel(axh(2),'v (mm/s)'); hold off
        end
        
        if saveimg && ii==imgsegsz(3)
            savepath = 'D:\lab stuff\savedRadonImages\';
            saveas(gca,fullfile(savepath,['hybridvel' strcat(imgtitle{:}) 'img' num2str(ii) '.eps']), 'psc2');
            saveas(gca,fullfile(savepath,['hybridvel' strcat(imgtitle{:}) 'img' num2str(ii) '.fig']));
            saveas(gca,fullfile(savepath,['hybridvel' strcat(imgtitle{:}) 'img' num2str(ii) '.jpg']));
            saveas(gca,fullfile(savepath,['hybridvel' strcat(imgtitle{:}) 'img' num2str(ii) '.ai']));
        end
    end  
end
TIMEdata = squeeze(angle(:,3,:)*delt);
Veldata = squeeze(angle(:,9,:));


