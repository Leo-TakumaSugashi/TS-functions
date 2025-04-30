%% SEGMENT

S_th = 0.05;
depth = ([1:size(Image,3)] - SurfaceInd) * Reso(3);

[L_Pbw,NUM] = bwlabeln(Pbw,26);
if NUM<2^8
    L_Pbw = uint8(L_Pbw);
elseif NUM<2^16
    L_Pbw = uint16(L_Pbw);
end

% Pc = uint32(1);
CropSiz = 60; % um
CropSiz_pix = CropSiz/Reso(1);
xdata = 1:size(Image,2);
ydata = 1:size(Image,1);
zdata = 1:size(Image,3);

ReductMask = Pbw;
ParentPdata.Input_Size = size(Pbw);
ParentPdata.Input_Resolution = LNewReso;
ParentPdata.Original_Size = size(Image);
ParentPdata.Original_Resolution = Reso;
PPdata = struct('Segment',[]); % 
%%

% fgh = figure;
%     im = mfImage(:,:,1);
%         x_ind = and(xdata>=1,xdata<=10000);
%         y_ind = and(ydata>=1,ydata<=10000);            
% imh = imagesc(im(y_ind,x_ind));axis image,
% hold on
% plh = plot(1,1,'*');

for n = 1:NUM
    ExPbw = L_Pbw==n;
    ExBranch = and(Branch,imdilate(ExPbw,ones(3)));
    ParentMask = false(size(ExPbw));
    MaxMask = [];
    Pdata = struct('PointXYZ',[],'PointXYZum',[],'Branch_um',[]); %  point--->[Y X Z]
    c = uint32(1);
    for k = 1:size(ExPbw,3)
        % Boldest Vessels is Parent 
        sExPbw = ExPbw(:,:,k);
        sExBranch = ExBranch(:,:,k);
        if max(sExPbw(:)) == false
            continue            
        else            
            [sl,num] = bwlabel(sExPbw);
            s = regionprops(sl,'Area','Centroid');
            %% Maskを深い箇所からセグメントしていく。
               % もしスライスに2つ以上のマスクがあれば、先ずは面積の大きい方を優先。
               % しかし、前のスライスに優先的に選択したエリアがあれば、そちらを選択。
            if num>1
                try
                    Pre_xyz_ori = Pdata(c-1).PointXYZ_Original;
                    Pre_xyz_ori(3) = [];
                    xy = (cat(1,s.Centroid) -1) .*LNewReso(1:2);
                    xy = xy ./Reso(1:2) + 1;
                    LEN = xy - repmat(Pre_xyz_ori,[size(xy,1) 1]);
                    LEN =  sqrt(sum(LEN.^2,2));
                    [~,Ind] = min(LEN);                    
                catch err                    
                    Area = cat(1,s.Area);
                    [~,Ind] = max(Area);                    
                end
                sl_max = sl == Ind(1);
            else
                Ind = 1;
                sl_max = sl == 1;
            end
             ParentMask(:,:,k) = sl_max;             
            xyz = [s(Ind(1)).Centroid k];
            xyz_um = (xyz-1) .* LNewReso;
            xyz_orig = round(xyz_um ./Reso + 1);
            
            % % Branch point
            sExBranch = and(imdilate(sl_max,ones(3)),sExBranch);
            Branch_TF = max(sExBranch(:)) == true;
            
            % % Crop
            im = mfImage(:,:,k);
            x_ind = and(xdata>=xyz_orig(1)-CropSiz_pix/2,...
                xdata<=xyz_orig(1)+CropSiz_pix/2);
            y_ind = and(ydata>=xyz_orig(2)-CropSiz_pix/2,...
                ydata<=xyz_orig(2)+CropSiz_pix/2);
            %% Caluculate Diam 
            %%　本当に血管が1つしかないかの確認
            im = double(im(y_ind,x_ind));
            S = sort(im(:),'descend');
            S = mean(S(1:round(length(S)*S_th)));
            N = mode(im(and(im>0,im<S)));
