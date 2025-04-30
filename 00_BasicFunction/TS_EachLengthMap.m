function Len_map = TS_EachLengthMap(xyz,Reso,varargin)
% Len_map = TS_EachLengthMap(xyz,Reso,varargin)
% Input 
%     xyz : [x,y,z] matrix,
%     Resolution :xyz
%     varargin{1] ; Type (default is 3D) or 2D 
% output 
%     Len_map  : Each Length Map...
%         
% exapmle,..
%      bw_dummy = rand(10,10,10) > 0.8;
%      s_dummy = regionprops(bw,'Centroid');
%      xyz_dummy = cat(1,s_dummy);
%      Len_map = TS_EachLengthMap(xyz_dummy,[1 1 1]);
%      figure,imagesc(Len_map)
%      axis image, colorbar
%      
% 
if size(xyz,2) ==2 
    warning([mfilename ' .. Caluculate Distance of 2D'])
end
if nargin==3
    type = varargin{1};
else
    type = '3D';
end
switch type
    case '2D'
        xyz(:,3) = 0;
end

Len_map = zeros(size(xyz,1));
for n = 1:size(xyz,1)
    select = xyz(n,:);
    select = repmat(select,[size(xyz,1) 1]);
    LEN = (xyz - select) .* repmat(Reso(1:3),[size(xyz,1) 1]);
    LEN = sqrt(sum(LEN .^2 , 2));
    Len_map(:,n) = LEN;
end
Len_map(Len_map==0) = nan;
     
     