function Answer = TS_FWHM2016(L,val,varargin)
%%  [x1 x2] = TS_FWHM2016(Input,value,Options...)
% [x1 x2] = TS_FWHM2016(Input,value,'type','fwhm','Center',Center_Index...)
%  Input:入力データ(ベクトルデータ)
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
% Answer = TS_FWHM2016(Input,value,'Visible',{|'off'|,'on',...)
%   --->visible analysis resulte
% 
% Answer = TS_FWHM2016(Input,CenterPosition,'Pathname',{|'off'|,'on'},...)
%
% latest edit. 2016/10/22 by sugashi

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
        bwl = L >= val;        
        labelL = bwlabel(bwl);
        labelL = imdilate(labelL,[1 1 0]); %% dilate add --> Go to explain
        
        s = regionprops(bwl,'centroid','Area');
        Area = cat(1,s.Area);
        [~,NUM] = max(Area);
        if isempty(NUM)
%             disp('fwhm-0 max Area Debag')
            Answer = [NaN NaN];
            return
        end
        if isempty(vDiff_Center)
            % Centroidの取得-->Max Areaのみを残す
            Centroid = s(NUM).Centroid(1);
            labelL = labelL==NUM;
        else
            Centroid = vDiff_Center;
            Center_label_xdata = 1:length(L);
            Center_label = and(Center_label_xdata>=Centroid-1,...
                Center_label_xdata<=Centroid+1); 
            % % explain
            %  Input L >=valの領域をラべリングし+1の膨張後、
            %  n_y　に Center位置から±1のインデックスにあるエリアのみを残す。
            %  bwl --> n_y >=　valでendpointの端点を基準(xu2,xd1)に線形近似。
            
            NUM = labelL(Center_label);
            NUM(NUM==0) = [];
            bwl = false(size(L));
            for n = 1:numel(NUM)
                bwl = or(bwl,labelL==NUM(n));
            end            
            labelL = bwl;
        end
        
        n_y = n_y.*double(imdilate(labelL,[0 1 1]));
        bwl = n_y >=val;
        Ind = find(bwl);
        labelL = false(size(L)); %% 
        labelL(Ind(1):Ind(end)) = true;
        clear  bwl s Area NUM  
        % %  Left
        labelL = bwmorph(labelL,'endpoint');
        s = find(labelL);
        xu2 = uint32(s(1));
        if xu2==1
%                 disp('fwhm-NaN Debag')
            xu = nan;
        else
            xu1 = uint32(xu2-1);
            yu2 = n_y(xu2);            
            yu1 = n_y(xu2-1);
            xu2 = double(xu2);xu1 = double(xu1);
            au = (yu2-yu1)./(xu2-xu1);
            bu = yu2-au.*xu2;
            xu = (val-bu)./au;
        end
        % %  Right
        xd1 = uint32(s(end));
        if xd1==length(L)
%                disp('fwhm-NaN_2nd Debag')
           xd = nan;
        else                
            yd1 = n_y(xd1);
            xd2 = uint32(xd1+1);
            yd2 = n_y(xd1+1);
            xd1 = double(xd1); xd2 = double(xd2);
            ad = (yd2-yd1)./(xd2-xd1);
            bd = yd2-ad.*xd2;
            xd = (val-bd)./ad;
        end
        Answer = double([xu xd]);
        Answer(isinf(abs(Answer))) = nan;
        Answer(Answer<0) = nan;
        catch err            
%             disp(['  ' mfilename ' : '  err.message])
%             disp(['   Error Line : ' num2str(err.stack.line)])
%             c = clock;
%             STR =['  ' num2str(c(1)) '/' num2str(c(2)) '/' num2str(c(3)) ' ' ...
%                 num2str(c(4)) ':' num2str(c(5)) ':' num2str(c(6)) ];
%             disp(STR)            
            Answer = [nan nan];
        end
        Xdata = (1:length(L)) - Centroid(1);
        Center = Centroid(1);
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
        
        plot(Xdata,L,'.-')
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
                plot(Xdata,n_y,'o:')
        end
        txh = text(Answer(2)-Center+2,val,['Length=' num2str(diff(Answer))]);
        set(txh,'BackgroundColor','w')
        grid on
        xlabel('Pixels ,(Center = 0)')
        ylabel('Normalized Pixels value [a.u.]')
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

  