%             Ell_Th = TS_EllipticFittingThreshold(S,N);
%             Ell_bw = TS_GetMaxArea(im >= Ell_Th);
            Ell_bw = TS_GetMaxArea(im >= (S-N)*0.5 + N);
                        
            if Branch_TF
                Ell_bw = TS_EllipticFittingWatershed_proto(Ell_bw,10,Reso);
            end
            EdgeTF = max([max(Ell_bw(1,:)) max(Ell_bw(end,:)) ...
                max(Ell_bw(:,1)) max(Ell_bw(:,end))]); 
            if EdgeTF
                EdgeLine = TS_GetEdgeLine(Ell_bw);
                [ey,ex] = find(EdgeLine);
                s = ellipse_fit(ex,ey);
            else
                s = regionprops(Ell_bw,...
                    'MajorAxisLength','MinorAxisLength','Centroid','Orientation');
            end
            im = max((im- N)./(S - N),0);
            im = min(im,1);
            SNR = round(S/N * 10) /10;
            snrdb = round(10*log10(S/N) * 10) /10;
            
            fgh = figure('Posi',[50 200 500 500]);
            axes('posi',[0.01 0.02 1 .8])
            imagesc(rgbproj(cat(3,im,im,im,Ell_bw))),
            axis image off
            colorbar
            title({['Label ' num2str(n) '-' num2str(c) ' Th: 50%'];...
                ['SNR = ' num2str(SNR) ' (' num2str(snrdb) ' [dB]),' ...
                ' Depth:' num2str(depth(k)) ' um'];
                ['Diameter ' num2str(s.MinorAxisLength * Reso(1)) ' um']})            
            [x,y] = TS_EllipesOrientation(s);
            hold on
            plot(x,y)
            plot(s.Centroid(1),s.Centroid(2),'xr','MarkerSize',5)
            saveas(fgh,['Label_' num2str(n) '_Depth' num2str(round(depth(k))) '.fig'],'fig')
            saveas(fgh,['Label_' num2str(n) '_Depth' num2str(round(depth(k))) '.tif'],'tif')
            drawnow
%             waitfor(fgh)
            close(fgh)
            
              if Branch_TF
                  bs = regionprops(sExBranch,'Centroid');
                  Branch_xyz = [cat(1,bs.Centroid) repmat(k,[length(bs) 1])];
                  Branch_xyz_um = (Branch_xyz-1) .* LNewReso;
                  Branch_xyz_orig = round(Branch_xyz_um ./Reso + 1);
                  Pdata(c).Branch_um = Branch_xyz_um;
                  % % Check
%                   bplh = plot(Branch_xyz_orig(:,1),Branch_xyz_orig(:,2),'xr');
              end
              xyz_orig = [s(1).Centroid k];
              xyz_um = (xyz_orig -1) .*Reso;
            Pdata(c).PointXYZ = [];
            Pdata(c).PointXYZum = xyz_um;
            Pdata(c).PointXYZ_Original = xyz_orig;
            Pdata(c).Signal = S;
            Pdata(c).Noise = N;
            Pdata(c).Diameter = s(1).MinorAxisLength * Reso(1);
            Pdata(c).Branch_TF = Branch_TF;
            Pdata(c).Edge_TF = EdgeTF;
            Pdata(c).RegionInf = s;
            c = c + 1;
            
              
             % % Check
%              im = mfImage(:,:,k);
%              im(~y_ind,~x_ind) = nan;
%             imh.CData = im;
%              xf = find(x_ind);
%              yf = find(y_ind);
%              caxis([mode(double(im(:))) double(max(im(:)))])
%              xlim([xf(1) xf(end)])
%              ylim([yf(1) yf(end)])
%             plh.XData = xyz_orig(1);
%             plh.YData = xyz_orig(2);
%             
%               title(['L =' num2str(n) '/ slice num =' num2str(num) ', Depth:' num2str(k)])
%               drawnow
%             pause(.1),
            
%             if Branch_TF
%                 delete(bplh)
%                 clear bplh
%             end
            
          
        end
    end
    PPdata(n).Segment = Pdata;
    LEN = cat(1,Pdata.PointXYZum);
    LEN =  sum(sqrt(sum(diff(LEN,1,1).^2,2)));
    PPdata(n).Length = LEN;
    PPdata(n).Type = 'Penetrating';
    ReductMask(ParentMask) = false;
%     'Type','Penetrating','Length',[],%
end
