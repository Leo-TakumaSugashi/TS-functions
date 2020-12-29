function varargout = RyoT_check_Tracking(BaseData,ObjData,RotMovStretchData,OriginalCenter)

%% default setting up
S = Segment_Functions;
same_dist_lim = 10; %% um


%% initialize
id_base = cat(1,BaseData.Result.ID);
xyz_base = cat(1,BaseData.Result.Output_CentroidXYZ);
xyz_base = (xyz_base-1).*BaseData.Resolution;

id_obj = cat(1,ObjData.Result.ID);
xyz_obj = cat(1,ObjData.Result.Output_CentroidXYZ);
xyz_obj = (xyz_obj-1).*ObjData.Resolution;
xyz_objR = S.xyz2RotMoveStretch(xyz_obj,RotMovStretchData,OriginalCenter);

%% main
Lenmap = S.GetEachLength(xyz_base,xyz_objR,ones(1,3));
%% find matching
[D_base,Ind_base] = min(Lenmap,[],1);
[D_obj,Ind_obj] = min(Lenmap,[],2);

TFmap = false(size(Lenmap));
for n = 1:size(Lenmap,2)
    check_base2objID = Ind_base(n);
    if Ind_obj(check_base2objID) == n
        TFmap(check_base2objID,n) = true;    
    end
end
%% create pairs
% Numel = sum(TFmap(:));
[y,x] = find(TFmap);
IDs = cat(2,id_base(x),id_obj(y));
Dind = find(TFmap);
IDs = cat(2,IDs,Lenmap(Dind));



%% output figure
figure
xyz2plot(xyz_base,ones(1,3),'*k')
hold on
xyz2plot(xyz_objR,ones(1,3),'bo')
for n = 1:size(IDs)
    xyz1 = xyz_base(x(n),:);
    xyz2 = xyz_objR(y(n),:);
    xyz2plot(cat(1,xyz1,xyz2),ones(1,3),'r--')
end

figure,imagesc(TFmap)
figure,imagesc(Lenmap)
xlabel('Base (day00)')
ylabel('Object (day 07)')
colorbar

figure,boxplot(IDs(:,3))


varargout{1} = IDs;









