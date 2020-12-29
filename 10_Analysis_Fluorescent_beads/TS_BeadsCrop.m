function [Cropdata,NewCropdata] = TS_BeadsCrop(Image,BeadSize,Reso,CropSize)
[Cropdata,NewCropdata] = TS_BeadsCrop(Image,BeadSize,Reso,CropSize)
    bw = TS_ExtractionObjMask(Image,ObjSize,Reso,'ball');
    regionprops(bwlabeln(bw,26),'Centroid')
    TS_centroid2Crop(Image,mfImage,CropSize,Reso,Cent)
    TS_CropdataEnableCheck(Cropdata)

function
Cropdata = TS_centroid2Crop(Image,fImage,CropSize,Reso,Centroid)
 Input
   Image  : Original Image
   fImage : Filtered Image
   CropSize : [Horizon Vertic Depth] / unit(um)
   Reso     : [Horizon Vertic Depth] / unit(um/voxels)
   Centroid : Equal regionprops(L,'centorid')
                or [x y z] unit pixels --> cat(1,Centroid.Centroid)

output 
    centroidXYZ   : centroid of input Image
    CenterOfImage : calculate Crop Image of Center by cetroid
    Image         : Crop Image by input Image
    fImage        : Crop Image by input Filtered Image(if input is empty, [])
    Enable        : true ->=> this field for Analysis or not value
    Reso          : Resolution

function
[NewCropdata,Output] = TS_CropdataEnableCheck(Cropdata)
help TS_centroid2Crop
NewCropdata : By hand, Checked Enabel ON or OFF
Output      : Only Enable ON data


% Create Mask 
ObjSize = repmat(BeadSize,1,3);
[bw,mfImage] = TS_ExtractionObjMask(Image,ObjSize,Reso,'ball');


% Morphorogical Filter(Volume)
VolumeCoef = 1;
abc = ObjSize./Reso;
V = 4*pi*prod(abc)/3 * VolumeCoef;
bw2 = bwareaopen(bw,round(V),26);
clear bw2
bw = and(bw,~bw2);


% Centroid
L = bwconncomp(bw,26);
[L,NUM] = bwlabeln(bw,26);
if NUM<2^8
    L = uint8(L);
elseif NUM < 2^16
    L = uint16(L);
end

% % Add Major
MajorCoef = 1.2;
bw2 = false(size(bw));
for n = 1:size(bw,3);
    sL = bwlabeln(bw(:,:,n),8);
    s = regionprops(sL,'MajorAxisLength','MinorAxisLength');
    % % Major < ObjSize(x)*MajorCoef
    s = cat(1,s.MajorAxisLength) * Reso(1); %% Length um
    Ind = find( s < ObjSize(1)*MajorCoef);
    BW = false(size(sL));
    if ~isempty(Ind)
    for k = 1:length(Ind)
        BW = or(BW,sL==Ind(k));
    end
    end
    bw2(:,:,n) = BW;
    clear BW sL s Ind k
end
[L,NUM] = bwlabeln(bw2,26);
if NUM<2^8
    L = uint8(L);
elseif NUM < 2^16
    L = uint16(L);
end


Cent = regionprops(L,'Centroid','Area');

%% Crop to Structure 
Cropdata = TS_centroid2Crop(Image,mfImage,CropSize,Reso,Cent);
    
%% Check figure
% [Cropdata,NewCropdata] = TS_CropdataEnableCheck(Cropdata);
    
    
    






