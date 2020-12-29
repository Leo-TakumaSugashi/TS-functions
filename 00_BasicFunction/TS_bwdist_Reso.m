function [Dist,Idx] = TS_bwdist_Reso(bw,Reso)
% see also dist
if numel(bw) > 2^32
    error('input Numel size is over, too big size, can''t calculate.')
end
if (ndims(bw) ~= size(Reso,2))
    error('Input Image size is NOT equal input Resolution')
end

if min(Reso) == max(Reso)
    [Dist,Idx] = bwdist(bw);
    Dist = Dist * min(Reso);
    return
end

%% initialize
Dist = zeros(size(bw),'like',single(1));
Idx = zeros(size(bw),'like',uint32(1));

%% main func.
Index = find(~bw(:));
[y,x,z] = ind2sub(size(bw),Index);

if ismatrix(bw)
    xyz = cat(2,x(:),y(:));
else
    xyz = cat(2,x(:),y(:),z(:));
end


Index0 = find(bw(:));
[y,x,z] = ind2sub(size(bw),Index0);
if ismatrix(bw)
    xyz0 = cat(2,x(:),y(:));
else
    xyz0 = cat(2,x(:),y(:),z(:)); 
end

Len_input = zeros(size(xyz,1),1,'like',single(1));
Index_input = zeros(size(xyz,1),1,'like',uint32(1));
Idx(Index0) = Index0;

%% block ver
name = mfilename;
name(name == '_') = ' ';
% wh = waitbar(0,['Wait...(' name ')']);
fprintf(name)
TS_WaiteProgress(0)
if sum(bw(:)) < 10^5
    BlockNUM = 10;
else
    BlockNUM = 100;
end
Block = round(linspace(1,BlockNUM,size(xyz,1)));
XYZ = xyz;
for k = 1:BlockNUM
    xyz = XYZ(Block == k,:);
    addnum = find(Block==k);
    addnum = addnum(1) - 1;
    repmatsiz = [size(xyz0,1) 1];
    if ~isempty(gcp('nocreate'))
        parfor n = 1:size(xyz,1)
            select = repmat(xyz(n,:),repmatsiz);
            len = (xyz0 - select) .* repmat(Reso,repmatsiz);
            len = sqrt(sum(len .^2 , 2));
            [len,id] = min(len);
            Len_input(n+ addnum) = len(1);
            Index_input(n+ addnum) = Index0(id(1));
        end
    else
        for n = 1:size(xyz,1)
            select = repmat(xyz(n,:),repmatsiz);
            len = (xyz0 - select) .* repmat(Reso,repmatsiz);
            len = sqrt(sum(len .^2 , 2));
            [len,id] = min(len);
            Len_input(n+ addnum) = len(1);
            Index_input(n+ addnum) = Index0(id(1));
        end
    end
%     waitbar(k/BlockNUM,wh);
    TS_WaiteProgress(k/BlockNUM)
end
% close(wh);

%% normal ver
% parfor n = 1:size(xyz,1)
%     len = TS_EachLengthMap2(xyz(n,:),xyz0,Reso);
%     [len,id] = min(len);
%     Len_input(n) = len(1);
%     Index_input(n) = Index0(id(1));
% end

Dist(Index) = Len_input;
Idx(Index) = Index_input;
end

