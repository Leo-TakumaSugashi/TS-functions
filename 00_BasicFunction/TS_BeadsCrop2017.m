function Cropdata = TS_BeadsCrop2017(Image,BeadSize,Reso,CropSize,sptype)
% Cropdata = TS_BeadsCrop2017(Image,BeadSize,Reso,CropSize,sptype)
% 
% switch sptype
%     case {'sp5','photomalti'}
%         
% %% Create Mask 
%         ObjSize = repmat(BeadSize,1,3);
%         [bw,mfImage] = TS_ExtractionObjMask(Image,ObjSize,Reso,'ball');
%     case {'sp8','photocount'}
%         fImage = TS_GaussianFilt3D_parfor(Image,Reso,[BeadSiz BeadSiz BeadSiz+3]);
%         bw = fImage > 1;
%         clear fImage
%         se = fspecial('gaussian',7,1.8);
%         mfImage = imfilter(single(Image),se,'symmetric');        
%     otherwise
%         error('Input Type is NOT Correct')
% end
% 
% old tyep ...
% [Cropdata,NewCropdata] = TS_BeadsCrop(Image,BeadSize,Reso,CropSize)
%     bw = TS_ExtractionObjMask(Image,ObjSize,Reso,'ball');
%     regionprops(bwlabeln(bw,26),'Centroid')
%     TS_centroid2Crop(Image,mfImage,CropSize,Reso,Cent)
%     TS_CropdataEnableCheck(Cropdata)
% 
% function
% Cropdata = TS_centroid2Crop(Image,fImage,CropSize,Reso,Centroid)
%  Input
%    Image  : Original Image
%    fImage : Filtered Image
%    CropSize : [Horizon Vertic Depth] / unit(um)
%    Reso     : [Horizon Vertic Depth] / unit(um/voxels)
%    Centroid : Equal regionprops(L,'centorid')
%                 or [x y z] unit pixels --> cat(1,Centroid.Centroid)
% 
% output 
%     centroidXYZ   : centroid of input Image
%     CenterOfImage : calculate Crop Image of Center by cetroid
%     Image         : Crop Image by input Image
%     fImage        : Crop Image by input Filtered Image(if input is empty, [])
%     Enable        : true ->=> this field for Analysis or not value
%     Reso          : Resolution
% 
% function
% [NewCropdata,Output] = TS_CropdataEnableCheck(Cropdata)
% help TS_centroid2Crop
% NewCropdata : By hand, Checked Enabel ON or OFF
% Output      : Only Enable ON data

switch sptype
    case {'sp5','photomalti'}
        
%% Create Mask 
        ObjSize = repmat(BeadSize,1,3);
        [bw,mfImage] = TS_ExtractionObjMask(Image,ObjSize,Reso,'ball');
    case {'sp8','photocount'}
        fImage = TS_GaussianFilt3D_parfor(Image,Reso,[BeadSize BeadSize BeadSize+3]); % 2017.04.30 by Hachiya
        bw = fImage > 1;
        clear fImage
        se = fspecial('gaussian',7,1.8);
        mfImage = imfilter(single(Image),se,'symmetric');        
    otherwise
        error('Input Type is NOT Correct')
end

%% Morphorogical Filter(Volume)


%% Centroid
L = bwconncomp(bw,26);
Cent = regionprops(L,'Centroid','Area');

%% Crop to Structure 
Cropdata = TS_centroid2Crop(Image,mfImage,CropSize,Reso,Cent);
    
%% Check figure
% [Cropdata,NewCropdata] = TS_CropdataEnableCheck(Cropdata);
    
    