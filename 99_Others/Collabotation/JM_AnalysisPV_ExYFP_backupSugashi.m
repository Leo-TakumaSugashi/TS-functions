function JM_AnalysisPV_ExYFP_backupSugashi(Data,varargin)
% JM_AnalysisPV_ExYFP(Data,Depth,ClassNum)
% JM_AnalysisPV_ExYFP(Data)
% 
%  * * * Input * * *
% ResultData = JM_AnalysisPV_v1(~)
% Depth Index, default is 1
% ClassNum = [Vessels, YFP]; / unit [Index],default is [1, 1];
global axh uih imh ResultData Sepa z 
ResultData = Data;
ResultData.Original = flip(ResultData.Original,5);
ResultData.ShadingImage = flip(ResultData.ShadingImage,5);
Sepa = {'==== output====', '==== below===='};

narginchk(1,3)
Depth = 1;
ClassNum =[1 1];
if nargin >1
    Depth = varargin{1};
    ClassNum = varargin{2};
end
%% Sugashi Full playing with MATLAB ... lol
fgh = figure('Position',[27 176  1829 726]);
[axh,uih,imh] = SetupGUI(fgh);
%% image set up
Reset_imh(Depth,ClassNum)
%% set slider step
z = size(ResultData.Original,3);
uih(1).SliderStep = [1/(z-1) 1/(z-1)];
uih(1).UserData = z-1;
set(uih(1),'Callback',@Callback_slider)
uih(2).String = [num2str(Depth) '/' num2str(z)];
set(uih(5),'Callback',@Callback_slider)
set(uih(7),'Callback',@Callback_GammaApply)
set(uih(8),'Callback',@Callback_LookObj)
set(uih(9),'Callback',@Callback_WriteCSV)


colormap(kjet(ResultData.Kmeans_Classtering_Number))
for nn = 1:length(axh)-1
    axis(axh(nn),'image')
    axis(axh(nn),'off')
