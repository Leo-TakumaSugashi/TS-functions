% Analysis_Original = mfImage(305:305+224,800:800+224,:);
% Anaylsis_Image = oImage(305:305+224,800:800+224,:);
% [bw,~,~,OpenVess,adjopenvess] = TS_ExtractionObj2Mask(oImage,objsiz,Reso,'cylinder');
% Pbw = bw(305:305+224,800:800+224,:);
% Pbw = imopen(Pbw,true(1,1,50));

c = 1;
Depth = 0:Reso(3):803;
dilatesiz = strel('disk',round(10/Reso(1)),0);
Osiz = 10; %% Penetrating Open size (um)
% Analysis_Original = flip(Analysis_Original,3);
for n = 12:161
    bw_slice = imdilate(Pbw(:,:,n),dilatesiz);
    im_slice = Analysis_Original(:,:,n);
%     figure,imagesc(im_slice)
%     figure,imagesc(uint16(bw_slice).*im_slice)
    S = sort(double(im_slice(:)));
%     S = sort(double(im_slice(bw_slice)));
    S = mean(S(round(length(S)*0.95):end));
    N = double(mode(im_slice(im_slice>0)));
    im_slice(~bw_slice) = nan;
    bw_slice = (double(im_slice) - N) / (S - N) >= 0.5;
    bw_slice = TS_GetMaxArea(bw_slice);
    bw_slice = TS_EllipticFittingWatershed_proto(bw_slice,Osiz,Reso);
    % centroid for signal
    s = regionprops(bw_slice,'Centroid');
    s = round(s.Centroid);
    S = Analysis_Original(s(2)-1:s(2)+1,s(1)-1:s(1)+1,n-1:n+1);
    S = mean(S(:));
    TH = TS_EllipticFittingThreshold(S,N);
    bw_slice = im_slice >= TH;
    bw_slice = TS_GetMaxArea(bw_slice);
    try
        bw_slice = TS_EllipticFittingWatershed_proto(bw_slice,Osiz,Reso);
    catch
        try
            bw_slice = TS_EllipticFittingWatershed_proto(bw_slice,4,Reso);
        catch err
            disp(err)
        end
    end
     Ed1 = bw_slice([1 size(bw_slice,1)],:);
     Ed2 = bw_slice(:,[1 size(bw_slice,2)]);
     if or(max(Ed1(:)),max(Ed2(:))) %% Exist Edge of Image
         Edgebw = TS_GetEdgeLine(bw_slice);
         [y,x] = ind2sub(size(bw_slice),find(Edgebw(:)));
         a = ellipse_fit(x,y);
         clear Edgebw         
         fgh = figure;imagesc(im_slice);axis image off
         hold on
         [vx,vy] = TS_EllipesOrientation(a);
         p = plot(x,y,'o','Markersize',5);
         p(2) = plot(vx,vy,'-','Color','r');
         drawnow
         pause(.5),
         close(fgh)         
     else
         a = regionprops(bw_slice,'MinorAxisLength','MajorAxisLength','Centroid','Orientation');         
     end
     
     
     %%output
     Pdata(c).Centroid = [a.Centroid n];
     Pdata(c).Diameter = a.MinorAxisLength * Reso(1);
     Pdata(c).Signal = S;
     Pdata(c).Noise = N;
     Pdata(c).Threshold = TH;
     c = c + 1;
     clear a x y Ed1 Ed2 bw_slice TH S N s im_slice p
end