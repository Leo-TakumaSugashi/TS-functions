function output = TS_AutoAnalysisDiam_SEG_v2019b(fImage,Reso,ThresholdType,SEG,varargin)
% SEG = TS_AutoAnalysisDiam_SEG(fImage,Reso,ThresholdType,SEG,Number)
% fImage = Resize_fImage;
% Len = [70 100]; % um 
% Reso = Resolution % um/pix.
% Threshold Type = {sp5, sp8, photo count, pmt, ..}*
% SEG = TS_AutoSegment_loop...
% Number .... SEG.Pointdata(Number)
% 
% add Compensation by SNR (this value is for PMT ver. Image)
% th = TS_GetThreshold_sp5(S,N);
%  
%  see alo so , Sugashi_AutoAnalysisDiam
% TS_AutoAnalysisDiam_AddAdjPreFWHM_perSlice  Group...


% Editor log. 
% Add, Threshold Type to fwhm(threhsold =0.5), 2019.06.14 ,Sugashi
% For Save memory type is 2019b. by Sugashi, 2019.06.26-29
%%

%error('it has bag.')

if nargin ==5
    Number = varargin{1};
else
    Number = 1:length(SEG.Pointdata);
end

if ~max(strcmpi({'sp5','sp8','fwhm'},ThresholdType))
    warning(   mfilename('fullpath') )
    error('Input Threshold Type is Member of {"sp5"(=PMT), or "sp8"(=Photo Count)}')
end
siz = size(fImage);
if ismatrix(fImage)
    siz(3) = 1;
elseif ndims(fImage)>3
    error('input image dim must be <= 3')
end
% SNRth = 2; % [dB]
Len = [70 200]; % Rotation Line Profile Length , Checking Axis Z Line Length
PenetLenTh = 100;
ResamplingZstep = 1; %% um.

%% Resampling Image of Zsize
if ~ismatrix(fImage)
    FOV = (siz-1).* Reso;
    fImage = imresize3(fImage,[siz(1:2) round(FOV(3)/ResamplingZstep)],'linear');
    Reso = FOV ./ (size(fImage) -1) ;
    siz(3) = size(fImage,3);
end

%% set up xyz data
Pdata = SEG.Pointdata;            
xyz = double(cat(1,Pdata(Number).PointXYZ));
SEGRESO = SEG.ResolutionXYZ;
xyz = (xyz-1) .* SEGRESO;
xyz = (xyz ./ Reso) + 1;
indY = xyz(:,2);
indX = xyz(:,1);
indZ = xyz(:,3);

% sort for parfor
[indZ,sort_index] = sort(indZ);
indY = indY(sort_index);
indX = indX(sort_index);
SortData = 1:length(indX);
Resort_index = SortData(sort_index);

%% check xyz size
if or(min(indX)<1,max(indX)>size(fImage,2))
    warning('Input SEG Index Size over(less) than fImage (X-axis).')
elseif or(min(indY)<1,max(indY)>size(fImage,1))
    warning('Input SEG Index Size over(less) than fImage (Y-axis).')
elseif or(min(indZ)<1,max(indZ)>size(fImage,3))
    warning('Input SEG Index Size over(less) than fImage (Z-axis).')
end
%% Analysis
TIME = tic;
ppdata(1:length(indY)) = ...
    struct('XYZ',[],'Signal',[],'Noise',[],'Theta',[],'FWHM',[],...
    'PixelsDiameter',[],'Type',[],'NewXYZ',[]);
