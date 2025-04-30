function TS_setdefa2019(varargin)
%%PRETTIFY_FIGURE_PRESEN ???O?????????t?????t???H?????????g?????????v?????????[?????????p???????K??????
% 

disp('TS_Traking_DaysDiameter_Script')
disp('TS_Automesurement_AorV_script')

disp('check .... TS_AutoMeasurement_inSEG')
disp('check .... SEG = TS_PenetResult2SEG(PR,DiamImage,Reso,skel)')
  if nargin == 1
      if strcmpi(varargin{1},'default')
          Default = true;
      else
          Default = false;
      end
      if isnumeric(varargin{1})
          NumWorkers = varargin{1};
      else
          NumWorkers = 8;
      end
  else
      Default = false;
      NumWorkers = 8;
  end
pcoj = parcluster;
  pcoj.NumWorkers = NumWorkers;
  
  
%% Initialized
if Default
    FontSize = 9; %defo 9
    FontName = 'MS UI Gothic'; %defo MS UI Gothic; ( recomended Times New Roman)
    FontWeight = 'normal';% defo normal
    AxLineWid = 0.5; % def0 0.5
    LLineWid = 0.5; % def 0.5
    Gridtype = 'off'; %defa off
    FPPMode = 'manual'; % defo manual
    PPosition = [ 0.2500    2.5000    8.0000    6.0000]; % defa [ 0.2500    2.5000    8.0000    6.0000]
    AxesPosi = [ 0.1300    0.1300    0.7750    0.8150]; % defa [ 0.1300    0.1100    0.7750    0.8150]
    Fposi = [680   558   560   420]; % defa [680   558   560   420]
    map = parula(256);
    clorder = [...
        0    0.4470    0.7410
        0.8500    0.3250    0.0980
        0.9290    0.6940    0.1250
        0.4940    0.1840    0.5560
        0.4660    0.6740    0.1880
        0.3010    0.7450    0.9330
        0.6350    0.0780    0.1840];
else
    mymap = tsmaps;
    FontSize = 15; %15; %defo 9
    FontName = 'Times New Roman'; %defo MS UI Gothic; ( recomended Times New Roman)
    FontWeight = 'demi';% defo normal
    AxLineWid = 3; %1.5; % def0 0.5
    LLineWid = 1.8; % def 0.5
    Gridtype = 'off'; %defa off
    FigColor = [1 1 1];
    FPPMode = 'auto'; % defo manual
    PPosition = [.6 .6 11 7]; % defa [ 0.2500    2.5000    8.0000    6.0000]
    AxesPosi = [.13 .13 .8 .8]; % defa [ 0.1300    0.1100    0.7750    0.8150]
    Fposi = [63  522   560   420]; % defa [680   558   560   420]
    Fposi = [ 135    52   827   620];
%     hsvmap = rgb2hsv(parula(256));
%     hsvmap(:,3) = log10(linspace(0,1,256)*9+1);
%     map = hsv2rgb(hsvmap);
    map = mymap.kgbryw;
    map = gray(256);
    clorder = ...
    [  0,   0, 255; % ??????
       0, 128,   0; % ??????
     255,   0,   0; % ??????
     204,   8, 204; % ??????
     222, 125,   0; % ??????
       0,  51, 153; % ?????? (??????????????????????????C???????????I)
      64,  64,  64] /255;% ???Z?????????D???F  
end
% axAspectRatio = [1 1 1]; %% == axis image ,,,,?????W??????

%% ???t???H?????????g
set(0,'defaultAxesFontSize',FontSize);
set(0,'defaultAxesFontName',FontName);
set(0,'defaultAxesPosition',AxesPosi);
set(0,'defaultAxesFontWeight',FontWeight); % normal/demi/bold
set(0,'defaultTextFontSize',FontSize);
set(0,'defaultTextFontName',FontName);
set(0,'defaultTextFontWeight',FontWeight);
 
%% ??????????????
set(0,'defaultAxesLineWidth', AxLineWid); % ??????
set(0,'defaultLineLineWidth', LLineWid); % ???v?????????b???g
 
%% ???v?????????b???g?????F
set(0,'defaultAxesColorOrder',clorder);
 
%% ????????????????????grid on & box on
set(0,'DefaultAxesXGrid',Gridtype);
set(0,'DefaultAxesYGrid',Gridtype);
set(0,'DefaultAxesBox',Gridtype);
% set(0,'DefaultAxesDataAspecRatio',axAspectRatio);

%% Figure
set(0,'DefaultFigureColormap',map)
set(0,'DefaultFigurePosition',Fposi);
set(0,'DefaultFigureColor',FigColor)
 
%% ???R???s???y???????????T???C???Y????????X??????????????
set(0,'DefaultFigurePaperPositionMode',FPPMode);
set(0,'DefaultFigurePaperPosition',PPosition)
 
end

% 
% 
%     'US-ASCII'
% 
%     'Windows-1252'
% 
%     'ISO-8859-1'
% 
%     'Shift_JIS'
% 
%     'UTF-8'