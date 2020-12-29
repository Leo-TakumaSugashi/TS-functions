function Answer = TS_FWHM2016_20161021(L,val,varargin)
%%  [x1 x2] = TS_FWHM2016(Input,value,Options...)
%  Input:入力データ(ベクトルデータ)
% 
% Answer = TS_FWHM2016(Input,value,'Visible',{|'off'|,'on',...)
%   --->visible analysis resulte
% 
% Answer = TS_FWHM2016(Input,value,'type',{|'fwhm'|,'diff',...)
%   ---> fwhm, Normal version
%      ---> type : fwhm  
%       value：取りたい値(例：半値ならvalue = 0.5); 
%       ※value : 1.0 > value > 0.0
%   ---> diff, Edit 2016 Aug.3rd.
%      ---> type : diff
%             Answer = TS_FWHM2016(Input,CenterPosition,'type','diff',...)
%             Answer = TS_FWHM2016(Input,[],'type','diff','Center',CenterPosition...)     
% 
% Answer = TS_FWHM2016(Input,CenterPosition,'Pathname',{|'off'|,'on'},...)

%%
[Pathname,View,Cal_type,vDiff_Center] = Getoption(varargin{:});
switch lower(Pathname)
    case 'on'
        disp(mfilename('fullpath'))
end

% return
if ~isvector(L)
    errordlg('Input is not Vector!')
    return
end
ss = size(L);
if ss(1)>ss(2)
    L = L';
end
n_y = double(L);


    
switch lower(Cal_type)
    case {'fwhm','normal'}
        try
        
        % Centroidの取得-->Max Areaのみを残す
        bwl = L >= val;
        labelL = bwlabel(bwl);
        s = regionprops(bwl,'centroid','Area');
        Area = cat(1,s.Area);
        [~,NUM] = max(Area);
        if isempty(NUM)
            Answer = [NaN NaN];
            return
        end
        if isempty(vDiff_Center)
            Centroid = s(NUM).Centroid(1);
            labelL = labelL==NUM;
        else
            Centroid = round(vDiff_Center);
            labelL = labelL==labelL(Centroid);
        end
        n_y = n_y.*double(labelL);
        
        
        equalVal = find(n_y==val);
        clear  bwl s Area NUM

        if isempty(equalVal)
%             disp('fwhm-1 debuck')
            labelL = bwmorph(labelL,'endpoint');
            s = regionprops(labelL,'Centroid');
            xu2 = uint16(s(1).Centroid(1));
            if xu2==1 || size(s,1)<2
%                 disp('fwhm-NaN debuck')
                Answer = [NaN NaN];
                return
            end
            yu2 = n_y(xu2);
            xu1 = double(xu2-1);
            yu1 = n_y(xu2-1);
            xu2 = double(xu2);
            au = (yu2-yu1)./(xu2-xu1);
            bu = yu2-au.*xu2;
            xu = (val-bu)./au;

            xd1 = uint32(s(2).Centroid(1));
            if xd1==length(L)
%                disp('fwhm-NaN_2nd debuck')
               Answer = [NaN NaN];
                return
            end
            %%2014 6 4 hennkou
            if xd1 <= size(n_y,2)-1
                yd1 = n_y(xd1);
                xd2 = double(xd1+1);
                yd2 = n_y(xd1+1);
                xd1 = double(xd1);
                ad = (yd2-yd1)./(xd2-xd1);
                bd = yd2-ad.*xd2;
                xd = (val-bd)./ad;
%                 disp('fwhm-xd1 <= size(n_y,2)-1 debuck')
            end

            elseif length(equalVal)==2
                xu = equalVal(1);
                xd = equalVal(2);
%                 disp('fwhm-length(equalVal)==2 debuck')
        else
            if length(equalVal)>1
                xu = equalVal(1);
                xd = equalVal(end);
            else
             if   equalVal < Centroid
%                 disp('fwhm-equralVal<Centroid debuck')
                xu = equalVal;
                labelL = bwmorph(labelL,'endpoint');                
                s = regionprops(labelL,'Centroid');
                xd1 = uint16(s(2).Centroid(1));
                if xd1 <= size(n_y,2)-1
                    yd1 = n_y(xd1);
                    xd2 = double(xd1+1);
                    yd2 = n_y(xd1+1);
                    xd1 = double(xd1);
                    ad = (yd2-yd1)./(xd2-xd1);
                    bd = yd2-ad.*xd2;
                    xd = (val-bd)./ad;
                else
                    xd = nan;
                end                
             else 
%                 disp('fwhm-Else debuck')
                xd = equalVal;
                try
                    labelL = bwmorph(labelL,'endpoint');
                    s = regionprops(labelL,'Centroid');
                    xu2 = uint16(s(1).Centroid(1));
                    yu2 = n_y(xu2);
                    xu1 = double(xu2-1);
                    yu1 = n_y(xu2-1);
                    xu2 = double(xu2);
                    au = (yu2-yu1)./(xu2-xu1);
                    bu = yu2-au.*xu2;
                    xu = (val-bu)./au;
                catch err                    
                    disp(err.message)
                    xu = nan;
                    clear err
                end
             end
            end
        end
        Xdata = (1:length(L)) - Centroid(1);
        Center = Centroid(1);
        Answer = double([xu xd]);
        Answer(isinf(abs(Answer))) = nan;
        Answer(Answer<0) = nan;
        catch err
            disp(err)
            Answer = [nan nan];
        end
    case 'diff'
        if and(isempty(vDiff_Center),isempty(val))
            vDiff_Center = length(L)/2;
        else 
            vDiff_Center = val;            
        end
        Xdata = (1:length(L)) - vDiff_Center;
        Indx = 1:length(L);
        x1 = diff(L(Indx<vDiff_Center));
        x1_Ind = find(x1==max(x1));
        if isempty(x1_Ind)
            x1_Ind = nan;
        end
        x1 = x1_Ind(end) + 0.5;
        x2 = diff(L(Indx>vDiff_Center));
        [~,x2] = min(x2);
        x2 = x2 + sum(Indx<=vDiff_Center) + .5;
        Answer = double([x1 x2]);
        Center = vDiff_Center;
        val = max(L)/2;
end


switch lower(View)
    case 'on'
        figure('Color','w')
        
        plot(Xdata,L,'o:')
        hold on
        switch Cal_type
            case 'diff'
                oh = plot([Answer(1) Answer(1)]-Center,[min(L) max(L)],'.-');
                set(oh,'Color',[.5 0 0],'LineWidth',2,'LineStyle','--')
                oh = plot([Answer(2) Answer(2)]-Center,[min(L) max(L)],'.-');
                set(oh,'Color',[.4 .2 0],'LineWidth',2,'LineStyle','-.')                
                plot([Answer(1) Answer(2)]-Center,[val val],'r:')
                plot(Xdata(1:end-1)+0.5,diff(L),'gx--')
                legend('Input','Left-side','Right-side','Length','diff(Input)')
            case {'fwhm','normal'}
                plot(Answer-Center,[val val],'r*-')
                plot(Xdata,labelL)
        end
        txh = text(Answer(2)-Center+2,val,['Length=' num2str(diff(Answer))]);
        set(txh,'BackgroundColor','w')
        grid on
        xlabel('Pixels ,(Centroid = 0)')
        ylabel('Intensity')
        title(Cal_type)
end
end

function [Pathname,View,Cal_type,vDiff_Center] = Getoption(varargin)
View = 'off';
Pathname = 'off';
Cal_type = 'fwhm';
vDiff_Center = []; %% version Diff's value
if nargin==0
    return
else    
    Option = varargin;
    for n = 1:ceil(length(Option)/2)
        STR = Option{(n*2-1)};
        if 2*n>length(Option)
            TYPE = 'off';
        else
            TYPE = Option{n*2};
        end
        switch lower(STR)
            case {'visible','view'}
                View = TYPE;
            case {'path','pathname'}
                Pathname = TYPE;
            case 'type'
                Cal_type = TYPE;
            case {'center','cent'}
                vDiff_Center = TYPE;
            otherwise
                disp([mfilename ' : ???'])
        end
    end
end
end

  
