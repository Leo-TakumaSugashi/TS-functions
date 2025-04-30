% Original Script...
% /mnt/NAS/Share4/00_Sugashi/10_Since2016/20_Matlab/12_Matlab_data
% /2019_ISOTT_K27K9MG30/K27_ISOTT2019ISOTT/D21Loc1

Pdata = D00toD21_20190619_classfySASV.Pointdata;
PdataObj = D21_R.Pointdata;
catID = cat(1,PdataObj.ID);
Reso =  D00toD21_20190619_classfySASV.ResolutionXYZ;

S = Segment_Functions;

X = [];
Y = [];
Z = [];
W = [];
for n = 1:length(Pdata)
    IDs = Pdata(n).Tracking.IDs;
    xyz1 = Pdata(n).PointXYZ;
    for k = 1:length(IDs)
        xyz2 = PdataObj(S.ID2Index(IDs(k),catID)).PointXYZ;
        [val,D] = S.Evaluate_2Line_Euclidean(xyz1,xyz2);
        p = Pdata(n).Tracking.ID_counts(k);
        p2 = Pdata(n).Tracking.ObjectParcentage(k);
        X = [X,p];
        Y = [Y,val];
        Z = [Z,p2];
        W = [W,D];
    end    
end

Xt = [];
Yt = [];
Zt = [];
Wt = [];
for n = 1:length(Pdata)
    IDs = Pdata(n).TrackingIDs;
    if isempty(IDs)
        continue
    end
    xyz1 = Pdata(n).PointXYZ;
    for k = 1:length(IDs)
        xyz2 = PdataObj(S.ID2Index(IDs(k),catID)).PointXYZ;
        [val,D] = S.Evaluate_2Line_Euclidean(xyz1,xyz2);
        ind = find(Pdata(n).Tracking.IDs == IDs(k));
        p = Pdata(n).Tracking.ID_counts(ind);
        p2 = Pdata(n).Tracking.ObjectParcentage(ind);
        Xt = [Xt,p];
        Yt = [Yt,val];
        Zt = [Zt,p2];
        Wt = [Wt,D];
    end    
end
clear n IDs xyz1 xyz2 k val D ind p p2
%%
X2 = X;
Y2 = Y;
Z2 = Z;
W2 = W;
for n = 1:length(Yt)
    x = Xt(n);
    y = Yt(n);
    z = Zt(n);
    w = Wt(n);
    ind = and( and(X2==x,Y2 == y),and(Z2 ==z,W2==w) );
    X2(ind) = [];
    Y2(ind) = [];   
    Z2(ind) = [];
    W2(ind) = [];
end
clear ind x y z w

%%
figure,
plot3(X2,Y2,Z2,'x')
hold on
plot3(Xt,Yt,Zt,'or')
xlabel('Object Tracked Numels')
ylabel('Euclidean Dist. S.D.')
zlabel('Object Percentage (Tracked Numel / Object Numel)[%]')


%%
figure,
plot3(X2,Z2,W2,'x')
hold on
plot3(Xt,Zt,Wt,'or')
xlabel('Object Tracked Numels')

ylabel('Object Percentage [%]')
zlabel('Eclidian Dist. [\mum]')


%% make table for classfication
DataSet = table(...
    cat(1,X2',Xt'),...
    cat(1,Y2',Yt'),...
    cat(1,Z2',Zt'),...
    cat(1,W2',Wt'),...
    cat(1,false(length(X2),1),true(length(Xt),1)));

%% Save all 2019 09 07
cd '/mnt/NAS/Share4/00_Sugashi/10_Since2016/20_Matlab/12_Matlab_data/2019_ISOTT_K27K9MG30/K27_ISOTT2019ISOTT/D21Loc1/ISOTT2019_20190728'
save Tracking_K27_D00to21_basedata.mat -v7.3

























