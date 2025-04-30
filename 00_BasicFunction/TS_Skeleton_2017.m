% BW = data.bw;
% DistBW = data.DistBW;
function BW_output = TS_Skeleton_2017(BW,varargin)
%% TS_Skeleton_2017
narginchk(1,2)
T = tic;
if nargin == 1
    EdgeType = 'off';
else
    EdgeType = varargin{1};
end
switch EdgeType
    case 'off'
        disp('Edge type off')
        if ismatrix(BW)
            BW = padarray(BW,[1 1],0);
            DistBW = bwdist(~BW);
            DistBW = padarray(DistBW,[0 0 1],0);
            BW = padarray(BW,[0 0 1],0);
        %     ISmatrix = true;
        else
            BW = padarray(BW,ones(1,3),0);
            DistBW = bwdist(~BW);
        %     ISmatrix = false;
        end
    case 'on'
        disp('Edge type on')
%         DistBW = padarray(bwdist(~BW),ones(1,3),0);
        DistBW = bwdist(~padarray(BW,ones(1,3),'replicate'));
        BW = padarray(BW,ones(1,3),0);        
    otherwise
        error('Input EdgeType is NOT Correct')
end

%% for block process
Margin = 0;
% StepSize = 50 + Margin;
% StepSize = max(round(min(size(BW))/2),50) + Margin;
% 
% StepSizeY =  linspace(1,size(BW,1),max(floor(size(BW,1) / StepSize)+1,2));
% StepSizeX =  linspace(1,size(BW,2),max(floor(size(BW,2) / StepSize)+1,2));
% StepSizeZ =  linspace(1,size(BW,3),max(floor(size(BW,3) / StepSize)+1,2));

StepSizeY =  linspace(1,size(BW,1),3);
StepSizeX =  linspace(1,size(BW,2),3);
StepSizeZ =  linspace(1,size(BW,3),3);


ydata = 1:size(BW,1);
xdata = 1:size(BW,2);
zdata = 1:size(BW,3);
BlockData = struct('bw',[],'DistBW',[],'idY',[],'idX',[],'idZ',[],...
    'skel',[],'Area',[]);
c = 1;
for iy = 1:length(StepSizeY)-1
for ix = 1:length(StepSizeX)-1
for iz = 1:length(StepSizeZ)-1
    idY = and(ydata >= StepSizeY(iy), ydata<= StepSizeY(iy + 1) - Margin);
    idX = and(xdata >= StepSizeX(ix), xdata<= StepSizeX(ix + 1) - Margin);
    idZ = and(zdata >= StepSizeZ(iz), zdata<= StepSizeZ(iz + 1) - Margin);
    bw = BW(idY,idX,idZ);
    d = DistBW(idY,idX,idZ);
    BlockData(c).bw = bw;
    BlockData(c).DistBW = d;
    BlockData(c).idY = idY;
    BlockData(c).idX = idX;
    BlockData(c).idZ = idZ;
    c = c + 1;
end
end
end
disp(['  piece number ...' num2str(c -1) ])
if c < 4
    BW_output = TS_block_skeleton(BW,DistBW);
    BW_output = BW_output(2:end-1,2:end-1,2:end-1);
    return
end



clear c iy ix iz idZ idY idX bw d ydata xdata zdata 
%% Skeleton parfor
parfor n = 1:length(BlockData)
    bw =BlockData(n).bw;
    d = BlockData(n).DistBW;     
    [s,c] = TS_block_skeleton(bw,d);
    BlockData(n).skel = s;
    BlockData(n).Area = c;
end

%% set Original size 
DistBW_copy = DistBW;
for n = 1:length(BlockData)
    idx = BlockData(n).idX;
    idy = BlockData(n).idY;
    idz = BlockData(n).idZ;
    d = DistBW_copy(idy,idx,idz);
    d(BlockData(n).Area) = 0;
    DistBW_copy(idy,idx,idz) = d; 
    BW(idy,idx,idz) = BlockData(n).skel;
end
clear idx idy idz d


%% 
% BW = padarray(BW,ones(1,3),0);
% DistBW_copy = padarray(DistBW_copy,ones(1,3),0);
BW_output = TS_block_skeleton(BW,DistBW_copy,'Finish');
BW_output = BW_output(2:end-1,2:end-1,2:end-1);


toc(T)







