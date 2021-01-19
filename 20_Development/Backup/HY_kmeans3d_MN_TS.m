function [classim,varargout] = HY_kmeans3d_MN_TS(im,classnum,varargin)
%im‚Í3D
%classnum

% if nargin<3
%     Reso = [1,1,1];
% else
%     Reso = varargin{1};
% end
t = tic;
im = single(im);
ma = max(im(:));
mi = min(im(:));
xq  = linspace(1,2,classnum+2);
center = interp1([1 2], [mi ma], xq);
center = center(2:end-1);
CENTERs = center;
callofend = 0;

while(callofend == 0)
    siz_im1 = size(im);
    siz_im1(4) = classnum;
    siz_im1 = max(siz_im1,1);
    im1 = zeros(siz_im1,'like',single(1));
    for nn = 1:classnum
        im1(:,:,:,nn) = ...
            abs((single(center(nn))*ones(size(im),'like',im)) - im);        
    end    
%     im1 = [];
%     for nn = 1:classnum
%        r = abs((single(center(nn))*ones(size(im),'like',im)) - im);
%         im1 = cat(4,im1,r);
%     end
    
    minproj1 = squeeze(min(im1,[],4));
    ct = zeros(1,classnum);
    bw = false(size(im1));
    for nnn = 1:classnum
        bw(:,:,:,nnn) = (im1(:,:,:,nnn)-minproj1)==0;
        ct(nnn) = mean(im(bw(:,:,:,nnn)));
    end
    
%     ct = [];
%     bw = zeros(size(im1))>0;
%     for nnn = 1:classnum
%         bw1 = (im1(:,:,:,nnn)-minproj1)==0;
%         bw(:,:,:,nnn) = bw1;
%         ave = mean(im(bw(:,:,:,nnn)));
%         ct = cat(2,ct,ave);
%     end
    
    if( sum(eq(center,ct))==classnum )
        center = single(ct);
    CENTERs = cat(1,CENTERs,center);
        callofend = 1;
    end
    center = single(ct);
    CENTERs = cat(1,CENTERs,center);    
end
classim = zeros(size(im),'like',uint8(1)); 
for n = 1:classnum
    classim = classim + uint8(bw(:,:,:,n).*(n-1));
end

% [~,ax1] = MN_subplot2(2,2,0.05,0.05,[1,1]);
%     axes(ax1(1)),imagesc(max(classim,[],3)),axis image off,title('MIP‰æ‘œ xy'),grid on,colormap(jet)
%     axes(ax1(2)),imagesc(fliplr(squeeze(max(classim,[],1)))),axis image off,title('MIP‰æ‘œ zx'),grid on,colormap(jet),colorbar,daspect([Reso(1)/Reso(3),1,1])
%     axes(ax1(3)),imagesc(rot90(squeeze(max(classim,[],2)))),axis image off,title('MIP‰æ‘œ yz'),grid on,colormap(jet),daspect([1,Reso(1)/Reso(3),1])
%     axes(ax1(4)),hold on
% for n = 1:classnum
%     l = CENTERs(:,n);
%     plot(l,'Color',rand(1,3))
% end
% title('kmeans‘ã•\’l‘JˆÚ'),grid on,hold off;



if(nargout>1)
    varargout{1} = CENTERs;
end
if nargout > 2
    varargout{2} = bw;
end

disp('time for kmeans3d')
toc(t)

end