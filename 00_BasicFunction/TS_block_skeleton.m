function [A,copy_bw] = TS_block_skeleton(bw,DistBW,varargin)
%% editor s log
% waitbar to WaitProgressBar

timeval = tic;


original_bw = bw;
if nargin == 3
    type = varargin{1};
else
    type = 'Piece';
end

copy_bw = true(size(bw));

if strcmpi('Piece',type) %% piece process or NOT,
copy_bw = false(size(bw));
copy_bw(2:end-1,2:end-1,2:end-1) = true;

%% edge check
%   5
% 1 2 3 4 
%   6
% if size(bw,3) == 3 %% in this case, Original BW is 2D,
%     1 
%   2  3
%     4
% end

if size(bw,3) > 3
    X = bwdist(padarray(false(size(bw)),[1 1 1],true));
    X = X(2:end-1,2:end-1,2:end-1);
else
    X = bwdist(padarray(false(size(bw)),[1 1 0],true));
    X = X(2:end-1,2:end-1,:);
end
addterm = DistBW <= X;
% 
% [X,Y,Z] = meshgrid(1:size(bw,2),1:size(bw,1),1:size(bw,3));
% addterm = and(addterm,DistBW <= flip(X,2));
% addterm = and(addterm,DistBW <= Y);
% addterm = and(addterm,DistBW <= flip(Y,1));
% if size(bw,3) > 3
% addterm = and(addterm,DistBW <= Z);
% addterm = and(addterm,DistBW <= flip(Z,3));
% end
copy_bw = and(copy_bw,addterm);

%% main process(TS_Skeleton3D_v6)
% bw = and(copy_bw,bw);
DistBW(~copy_bw) = 0;
% [y,x,z] = ind2sub(size(bw),find(and(bw(:),copy_bw(:))));
end

s = sort(DistBW(:));
stepfind = find(diff(s)>0);
stepfind = stepfind';
if numel(s) == 0
     A = or(bw,and(~copy_bw,original_bw));
     return
end

DistStep = s([stepfind(2:end) length(s)]);
% clear s stepfind
Endn = numel(DistStep);
fprintf([mfilename '  ,Skeletoning...'])
TS_WaiteProgress(0)
% count = 1;
% NUMbw = sum(bw(:));
% NUMdef = double(1);
% NUM = NUMdef;
xdata = 1:size(bw,2);
ydata = 1:size(bw,1);
zdata = 1:size(bw,3);
for n = 1:Endn
    distBW = DistBW==DistStep(n) ;
    [newY,newX,newZ] = TS_find(distBW,n-1);
    for k = 1:numel(newY)
        NowY = newY(k);
        NowX = newX(k);
        NowZ = newZ(k);
        MaxDist = DistBW(NowY,NowX,NowZ)+2;
        y_ind = and(ydata>=NowY-MaxDist,ydata<=NowY+MaxDist);
        x_ind = and(xdata>=NowX-MaxDist,xdata<=NowX+MaxDist);
        z_ind = and(zdata>=NowZ-MaxDist,zdata<=NowZ+MaxDist);
        ROI = bw(y_ind,x_ind,z_ind);
%         ROI = bw(NowY-2:NowY+2, NowX-2:NowX+2 ,NowZ-2:NowZ+2);
        
%             s = bwconncomp(ROI,26);            
%             NUMdef = s.NumObjects;
            [~,NUMdef] = bwlabeln(ROI,26);
%             mxDestroyArray(NUMdef)
        cbw = bw;
        cbw(NowY,NowX,NowZ) = false;
        ROI = cbw(y_ind,x_ind,z_ind);
%         ROI(3,3,3) = false;
%             s = bwconncomp(ROI,26);
%             NUM = s.NumObjects;
            [~,NUM] = bwlabeln(ROI,26);
%             mxDestroyArray(NUM)
        
        y_ind = and(ydata>=NowY-1,ydata<=NowY+1);
        x_ind = and(xdata>=NowX-1,xdata<=NowX+1);
        z_ind = and(zdata>=NowZ-1,zdata<=NowZ+1);
        DistROI = DistBW(y_ind, x_ind, z_ind);
        ROI = bw(y_ind, x_ind, z_ind);
        sumROI = sum(ROI(:));
        ROIDist = DistROI(ROI);
        CurrentDist = DistBW(NowY,NowX,NowZ);
        TF1 = eq(double(NUM),double(NUMdef)); %% Object Number is Equal or Not
        TF2 = ne(sumROI,1); %% End point or Not
        % ************ v2 Original Term *************
        if ~TF2
            if CurrentDist < ROIDist
                TF2 = true;
            end
        end
        % ********************************************
%                 TF3 = 
        if and(TF1,TF2)
            bw(NowY,NowX,NowZ) = false;
        end
        distBW(NowY,NowX,NowZ) = false;
    end 
    TS_WaiteProgress(n/Endn)
end
TIMEout = toc(timeval);
disp([ '   ' type ' Process, ' num2str(floor(TIMEout/60)) 'min. ' num2str(TIMEout-60*floor(TIMEout/60)) 'sec. '])
A = or(bw,and(~copy_bw,original_bw));
end

function [y,x,z] = TS_find(ROI,val)
val = int8(round((val/6 - floor(val/6)) * 6));
[Y,X,Z] = ind2sub(size(ROI),find(ROI(:)));
y = zeros(size(Y),'like',double(1));
x = y;
z = y;
switch val
    case 0
        [z,Ind] = sort(Z,'descend'); y = Y(Ind); x = X(Ind);
    case 1
        [z,Ind] = sort(Z,'ascend'); y = Y(Ind); x = X(Ind);
    case 2
        [x,Ind] = sort(X,'ascend'); y = Y(Ind); z = Z(Ind);                
    case 3        
        [x,Ind] = sort(X,'descend'); y = Y(Ind); z = Z(Ind);
    case 4
        [y,Ind] = sort(Y,'descend'); x = X(Ind); z = Z(Ind);                
    case 5        
        [y,Ind] = sort(Y,'ascend'); x = X(Ind); z = Z(Ind);
end
        
end

