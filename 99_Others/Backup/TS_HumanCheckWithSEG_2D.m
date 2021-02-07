function HumanCheckedSEG = TS_HumanCheckWithSEG_2D(Image,Reso,SEG)

fgh = figure('Position',[100 100 1500 900],...
    'WindowButtonDownFcn',@TSWindowButtonDonwFcn,...
    'WindowButtonUpFcn',@TSWindowButtonUpFcn);

uih = uicontrol('String','Input Diameter',...
    'Units','Normalized',...
    'Position',[.9 .9 .1 .1],...
    'Callback',@Callback_InputDiam)

SEGReso = SEG.ResolutionXYZ;
Pdata = SEG.Pointdata;
n = 1;
setappdata(fgh,'CurrentIndex',n)
setappdata(fgh,'SEGReso',SEGReso)
setappdata(fgh,'Pointdata',Pdata)

axh = axes;
Mdata.OrldSelectionTypeDown.Type = [];
Mdata.OrldSelectionTypeDown.Axes = axh;
setappdata(fgh,'Mousdata',Mdata);

xdata = (0:size(Image,2)-1) * Reso(1);
ydata = (0:size(Image,1)-1) * Reso(2);
imh = imagesc(Image,'Xdata',xdata,'Ydata',ydata);
colormap(gray(256))
axis image 
hold on






xy = Pdata(n).PointXYZ(:,1:2);
xy = (xy -1) .*Reso(1:2);
ph = plot(xy(:,1),xy(:,2),'.r');
title(['Segment Num.' num2str(n) '/' num2str(length(Pdata)) ' , ID:' ...
    num2str(Pdata(n).ID)])


HumanCheckedSEG = SEG;


    function Callback_InputDiam(~,~)    
        S = Segment_Functions;
        Index = getappdata(fgh,'CurrentIndex');
        ROI = findobj(axh,'Tag','Human_Measure');
%         ROIxy = nan(length(ROI),3);
%         D = nan(length(ROI),1);
        
        
        xyz = Pdata(Index).PointXYZ;
        Diameter = nan(size(xyz,1),1);
%         Diameter(:) = nan;
        Posi = struct('Position',[]);
       
        for k = 1:length(ROI)
%             ROIxy(k,1:2) = nanmean(ROI(k).Position,1);
            roi_xy =[nanmean(ROI(k).Position,1) ,0];
            Posi(k).Position = ROI(k).Position;
            roi_xy = roi_xy./SEGReso +1;
            len = S.GetEachLength(roi_xy,xyz,SEGReso);
            [~,ind] = min(len);
            mag = diff(ROI(k).Position,[],1);
            mag = hypot(mag(1),mag(2));
            if mag < Reso(1)
                continue
            end
            Diameter(ind) = mag;
        end
%         keyboard
        %% interpolation        
        plen = S.xyz2plen(xyz,SEGReso);
        OriginalLen = cumsum(plen);
        X = OriginalLen;
        X(isnan(Diameter)) = [];
        Diameter(isnan(Diameter)) = [];
        
        vp = interp1(X,Diameter,OriginalLen,'linear');        
        Pdata(Index).Diameter = vp;
        Pdata(Index).HumanROI = Posi;
        Index = Index + 1;
        if Index > length(Pdata)
            keyboard
        end
        setappdata(fgh,'CurrentIndex',Index);
        delete(ROI)
        title(['Segment Num.' num2str(Index) '/' num2str(length(Pdata)) ...
            ' , ID:' num2str(Pdata(Index).ID)])
        delete(ph)
        xy = Pdata(Index).PointXYZ(:,1:2);
        xy = (xy -1) .*Reso(1:2);
        ph = plot(imh.Parent,xy(:,1),xy(:,2),'.r'); 
    end




%% =====  ButtonDown&Up Fcn ====
    function TSWindowButtonDonwFcn(fgh,~)
        Type = get(fgh,'SelectionType');
        Mdata = getappdata(fgh,'Mousdata');
        Ord_Type = Mdata.OrldSelectionTypeDown.Type;
        Mdata.OrldSelectionTypeDown.Type = Type;
        Mdata.OrldSelectionTypeDown.Axes = get(fgh,'CurrentAxes');
        if ~isempty(get(fgh,'CurrentAxes'))
            Mdata.OrldSelectionTypeDown.CurrentPoint = get(get(fgh,'CurrentAxes'),'CurrentPoint');
        else
            Mdata.OrldSelectionTypeDown.CurrentPoint = [];
        end
        setappdata(fgh,'Mousdata',Mdata)
        end

    function TSWindowButtonUpFcn(fgh,~)
        Type = get(fgh,'SelectionType');
        Mdata = getappdata(fgh,'Mousdata');
        Mdata.OrldSelectionTypeUp.Type = Type;
        Mdata.OrldSelectionTypeUp.Axes = get(fgh,'CurrentAxes');
        if ~isempty(get(fgh,'CurrentAxes'))
            Mdata.OrldSelectionTypeUp.CurrentPoint = get(get(fgh,'CurrentAxes'),'CurrentPoint');
        else
            Mdata.OrldSelectionTypeUp.CurrentPoint = [];
        end

        axh = gca;

        switch Type
            case  {'extend','alt'}
                h = drawline(axh);
                h.Tag = 'Human_Measure';
                Mdata.OrldSelectionTypeUp.Type = [];
            otherwise
        %         fprintf('\n ... \n')
        end
        setappdata(fgh,'Mousdata',Mdata)
        disp("########################################")
    end




end