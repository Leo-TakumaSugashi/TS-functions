function SEGout = TS_SEG2MesActLen(SEG)

Step = 0.01;
OutStep = 1;
Type = 'pchip';
MovWind = 10; % unit um
LineWidth = 2;

SEGout = SEG;
Pdata = SEG.Pointdata;
Reso = SEG.ResolutionXYZ;
for n = 1:length(Pdata)
    xyz = Pdata(n).PointXYZ;
    plen = xyz2plen(xyz,Reso);
    plen = plen(2:end);
    ind = find(plen==0);
    if ~isempty(ind)
        ind = ind+1;
        xyz(ind,:) = [];
        NPdata(n).isequalpoint = true;
        clear plen ind
    end
    try
    [xi,yi,zi,~] = TS_xyzInterp(xyz,Reso,Step,Type);
    [xi,yi,zi,~,ActStep] = TS_xyzInterp(cat(2,xi,yi,zi),Reso,Step,'linear');
    xi = TS_MovingAverage(xi,round(MovWind/ActStep));
    yi = TS_MovingAverage(yi,round(MovWind/ActStep));
    zi = TS_MovingAverage(zi,round(MovWind/ActStep));
    [x,y,z,~,Astep] = TS_xyzInterp(cat(2,xi,yi,zi),Reso,OutStep,'linear');
    catch err
        disp('============= Error ==========')
        warning(err.message)
        disp(['Now Index:' num2str(n)])
        disp('=================== continue...')
        NPdata(n).NewPointXYZ = [];
        NPdata(n).Length = [];
        NPdata(n).ActualStep = [];
        NPdata(n).Info = err;
        continue
    end     
    NPdata(n).NewPointXYZ = cat(2,x,y,z);
    NPdata(n).Length = sum(xyz2plen(cat(2,x,y,z),Reso));
    NPdata(n).ActualStep = Astep;    
end

SEGout.NewPointdata = NPdata;
SEGout.MovingAverageWind = [num2str(MovWind) 'um'];


%% Check figure
LEN = cat(1,NPdata.Length);
Cmap = jet(round(max(LEN)));
figure,
axes
hold on

for n = 1:length(LEN)
    xyz = NPdata(n).NewPointXYZ;
    if isempty(xyz)
        p(n) = nan;
        continue
    end
    p(n) = xyz2plot(xyz,Reso);
    len =  NPdata(n).Length;
    if len <1
        len = uint8(1);
    else
        len = round(len);
    end
    set(p(n),'Color',Cmap(len,:),'Linewidth',LineWidth)
end
setappdata(gcf,'Point',p)
     