function TS_Tracking_proto(varargin)
% TS_Tracking_proto(H,varargin)
% TS_Tracking_proto(H_fixed,H_Mov1,H_Mov2,...)
% Input : H  ('Sugashi_basicdata_class')
%   H    = TS_setupImage(Name,Image,Resolution);
% see also , TS_setupImage, TS_classdef2structure
%            TS_meshFor3DReplaceActualLength
% see also previous Code., TS_DepthReposi, TS_DepthAdjGUI

GUI = Sugashi_GUI_support;

fgh = figure('menubar','none','Position',[10 10 1000 600]);
narginchk(2,12)
H.figure = fgh;
%% menu
mh = uimenu(fgh,...
    'Label','Data');
ch = zeros(1,nargin);
for num = 1:nargin
    ch(num) = create_data_menu_channels(mh,num,varargin{num});
end
    function h = create_data_menu_channels(p,N,data)
        h = uimenu(p,'Label',['Channels#' num2str(N)]);
        h.UserData = TS_classdef2structure(data);
    end
set(ch(1:2),'Checked','on')
set(ch(2),'separator','on')
H.menuH = mh;

%% Channels Checker
    function Ind = find_checked_Channels(ch)
        Ind =false;        
        for n = 1:length(ch)
            Ind(n) = strcmpi(get(ch(n),'Checked'),'on');
        end
    end
%% Axes
H.Axes = axes(fgh,...
    'Position',[0.4 0 0.6 1]);
Basement = varargin{1};
FirstIm = max(Basement.Image,[],3);
H.imh = imagesc(H.Axes,rgbproj(FirstIm));
axis image off

H = GUI.create_Controller_Traker(fgh,H);
SetUpCallback(H)
    function SetUpCallback(H)
        H
        set(H.PUshApplyMIP,'Callback',@ResetView)        
        set(H.RotateRho,'Callback',@Callback_Rho)
        function Callback_Rho(oh,~)
            f = oh.UserData;
            val = f(oh.Value);
            H.textRotateRho.String = ['Rotate Rho ' num2str(val,'%.2f')];
        end
        set(H.RotateYaw,'Callback',@Callback_Yaw)
        function Callback_Yaw(oh,~)
            f = oh.UserData;
            val = f(oh.Value);
            H.textRotateYaw.String = ['Rotate Yaw ' num2str(val,'%.2f')];
        end
        set(H.RotatePitch,'Callback',@Callback_Pitch)
        function Callback_Pitch(oh,~)
            f = oh.UserData;
            val = f(oh.Value);
            H.textRotatePitch.String = ['Rotate Pitch ' num2str(val,'%.2f')];
        end
    end
    function ResetView(~,~)
        H.imh.CData = GetNowSliceImage;
    end
    function outImage = GetNowSliceImage
        %% Getting Data
        % % Fixed Data
        FixedData = get(ch(1),'UserData');
        FixedImage = FixedData.Image;
        FixedReso = FixedData.Resolution;
        FixedSiz = size(FixedImage);
        % % Moving Data
        Ind = find_checked_Channels(ch);
        p = find(Ind);
        Data = get(ch(p(2)),'UserData');
        MovingImage = Data.Image;
        MovingReso = Data.Resolution;
        MovingSiz = size(MovingImage);
        %% Output size & Padding Size
        OutSiz = eval(H.ViewOutput.String);
        STR = H.BasePaddingPreValue.String;
        val = H.BasePaddingPreValue.Value;
        PadPreValue = eval(STR{val});
        PadSizPreXYZ   = eval(H.BasePaddingPreXYZ.String);
        
        STR = H.BasePaddingPostValue.String;
        val = H.BasePaddingPostValue.Value;
        PadPostValue = eval(STR{val});
        PadSizPostXYZ   = eval(H.BasePaddingPostXYZ.String);
        
        FixedImage = padarray(FixedImage,PadSizPreXYZ,PadPreValue,'pre');
        FixedImage = padarray(FixedImage,PadSizPostXYZ,PadPostValue,'post');        
        MovingImage = padarray(MovingImage,PadSizPreXYZ,PadPreValue,'pre');
        MovingImage = padarray(MovingImage,PadSizPostXYZ,PadPostValue,'post');
        
        Fun = H.RotateRho.UserData;
        Rho = Fun(H.RotateRho.Value);
        Yaw = Fun(H.RotateYaw.Value);
        Pitch = Fun(H.RotatePitch.Value);
        X = eval(H.EditShiftX.String);
        Y = eval(H.EditShiftY.String);
        Z = eval(H.EditShiftZ.String);
        ShiftData = [Rho Yaw Pitch X Y Z];
        FOV = (FixedSiz-1).*FixedReso;
        Center = FOV/2 + PadSizPreXYZ.*FixedReso;
        [fX,fY,fZ,fReso] = TS_meshFor3DReplaceActualLength(size(FixedImage),FixedReso,OutSiz,zeros(1,6),Center);
        FixedImage = interp3(single(FixedImage),fX,fY,fZ);
        [fX,fY,fZ,fReso] = TS_meshFor3DReplaceActualLength(size(MovingImage),MovingReso,OutSiz,ShiftData,Center);
        MovingImage = interp3(single(MovingImage),fX,fY,fZ);
        
        
        Dim = 3;
        FixedImage = max(FixedImage,[],Dim);
        MovingImage = max(MovingImage,[],Dim);        
        outImage = rgbproj(squeeze(cat(3,FixedImage,MovingImage)));
    end



end