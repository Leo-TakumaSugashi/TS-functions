
Margin = 10; %um

[y,x,z] = ind2sub(size(skel),find(skel(:)));
% •\–Ê‚©‚ç‚É“ü‚ê‘Ö‚¦
[z,id] = sort(z,'descend');
x = x(id);
y = y(id);

%% ‘S“_‚Æ•Û‘¶“X‚Ì‹æ•Ê
All = cat(2,x,y,z);
% FindP = cat(2,...
%     (x-1) * Reso(1),...
%     (y-1) * Reso(2),...
%     (z-1) * Reso(3));
clear x y z id 

FindAll = All;
%% 
TF = true;
c = 1;
DeleteP = [];
while TF
    tf = true;
    sp = FindAll(1,:);
    FindAll(1,:) = [];
    xyz = sp;
    if ~isempty(FindAll)
        while tf
        Len = TS_EachLengthMap2(sp,FindAll,Reso);
        [len,ID] = min(Len); 
        if len(1) > Margin
            tf = false;
        else
            if numel(len)>1
                check = FindAll(ID,:);
                check = TS_EachLengthMap(sp,check,Reso);
                [~,id] = min(check);
                ID = ID(id(1));
                len = Len(ID);
            end
            np = FindAll(ID,:);
            xyz = cat(1,xyz,np);        
            sp = np;
            FindAll(ID,:) = [];
            if isempty(FindAll)
                tf = false;
            end
        end    
        end
    end
    if size(xyz,1)>1
        Pointdata(c).PointXYZ= xyz;
        Pointdata(c).Length = sum(xyz2plen(xyz,Reso));
        c = c + 1;
    else
        DeleteP = cat(1,DeleteP,xyz);
    end
    if isempty(FindAll)
        TF = false;
    end
    
end
SEG.Type = 'Penetrating';
SEG.InputSize = size(skel);
SEG.InputFOV = Reso .* (size(skel)-1);
SEG.Pointdata = Pointdata; clear Pointdata
SEG.ResolutionXYZ = Reso;
SEG.DeletePoint = DeleteP;
clear FindAll All sp c np TF tf id len Len ID DeleteP

