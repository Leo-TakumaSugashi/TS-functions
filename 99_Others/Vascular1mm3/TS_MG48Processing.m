function A = TS_MG48Processing(Image,Reso,varargin)
% This Function Is For MG48 1mm^3 Vascular data
% And, be Used to The Script ...
% \\TS-QVHL1D2\usbdisk3\Sugashi\10_Since2016\21_Expe\20170223_MG48_1mm3\20170223\MatFile
%  MG48_Load_Original_and_Processed

% A = Image;
% return

ObjSize = [3 3 6];
Image = Image(:,:,:,:,:);
Image = TSmedfilt2(Image,[3 3]);
Image = TS_GaussianFilt3D_parfor(Image,Reso,ObjSize);
if nargin==3
    Div = varargin{1};
    Image = Image ./single(Div);
end
% Image = TS_ShadingImage(Image,Reso);
A = TS_AdjImage(Image);

% Infomation = {...
% 'ObjSize = [3 3 6];';
% 'Image = Image(:,:,:,1,1);';
% 'Image = TSmedfilt2(Image,[3 3]);';
% 'Image = TS_GaussianFilt3D_parfor(Image,Reso,ObjSize);';
% 'Image = Image ./ Div; ( Div is Each Locations Value. Div. =  mean(deep(:,:,1:10),3);';
% '   Div. save dir. \\TS-QVHL1D2\usbdisk3\Sugashi\10_Since2016\21_Expe\20170223_MG48_1mm3\20170223\MatFile\Location_warped';
% 'Image = TS_ShadingImage(Image,Reso);';
% 'A = TS_AdjImage(Image);'}

