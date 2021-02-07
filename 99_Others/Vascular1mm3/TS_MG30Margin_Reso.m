function [output1,output2] = TS_MG30Margin_Reso(Order,Reso,Image1,Image2)

% if length(varargin) ~= numel(Order)
%     error('Input Order Numel and Image-data is Not Match');
% end
Magni = Reso(3) / Reso(1);
MIPnum =  round(50 / Reso(3));
overlap = 20 ; %% ;um
overlap = round(overlap / Reso(1)); %% Term : Reso X == Y,

%% horizon
switch lower(Order)
    case 'horizon'
        if size(Image1,3) > size(Image2,3)
            Image2 = padarray(Image2,[0 0 size(Image1,3)-size(Image2,3)],0,'pre');
        elseif size(Image1,3) < size(Image2,3)
            Image1 = padarray(Image1,[0 0 size(Image2,3)-size(Image1,3)],0,'pre');
        end
        im1 = squeeze(max(Image1(:,end-overlap:end,:,1,1),[],2));
        im2 = squeeze(max(Image2(:,1:overlap,:,1,1),[],2));

        shiftmatrix_YZ = TS_SliceReposition(im1,im2);
%         [ims1,ims2] = TS_Shift2pad_vEachSlice(im1,im2,shiftmatrix_YZ);
%         figure,imagesc(rgbproj(cat(3,ims1,ims2)))
        if shiftmatrix_YZ(2) <0
            Image1 = padarray(Image1,[0 0 abs(shiftmatrix_YZ(2))],0,'Pre');
            Image2 = padarray(Image2,[0 0 abs(shiftmatrix_YZ(2))],0,'Post');
        elseif shiftmatrix_YZ(2) >0            
            Image1 = padarray(Image1,[0 0 abs(shiftmatrix_YZ(2))],0,'Post');
            Image2 = padarray(Image2,[0 0 abs(shiftmatrix_YZ(2))],0,'Pre');
        end
        if shiftmatrix_YZ(1) <0
            Image1 = padarray(Image1,[abs(shiftmatrix_YZ(1)) 0 0],0,'Pre');
            Image2 = padarray(Image2,[abs(shiftmatrix_YZ(1)) 0 0],0,'Post');
        elseif shiftmatrix_YZ(2) >0            
            Image1 = padarray(Image1,[abs(shiftmatrix_YZ(1)) 0 0],0,'Post');
            Image2 = padarray(Image2,[abs(shiftmatrix_YZ(1)) 0 0],0,'Pre');
        end
        
        % %  XY
%         Depth = size(Image1,3):-1:MIPnum+1;
%         Shift_matrix = zeros(length(Depth)-1,2);
%         adj1 = TS_AdjImage(Image1(:,:,:,1,1));
%         adj2 = TS_AdjImage(Image2(:,:,:,1,1));
%         for n = 1:length(Depth)-1
%             im1 = squeeze(max(adj1(:,end-overlap+1:end,Depth(n)-MIPnum:Depth(n)),[],3));
%             im2 = squeeze(max(adj2(:,1:overlap,Depth(n)-MIPnum:Depth(n)),[],3));
%             shiftmatrix = TS_SliceReposition(im1,im2);
%             Shift_matrix(n,:) = shiftmatrix;
%         end
%         figure,plot(Shift_matrix)
        
        
        %%
        load('MG30_XYshiftmatrix.mat','Sh_12')
        [output1,output2] = TS_Shift2pad_vEachSlice(Image1,Image2,Sh_12);
        
        
    case 'verticle'
    otherwise
        error('Input Order is NOT correct')
end
        % % Reposition
%         [ims1,ims2] = TS_Shift2pad_vEachSlice(ims1,ims2,shiftmatrix);        
%         figure,imagesc(rgbproj(cat(3,ims1,ims2)))
        