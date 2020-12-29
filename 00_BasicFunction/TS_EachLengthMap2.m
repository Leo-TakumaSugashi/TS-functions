function varargout = TS_EachLengthMap2(xyz1,xyz2,Reso)
% Len_map = TS_EachLengthMap(xyz1,xyz2,Reso)
% Input 
%     xyz1 : [x,y,z] matrix, , X-axis
%     xyz2 : [x,y,z] matrix,   Y-axis
%     Resolution :xyz
% output 
%     Len_map  : Each Length Map...
%         
% exapmle,..
%      bw1_dummy = rand(10,10,10) > 0.8;
%      bw2_dummy = rand(10,10,10) > 0.8;
%      s_dummy = regionprops(bw,'Centroid');
%      xyz_dummy = cat(1,s_dummy);
%      Len_map = TS_EachLengthMap(xyz_dummy,[1 1 1]);
%      figure,imagesc(Len_map)
%      axis image, colorbar
%      
% 

%% input check
if size(xyz1,2) == 2
    xyz1 = padarray(xyz1,[0 1],0,'post');
end

if size(xyz2,2) == 2
    xyz2 = padarray(xyz2,[0 1],0,'post');
end

if length(Reso) == 2
    Reso(3) = 0;
end


%% main
Len_map = zeros(size(xyz2,1),size(xyz1,1));
for n = 1:size(xyz1,1)
    select = xyz1(n,:);
    select = repmat(select,[size(xyz2,1) 1]);
    LEN = (xyz2 - select) .* repmat(Reso(1:3),[size(xyz2,1) 1]);
    LEN = sqrt(sum(LEN .^2 , 2));
    Len_map(:,n) = LEN;
end

if nargout == 0
    figure,
    imagesc(Len_map),
    colorbar
    axis image
    xlabel('1st Input Index.')
    ylabel('2nd Input Index.')
else
    varargout{1} = Len_map;
end
% Len_map(Len_map==0) = nan;
     
     