end
axis(axh(end),'normal')
    function [axh,uih,imh] = SetupGUI(fgh)
        siz = size(ResultData.Original);
        
        X = zeros(siz(1:2));
        axh(1) = axes(fgh);
            imh(1) = imagesc(axh(1),X);
            axh(1).Title.String = 'Original (mean,DIM=4)';
        axh(2) = axes(fgh);
            imh(2) = imagesc(axh(2),X);
            axh(2).Title.String = 'Shading (mean,DIM=4)';
        uih(1) = uicontrol('style','slider','Unit','normalized');
        uih(2) = uicontrol('style','text','Unit','normalized','String','1/1');
        axh(3) = axes(fgh);
            imh(3) = imagesc(axh(3),X);
            axh(3).Title.String = 'Kmeans / Ves.';
        ch = colorbar(axh(3),'south');
        ch.Position= [0.2226 0.0446 0.1575 0.0303];
        axh(4) = axes(fgh);
            imh(4) = imagesc(axh(4),X);
            axh(4).Title.String = 'Kmeans / YFP';
        axh(5) = axes(fgh);
            imh(5) = imagesc(axh(5),X);
        axh(6) = axes(fgh); %% Density(YFP/V) vs. Depth
            x = ResultData.zStep;
            y = ones(1,length(x));
            imh(6) = bar(axh(6),x,y);
            axh(6).XLabel.String = 'Depth';
            axh(6).YLabel.String = 'Density [YFP/Ves.]';
        uih(3) = uicontrol('style','text','Unit','normalized');
        uih(3).String = {...
            'Red: Vessels,   Green: Ex.YFP,    Blue:Others';
            'DilateVes = imdilate(Ves,vessels_dilate_se)';
            'ExYFP = and(MaskYFP, ~DilateVes);';
            'Others = and(YFP,~Ex.YFP)'                    };
        uih(4) = uitable(...
            'Parent',fgh,...
            'Unit','Normalized',....
            'Position',[.8 .13  0.1825  0.81],...
            'ColumnName',{'Name','Value',},...J
            'ColumnFormat',{'char','char'},...
            'ColumnEditable',true,...
            'ColumnWidth',{200 300},...
            'CellSelectionCallback','',...
            'BusyAction','cancel',...    
            'Enable','on',...
            'CellEditCallback','');
        uih(5) = uicontrol('Unit','Normalized','String','Apply');
        uih(6) = uicontrol('Style','Edit',...
            'Unit','Normalized','String','1');
        uih(7) = uicontrol(...
            'Unit','Normalized','String','Gamma Apply');
        uih(8) = uicontrol(...
            'Unit','Normalized','String','LookObj.');
        uih(9) = uicontrol(...
            'Unit','Normalized','String','Wite CSV');
        
        AXPOSI = [...
            0.016 0.534 0.173 0.369
            0.016 0.096 0.173 0.369
            0.209 0.558 0.178 0.368
            0.209 0.110 0.178 0.368
            0.433 0.552 0.259 0.417
            0.4540    0.0895    0.2174    0.3127];
        UIPOSI = [...
            0.077 0.949 0.095 0.039
            0.029 0.950 0.041 0.030
            0.465 0.401 0.197 0.108
            0.698 0.130 0.285 0.837
            0.700 0.063 0.067 0.063
            0.074 0.010 0.039 0.040
            0.118 0.010 0.066 0.045
            0.797 0.066 0.049 0.051
            0.920 0.017 0.062 0.066];
        for n = 1:length(axh)
            axh(n).Position = AXPOSI(n,:);
            if n<6
                daspect(ones(1,3))
            end
        end
        for n = 1:length(uih)
            uih(n).Position = UIPOSI(n,:);
        end
        
    end
    function Reset_imh(Depth,ClassNum)    
        STARTTF = max(imh(1).CData,[],'all')==0;
        imh(1).CData = rgbproj(squeeze(nanmean(ResultData.Original(:,:,Depth,:,:),4)));
        Callback_GammaApply
        imh(3).CData = ResultData.VesselsKmeans(:,:,Depth);
        caxis(axh(3),[0 ResultData.Kmeans_Classtering_Number])
        imh(4).CData = ResultData.YFPKmeans(:,:,Depth);
        caxis(axh(4),[0 ResultData.Kmeans_Classtering_Number])
        imh(5).CData = GetOutImage(Depth,ClassNum);
        SetupTable(Depth,ClassNum,STARTTF)        
    end
    function OutImage = GetOutImage(Depth,ClassNum)
        VessNum = ClassNum(1);
        YFPNum = ClassNum(2);
        Ves = ResultData.BWData(VessNum).Size_Filtered_VesselsMask(:,:,Depth);
        MaskYFP = ResultData.BWData(YFPNum).MaskYFP(:,:,Depth);

        % length("um")=2
        vessels_dilate_size = eval(ResultData.vessesl_dilate_size(1:end-2)); 
        vessels_dilate_pixels_size = ...
            round(vessels_dilate_size /...
            ResultData.Resolution(1) );
        vessels_dilate_se = strel('disk',vessels_dilate_pixels_size,0);

        DilateVes = imdilate(Ves,vessels_dilate_se);
        ExYFP = and(MaskYFP, ~DilateVes);
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         OutImage = rgbproj(cat(3,Ves,ExYFP,and(DilateVes,~Ves)));    %
        OutImage = rgbproj(cat(3,Ves,ExYFP));    %
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    function SetupTable(Depth,Class,STARTTF)        
        bwClass = ResultData.BinalizeClass;
        if STARTTF
            MG = MG_Functions;
            [~,x] = MG.VectorStructure2Table(ResultData);
            Fname = fieldnames(x);
            TData = cell(length(Fname),2);            
            for n = 1:length(Fname)
                TData{n,1} = Fname{n};
                if isvector(eval(['x.' Fname{n} ]))
                    TData{n,2} = ['[' num2str(eval(['x.' Fname{n} ';'])) ']'];
                else
                    TData{n,2} = num2str(eval(['x.' Fname{n} ';']));
                end
            end            
            outData = {...
                'Depth [slice]';
                'Ves, Class Ind.';
                'YFP, Class Ind.';
                'Ves, CLASS Num.';
                'YFP, CLASS Num.';
                'Vessles Sumation[pix]';                
                'Extracted YFP Sumation[pix]';                
                'Density (ExYFP/Ves.)[%]'
                'Extracted YFP object Num.'};           
            
            Dall = 1:length(ResultData.zStep);               
            ClassAll = repmat(Class,[length(Dall) 1]);                        
            Ves_S = zeros(1,length(Dall));
            YFP_S = Ves_S;
            ObjNum = Ves_S;
            for n = 1:length(Dall)
                OutImage = double(GetOutImage(n,ClassAll(n,:)));                
                Ves_S(n) = sum(OutImage(:,:,1),'all');
                YFP_S(n) = sum(OutImage(:,:,2),'all');
                CC = bwconncomp(logical(OutImage(:,:,2)));
                ObjNum(n) = CC.NumObjects;
            end
            RData = {...
                ['[' num2str(Dall,'% .0f,') ']'];
                ['[' num2str(ClassAll(:,1)','% .0f,') ']'];
                ['[' num2str(ClassAll(:,2)','% .0f,') ']'];
                ['[' num2str(bwClass(ClassAll(:,1)),'% .0f,') ']'];
                ['[' num2str(bwClass(ClassAll(:,2)),'% .0f,') ']'];
                ['[' num2str(Ves_S,'% .0f,') ']'];
                ['[' num2str(YFP_S,'% .0f,') ']'];
                ['[' num2str(YFP_S./Ves_S,'% .5f,') ']'];
                ['[' num2str(ObjNum,'% .0f,') ']'];
                };
            outData = cat(2,outData,RData);
            TData = cat(1,TData,Sepa,outData);
            imh(6).YData = YFP_S./Ves_S;
            set(uih(4),'Data',TData)
        else
            TData = uih(4).Data;
            sInd = find(strcmpi(TData(:,1),Sepa(1))) + 1;
            sInd = sInd+1; % Depth
            Old=eval(TData{sInd,2});
                Old(Depth)= Class(1);
                TData{sInd,2}=['[' num2str(Old,'% .0f,') ']'];
                sInd = sInd+1;
            Old=eval(TData{sInd,2});
                Old(Depth)= Class(2);
                TData{sInd,2}=['[' num2str(Old,'% .0f,') ']'];
                sInd = sInd+1;
            Old=eval(TData{sInd,2});
                Old(Depth)= bwClass(Class(1));
                TData{sInd,2}=['[' num2str(Old,'% .0f,') ']'];
                sInd = sInd+1;
            Old=eval(TData{sInd,2});
                Old(Depth)= bwClass(Class(2));
                TData{sInd,2}=['[' num2str(Old,'% .0f,') ']'];
                sInd = sInd+1;
            OutData = double(imh(5).CData);
            Old=eval(TData{sInd,2});
                Old(Depth)= sum(OutData(:,:,1),'all');
                TData{sInd,2}=['[' num2str(Old,'% .0f,') ']'];
                sInd = sInd+1;
            Old=eval(TData{sInd,2});
                Old(Depth)= sum(OutData(:,:,2),'all');
                TData{sInd,2}=['[' num2str(Old,'% .0f,') ']'];
                sInd = sInd+1;
            Old=eval(TData{sInd,2});
                Old(Depth)= ...
                    sum(OutData(:,:,2),'all')...
                    /sum(OutData(:,:,1),'all');
                TData{sInd,2}=['[' num2str(Old,'% .5f,') ']'];
                imh(6).YData = Old;
                sInd = sInd+1;
            Old=eval(TData{sInd,2});
                CC = bwconncomp(logical(OutData(:,:,2)),26);
                Old(Depth)= CC.NumObjects;
                TData{sInd,2}=['[' num2str(Old,'% .0f,') ']'];
            set(uih(4),'Data',TData)
        end
    end
    function A = GetDepth
        val = uih(1).Value;        
        A = uint16(val*uih(1).UserData+1);
        if isempty(A)
            A=1;
        end
    end
    function ClassNum = GetClassInd
        TData = uih(4).Data;
        sInd = find(strcmpi(TData(:,1),Sepa(1))) ;
        A = eval(TData{sInd+2,2});
        B = eval(TData{sInd+3,2});
        ind = GetDepth;
        ClassNum = [A(ind), B(ind)];
    end
    function Callback_slider(~,~)
        DepthInd = GetDepth;
        Class = GetClassInd;        
        Reset_imh(DepthInd,Class)
        uih(2).String = [num2str(DepthInd) '/' num2str(z)];
        TData = uih(4).Data;
        sInd = find(strcmpi(TData(:,1),Sepa(1))) +1;
        TData{sInd,2} = DepthInd;
        set(uih(4),'Data',TData)        
    end
    function Callback_GammaApply(~,~)
        DepthID = GetDepth;
        IM = squeeze(nanmean(ResultData.ShadingImage(:,:,DepthID,:,:),4));
        r = eval(uih(6).String);
        IM = TS_GammaFilt(IM,r);
        IM = TS_AdjImage(IM);
        
        imh(2).CData = rgbproj(IM);
    end
    function Callback_WriteCSV(~,~)
        TData = uih(4).Data;        
        for n = 1:size(TData,1)
            try
                x = eval(TData{n,2});
                TData{n,2} = x;                
            catch err                
            end
        end
        STData = cell2table(TData);
        Input = input('Will, write .csv file. Type Name : ','s');
        if isempty(dir(Input))
            writetable(STData,[Input '.csv'])
            fprintf('Done.\n')
        else
            error('Existing File Name....')
        end
    end
    function Callback_LookObj(~,~)
        Reso = ResultData.Resolution;
        OutImage = logical(imh(5).CData);
        bw = OutImage(:,:,2);
        CC = bwconncomp(bw,26);
        Resion = regionprops(CC,...
                        'Area','Perimeter','Eccentricity',...
                        'MajorAxisLength','MinorAxisLength',... 
                        'MaxFeretProperties','MinFeretProperties',....
                        'Orientation');
        figure('Posi',[0 30 1000 300]),
        x = [...
            [1,4,1];
            [1,4,2];
            [1,4,3];
            [1,4,4];
            ];
        for n = 1:size(x,1)
            Ax = subplot(x(n,1),x(n,2),x(n,3));
            switch n
                case 1
                    X = cat(1,Resion.Area);
                case 2
                    X = cat(1,Resion.MinorAxisLength)*Reso(1);
                case 3
                    X = cat(1,Resion.MajorAxisLength)*Reso(1);
                case 4
                    X = cat(1,Resion.Eccentricity);
            end
            histogram(Ax,X)
        end
    end

end
%% Original script backup copy...
%  Edit J. Murata. 
% Ves = ExDay20180628_PVChR2_Loc03_5789_20191017171726.BWData(2).Size_Filtered_VesselsMask;
% MaskYFP = ExDay20180628_PVChR2_Loc03_5789_20191017171726.BWData(6).MaskYFP;
% 
% vessels_dilate_size = 5; % um
% vessels_dilate_pixels_size = round(vessels_dilate_size /...
%     ExDay20180628_PVChR2_Loc03_5789_20191017171726.Resolution(1));
% vessels_dilate_se = strel('disk',vessels_dilate_pixels_size,0);
% 
% DilateVes = imdilate(Ves,vessels_dilate_se);
% ExYFP = and(MaskYFP, ~DilateVes);


