function Cropdata = TS_centroid2Crop(Image,mfImage,CropSize,Reso,Cent)
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

if isstruct(Cent)
    Cent = cat(1,Cent.Centroid);
end

Vert = CropSize(2); % Cropsize [/mum]
Hori = CropSize(1);
Depth = CropSize(3);
RpVert = ceil(Vert/Reso(2)/2); % Radius Vert [Pixels]
RpHori = ceil(Hori/Reso(1)/2);
RpDepth = ceil(Depth/Reso(3)/2);
Cropdata = struct('centroidXYZ',[],'CenterOfImage',[],...
    'Image',[],'fImage',[],'Enable',[],'Resolution',[]);
xdata = 1:size(Image,2);
ydata = 1:size(Image,1);
zdata = 1:size(Image,3);
for n = 1:size(Cent,1)
    x = Cent(n,1);
    y = Cent(n,2);
    z = Cent(n,3);
    ind_x = and(xdata>=x-RpHori,xdata<=x+RpHori);
    ind_y = and(ydata>=y-RpVert,ydata<=y+RpVert);
    ind_z = and(zdata>=z-RpDepth,zdata<=z+RpDepth);
    Cropdata(n).centroidXYZ = [x y z];
    Cropdata(n).Image = Image(ind_y,ind_x,ind_z,:,:);
    if ~isempty(mfImage)
        Cropdata(n).fImage = mfImage(ind_y,ind_x,ind_z,:,:);
    end
    
    % % Centre of Image
    try
    Cxdata = xdata(ind_x);
    vx = interp1(Cxdata,1:length(Cxdata),x,'linear');
    Cydata = ydata(ind_y);
    vy = interp1(Cydata,1:length(Cydata),y,'linear');
    Czdata = zdata(ind_z);
    vz = interp1(Czdata,1:length(Czdata),z,'linear');
    Cropdata(n).CenterOfImage = [vx vy vz];
    catch 
        keyboard
    end
    
    % % Enable
    Cropdata(n).Enable = true;
    Cropdata(n).Resolution = Reso;
    clear Cxdata Cydata Czdata vx vy vz ind_x ind_y ind_z x y z
end