%% Add Pre FWHM
% This Process is to denoising in Near 3 point from center point
close_siz = round(3 / Reso(1));
close_siz = close_siz + double(eq(floor(close_siz/2),ceil(close_siz/2)));
se = ones(close_siz,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SfImage = imfilter(single(fImage),ones(3,3,3)/27,'symmetric');
% [meshX,meshY,meshZ] = meshgrid(1:siz(2),1:siz(1),1);
[Xp,Yp,theta] = TS_GetLinePro2mesh(fImage(:,:,1),[0 0],Len(1),Reso);
%% Main 
fImage = single(fImage); %% 
%% Getting Signal
fprintf(1,['Numeric : ' num2str(length(indY)) '\n 1st. Getting Signal each point\n'])
xdata = 1:siz(2);
ydata = 1:siz(1);
zdata = 1:siz(3);



% TS_WaiteProgress(0)
for n = 1:length(indZ)
    x=indX(n);y=indY(n);z=indZ(n);
    %% interpolation type    
%     [Xq,Yq,Zq] = GetSignalMesh(x,y,z,siz);    
%     S = interp3(fImage,Xq,Yq,Zq,'bilinear');  %% single(fImage) v2019b
    %% round type
    S = fImage(...
        and(y-1 <= ydata, ydata <= y +1),...
        and(x-1 <= xdata, xdata <= x +1),...
        and(z-1 <= zdata, zdata <= z +1));
    %%
    ppdata(n).Signal = mean(S(:));
%     TS_WaiteProgress(n/length(indZ))
end


fprintf(1,'\n 2nd. Analyssis Diameter parfor....\n')
TS_WaiteProgress(0)
for k = 1:size(fImage,3)
zid = find(and(k-0.5< indZ, indZ <= k+0.5));
if isempty(zid)
    TS_WaiteProgress(k/size(fImage,3))
    continue
end
im = fImage(:,:,k);
N = TS_GetBackgroundValue(im(and(im>min(im(:)),im<max(im(:)))));
N = max(N,1);
ColumnZid = reshape(zid,1,[]);
    parfor n = ColumnZid        
        x=indX(n);y=indY(n);z=indZ(n);
        S = ppdata(n).Signal;
        %% check Plane XY
        vpX = Xp + x;
        vpY = Yp + y;
        vpmatrix = interp2(im,vpX,vpY,'bilinear');        
        vpmatrix = double(vpmatrix);
        vpmatrix = (vpmatrix-N)/(S-N);
        vpmatrix = max(vpmatrix,0);
        %% Add Pre FWHM
        % This Process is to denoising in Near 3 point from center point
        % pre_vpmatrix = vpmatrix;
        vpmatrix(round(size(vpmatrix,1)/2),:) = 1;
        % bw_vp =TS_GetMaxArea(vpmatrix>0.5); %% 2016.11.12 .old, ver.
        L = bwlabel(vpmatrix>0.5,8);%% 2016.11.14 .New, ver.
        bw_vp = L==L(round(size(vpmatrix,1)/2),1);
        % % This process is to analys High Noise data ,but High SNR is not neccaaary
        bw_vp = imclose(bw_vp,se);
        bw_vp = imerode(bw_vp,ones(3,1)); %
        if strcmpi(ThresholdType,'sp5')
            th = TS_GetThreshold_sp5(S,N);        
        elseif strcmpi(ThresholdType,'sp8')
            th = TS_GetThreshold_sp8(S);
        elseif strcmpi(ThresholdType,'fwhm')
            th = 0.5;
        end
        vpmatrix(bw_vp) =  max(vpmatrix(bw_vp),th); %
        fwhm = nan(length(theta),2);
        for ck = 1:length(theta)
            Lp = double(vpmatrix(:,ck));
            fwhm(ck,:) = TS_FWHM2016(Lp,th,'type','fwhm','Center',ceil(length(Lp)/2));
        end
%         fwhm = GetWidthPosition(vpmatrix,th);
        DiffFWHM = diff(fwhm,1,2);
        [PixDiam,Ind] = min(DiffFWHM);

        %% output NEW Position
        newx = vpX(:,Ind);
        newy = vpY(:,Ind);
        newind = mean(fwhm(Ind,:));
        newx = interp1(newx,newind,'linear');
        newy = interp1(newy,newind,'linear');

        %% write
        newz = z;
        ppdata(n).XYZ = [x y z];
        ppdata(n).Theta = theta(Ind);
        ppdata(n).Signal = single(S);
        ppdata(n).Noise = single(N);
        ppdata(n).FWHM = fwhm;
        ppdata(n).PixelsDiameter = PixDiam;        
        ppdata(n).NewXYZ = [newx newy newz];
    end
    TS_WaiteProgress(k/size(fImage,3))
end

%% check Axis Z 
% fprintf(1,'\n 3rd. Checking new Z position....\n')
% 
% if ~ismatrix(fImage)
%     TS_WaiteProgress(0)
%     for n = 1:length(indZ)
%         x=ppdata(n).NewXYZ(1);
%         y=ppdata(n).NewXYZ(2);
%         z=ppdata(n).NewXYZ(3);
%         S = ppdata(n).Signal;
%         N = ppdata(n).Noise;    
%         [X,Y,Z] = GetAxisZMesh(x,y,z,siz,Len(2)/Reso(3));
%         LineZ = single(mean( interp3(single(fImage),X,Y,Z,'bilinear') ,1));
%         LineZ(isnan(LineZ)) = 0;
%         LineZ = (LineZ - N) / (S -N);
%         WidthPoint = TS_FWHM2016(LineZ,0.5,'type','fwhm','Center',floor(length(LineZ)/2));
%         WidthZ = diff(WidthPoint) * Reso(3);
%         if or(isnan(WidthZ) , WidthZ > PenetLenTh)
%             Type = 'Penet';
%         else
%             Type = 'others';
%             WidthZ_center = mean(WidthPoint);
%             z = interp1(Z(1,:),WidthZ_center);
%         end
%         ppdata(n).Type = Type;
%         ppdata(n).NewXYZ(3) = z;
%         TS_WaiteProgress(n/length(indZ))
%     end
% end

%%
fprintf(1,'\n Last . Writeing for Segment data from parfor-data-form....\n')
ppdata = ppdata(Resort_index);

c = 1;
for N = 1:length(Number)
    xyz = SEG.Pointdata(Number(N)).PointXYZ;
    Signal = zeros(size(xyz,1),1,'like',single(1));
    Noise = Signal;
    Diameter = Signal;
    Theta = Signal;
    NewXYZ = double(cat(2,Signal,Signal,Signal));    
    for k = 1:size(xyz,1)
        Signal(k) = ppdata(c).Signal;
        Noise(k) = ppdata(c).Noise;
        Diameter(k) = ppdata(c).PixelsDiameter * Reso(1);
        Theta(k) = ppdata(c).Theta;
        NewXYZ(k,:) = ppdata(c).NewXYZ;
        
        c = c +1;
    end
    SEG.Pointdata(Number(N)).Signal = Signal;
    SEG.Pointdata(Number(N)).Noise = Noise;
    SEG.Pointdata(Number(N)).Diameter = Diameter;
    SEG.Pointdata(Number(N)).Theta = Theta;
    NewXYZ = (NewXYZ -1 ) .* Reso;
    NewXYZ = (NewXYZ ./ SEGRESO ) + 1;
    SEG.Pointdata(Number(N)).NewXYZ = NewXYZ;
end
output = SEG;
fprintf('Done \n\n')

toc(TIME)
end

function Answer = GetWidthPosition(vp,th)
% L1 L2 L3.... LN
% must Be Center line over than th value.

Center = ceil(size(vp,1)/2);
bw = vp >= th;
L = bwlabel(bw,8);
L_inside = L == L(Center,1);
InSide = and(L_inside,~imerode(L_inside,true(3,1)));
OutSide =  and(~L_inside,imdilate(L_inside,true(3,1)));

yi = zeros(2,size(vp,2));
yo = yi;
xio = repmat(1:size(vp,2),[2 1]);

B1 = yi; %% Left
B2 = yi; %% Right
 
for n = 1:size(vp,2)
    s = find(OutSide(:,n));
    if length(s)<2
        continue
    end
    [~,ind] = sort(abs(s-Center)); % find nearest 2point from center,
    s = s(ind(1:2));
    yo(:,n) = [min(s) ; max(s)];
    B1(1,n) = vp(min(s),n);
    B2(2,n) = vp(max(s),n);
    
    
    s = find(InSide(:,n));
    if numel(s) ==1
        yi(:,n) = s;
    elseif numel(s) >= 2        
        [~,ind] = sort(abs(s-Center)); % find nearest 2point from center,
        s = s(ind(1:2));
        yi(:,n) = [min(s) ; max(s)];
    else        
        continue
    end
    B1(2,n) = vp(yi(1,n),n);
    B2(1,n) = vp(yi(2,n),n);    
end

Y1 = [yo(1,:) , yi(1,:)];
F1 = scatteredInterpolant(xio(:),B1(:),Y1(:),...
    'linear','none');
A1 = F1(1:size(vp,2),repmat(th,[1 size(vp,2)]));

Y2 = [yi(2,:) , yo(2,:) ];
F2 = scatteredInterpolant(xio(:),B2(:),Y2(:),...
    'linear','none');
A2 = F2(1:size(vp,2),repmat(th,[1 size(vp,2)]));


Answer = cat(2,A1(:),A2(:));

end

function [X,Y,Z] = GetSignalMesh(x,y,z,siz)
    X = x-1 : x + 1;
    X(X<1) = [];
    X(X>siz(2)) = [];
    Y = y-1 : y + 1;
    Y(Y<1) = [];
    Y(Y>siz(1)) = [];
    Z = z-1 : z + 1;
    Z(Z<1) = [];
    Z(Z>siz(3)) = [];
    [X,Y,Z] = meshgrid(X,Y,Z);
end
function [X,Y,Z] = GetAxisZMesh(x,y,z,siz,PixLen)
    X = x-1 : x + 1;
    X(X<1) = [];
    X(X>siz(2)) = [];
    Y = y-1 : y + 1;
    Y(Y<1) = [];
    Y(Y>siz(1)) = [];
    Z = z-PixLen/2 : z + PixLen/2;
    % Z(Z<1) = [];
    % Z(Z>siz(3)) = [];
    [X,Y,Z] = meshgrid(X,Y,Z);
    num1 = size(X,1) * size(X,2);
    num2 = size(X,3);
    X = reshape(X,num1,num2);
    Y = reshape(Y,num1,num2);
    Z = reshape(Z,num1,num2);
end

