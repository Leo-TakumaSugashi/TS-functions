function [BW,bw] = TS_PreSkeleton_v2019_sp8(Emphasized_Cap,Emphasized_Penet,Reso,varargin)
% [BW,bw] = TS_PreSkeleton_v2019_sp8(Emphasized_Cap,Emphasized_Penet,Reso,varargin)
% Input 
%     Emphasized_cap , 3D Image
%     Emphasized_Penet , 3D Image
%     Reso     :  Resolution of X Y Z (um/ vox.)
%     HoleSiz_Radius .... default 10 um.
% Output 
%     BW       : For Pre- Skeleton data
%     bw       : max(bw_cap,bw_Penet)
% 
% %%%%%%%%%%%% Core Coefficient.. From Takeda Hiroshi Experience,%%%%%%%%%
%  level = 0.2; %% core method ,,, Threshold = (S-N)* level + N
%  bw = TH_SNmask_v2019a(Image,level),, at using point.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This Function is included TS_AtVasMes....
%     see all so TS_AtVasMeas_Flow_2019b ,TH_SNmask_v2019a
% 
% Edit, 2019,06,30 by Sugashi.T

%% Input check and Initialize
if nargin ==4
    HoleSiz_Radi = varargin{1};
else
    HoleSiz_Radi = 10; %% um
end
HoleSiz =round( (HoleSiz_Radi/Reso(1))*(HoleSiz_Radi/Reso(2))*pi );
HoleSiz_volume =round( (HoleSiz_Radi/Reso(1)) * ...
                (HoleSiz_Radi/Reso(2)) * ...
                (HoleSiz_Radi/Reso(3)) * 4/3 *pi );
%% Binalization
TH_SNmask_level = 0.2; %% core method ,,, Threshold = (S-N)* "level" + N
bw1 = TH_SNmask_v2019a(Emphasized_Cap,TH_SNmask_level);
bw2 = TH_SNmask_v2019a(Emphasized_Penet,TH_SNmask_level);
bw = max(bw1,bw2);

%% main func.
BW = bw;
% % at 1st,for  each slice (2D)
for n = 1:size(bw,3)
    im = bw(:,:,n);
    im = imfill(im,'holes');
    BW(:,:,n) = im;clear im
end

% % if large hole(s) is NOT necessary fill.So check hole size. and return
bw_areaopen = and(~bw,BW);
for n = 1:size(bw,3)
    im = bw_areaopen(:,:,n);
    im = bwareaopen(im,HoleSiz);
    slice_bw = BW(:,:,n);
    slice_bw(im) = false;    
    BW(:,:,n) = slice_bw;
end

%% Remove small object.
BW = bwareaopen(BW,HoleSiz_volume,26);

%% fill for 3D volume
BW = imfill(BW,'holes');
