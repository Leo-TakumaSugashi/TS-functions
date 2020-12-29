function outdata = TS_RepositionXY_AftDepthAdjGUI(data)
if ~isfield(data,'Shiftmatrix')
    Image1 = data.Image1;
    Image2 = data.Interp_Depth_Image2;
    vy = data.vy;
    shiftmatrix = zeros(length(vy),2);
    outImage2 = zeros(size(Image2),'like',Image2);
    fgh = figure;
    imh = imagesc(Image1(:,:,end,1,1));
    for n = 1:length(vy)
        if ~isnan(vy(n))
            sh = TS_SliceReposition(...
                Image1(:,:,n,1,1),Image2(:,:,n,1,1));
            [~,imB] = TS_Shift2pad_vEachSlice(...
                Image2(:,:,n,:,:),Image2(:,:,n,:,:),...
                sh,'crop');
            outImage2(:,:,n,:,:) = imB;
            imh.CData = rgbproj(cat(3,Image1(:,:,n,1,1),imB),'auto');
            axis image
            drawnow
            shiftmatrix(n,:) = sh;
            clear sh imB
        end
    end
    data.Shiftmatrix = shiftmatrix;
    data.Reposi_Image2 = outImage2;
    outdata = data;
    close(fgh)
else
    disp('Use Input of Shifmatrix')
    Image2 = data.Interp_Depth_Image2;
    outImage2 = zeros(size(Image2),'like',Image2);
    shiftmatrix = data.Shiftmatrix;
    for n = 1:size(shiftmatrix,1)
        sh = shiftmatrix(n,:);
        [~,imB] = TS_Shift2pad_vEachSlice(...
            Image2(:,:,n,:,:),...
            Image2(:,:,n,:,:),...
            sh,'crop');
        outImage2(:,:,n,:,:) = imB;
        clear sh imB
    end
    data.Reposi_Image2 = outImage2;
    outdata = data;
end
    