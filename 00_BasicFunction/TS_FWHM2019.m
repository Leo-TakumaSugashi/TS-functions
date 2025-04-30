function Output = TS_FWHM2019(Lmap,val)
% latest edit. 2019/11/1 by sugashi

%%
ss = size(Lmap);
Output = nan(ss(2),2);
N_y = double(Lmap');
len = size(Lmap,1);
Centroid = ceil(len/2); %% Centetroid must be biger than val
Lmap = Lmap';
L = Lmap;    
    if isscalar(val)
        bwl = Lmap >= val;
    elseif isvector(val)
        bwl = false(size(Lmap));
        for k = 1:size(Lmap,1)
            bwl(k,:) = Lmap(k,:) >=val(k);
        end
    end
    
    labelL = TS_horizenlabel(bwl,Centroid);%% Centetroid must be biger than val
    labelL = imdilate(labelL,[1 1 1]); %% dilate add --> Go to explain
    N_y = N_y.*double(labelL);
    
    
    if isscalar(val)
        bwl = N_y >=val;
        val = repmat(val,[1,size(Lmap,1)]);
    elseif isvector(val)
        bwl = false(size(Lmap));
        for k = 1:size(Lmap,1)
            bwl(k,:) = N_y(k,:) >=val(k);
        end
    end
    
for k = 1:ss(2)    
    n_y = N_y(k,:);
    try     
        Ind = find(bwl(k,:));
        labelL = false(1,len); %% 
        labelL(Ind(1):Ind(end)) = true;    
        % %  Left
        labelL = bwmorph(labelL,'endpoint');
        s = find(labelL);
        xu2 = uint32(s(1));
        if xu2==1
            xu = nan;
        else
            xu1 = uint32(xu2-1);
            yu2 = n_y(xu2);            
            yu1 = n_y(xu2-1);
            xu2 = double(xu2);xu1 = double(xu1);
            au = (yu2-yu1)./(xu2-xu1);
            bu = yu2-au.*xu2;
            xu = (val(k)-bu)./au;
        end
        % %  Right
        xd1 = uint32(s(end));
        if xd1==len
           xd = nan;
        else                
            yd1 = n_y(xd1);
            xd2 = uint32(xd1+1);
            yd2 = n_y(xd1+1);
            xd1 = double(xd1); xd2 = double(xd2);
            ad = (yd2-yd1)./(xd2-xd1);
            bd = yd2-ad.*xd2;
            xd = (val(k)-bd)./ad;
        end
        Answer = double([xu xd]);
        Answer(isinf(abs(Answer))) = nan;
        Answer(Answer<0) = nan;
    catch err            
        Answer = [nan nan];
    end
   Output(k,:) = Answer;
end
end

function Label = TS_horizenlabel(bw,c)
nend = c -1 ;
Left = true(size(bw,1),1);
Right = Left;
Label = false(size(bw));
Label(:,c) = true;
for n = 1:nend
    l = bw(:,c-n);
    r = bw(:,c+n);
    
    Label(:,c-n) = and(Left,l);
    Label(:,c+n) = and(Right,r);
        
    Left = Label(:,c-n);
    Right = Label(:,c+n);
end
end