function output = TS_ExtractionPenet(Image,Reso)

if ndims(Image)~=3
    error('input is not 3 Dim')
end
if and(~isvector(Reso),length(Reso)~=3)
    error('Input Resolution is NOT Correct.')
end

if Reso(1) ~= Reso(2)
    erro('input Resolution X and Y is NOT equal')
end

TIME = tic;
%% pre opening
Objsiz = 4; % um
sigma = Objsiz./Reso/(2*sqrt(2*log(2)));
Gauss = Gaussian3D(sigma,sigma*3);
fImage = imfilter(single(Image),Gauss,'symmetric');
 % time is 57 sec[PC:T7500]
LogfImage = TS_HistgramLogScaler(fImage,'min');
AdjLogfImage = TS_AdjImage(LogfImage);
SAdjLogfImage = TS_ShadingImage(AdjLogfImage,Reso);

%% Extraction Penetrating 
Pobjsiz = 10; %% um Penetrating Diameter size
Pobjsiz_areaopen = Pobjsiz/Reso(1);
PDobjsiz = 50; %% um Penetrating Depth Object Size
PDobjsiz_close = 20; %% um Penetrating Depth Object Size(for Closing)
Pth = 0.2;
Volume_th = 30; %% unit "%" , Decision of Surface Threshold

Pse= TS_strel(repmat(Pobjsiz,[1 3]),Reso,'ball');
POImage = imopen(SAdjLogfImage,Pse);
 % time is 148 sec[PC:T7500]
 APOImage = TS_AdjImage(POImage);
 bw1 = APOImage > max(APOImage(:))*Pth ;
 
 % % Caluclate volume
 Hist = TS_EachDepthVolumeHist(bw1,Reso(3),Reso(3));
 
  %% Flipの確認．．．Z軸がdeepからかSurfaceからか．．
  if sum(Hist.Hist(1:5)) > sum(Hist.Hist(end-4:end))
      % % Start Axis Z is Deep tissue.
      Histx = flip(Hist.Hist);
      zdata = 0:size(Image,3)-1;
  else
      Histx = Hist.Hist;
      zdata = flip(0:size(Image,3)-1);
      % % all Flip(dim.3)
      % %%%%+***><LLLKL+MKL+JK+LOPK)IPKIOPUJ
      Image = flip(Image,3);
      bw1 = flip(bw1,3);      
      % %%%%+***><LLLKL+MKL+JK+LOPK)IPKIOPUJ
  end
  Ind = find(Histx>Volume_th);
  if ~isempty(Ind)
      Ind = Ind(1);
  else
      Ind = size(Image,3);
  end
  %% Decision Surface 
  zdata = (zdata - Ind(1)) * -1;
  
  PDse_cl = ones(1,1,round(PDobjsiz_close/Reso(3)));
  PDse = ones(1,1,round(PDobjsiz/Reso(3)));
  bw0 = imclose(bw1,PDse_cl);
  bw0 = imopen(bw0,PDse);
  
  %% Extraction Penetrating
  [L,NUM] = bwlabeln(bw0,26);
  if NUM<2^8
      L = uint8(L);
  elseif NUM < 2^16
      L = uint16(L);
  elseif NUM < 2^32
      L = uint32(L);
  end
      
  Surface_Num = L(:,:,Ind(1):end);
   [h,xdata] = hist(single(Surface_Num(Surface_Num>0)),1:single(max(Surface_Num(:))));
   clear Surface_Num
  bw2 = false(size(bw1));
  for n = 1:length(xdata)
      if h(n)>1
          bw2 = or(bw2,L==xdata(n));
      end
  end
  clear xdata h n
  
  Pbw = bw2;
  Pbw(:,:,Ind(1):end) = false;
  Sbw = bw2;
  Sbw(:,:,1:Ind(1)-1) = false;
    %% 2 Index
    PInd = find(Pbw(:));
    if max(PInd) < 2^32
        PInd = uint32(PInd);
    end
    SInd = find(Sbw(:));
    if max(SInd) < 2^32
        SInd = uint32(SInd);
    end
  
  
  %% output
  output.InputOriginal = Image;
  output.Resolution = Reso;
  output.EnhancedImage = SAdjLogfImage;
  output.OpenedPentratingImage = POImage;
  output.Depth_0um_Index = Ind(1);
  output.zdata = zdata;
  output.ImageSize = size(Image);
  output.ExPenetratingPixInd = PInd;
  output.ExSurfacePixInd = SInd;
  output.AnalysisTime = toc(TIME);
toc(TIME)
disp(['  by. '  mfilename])
  
    
    
  
  
  
 