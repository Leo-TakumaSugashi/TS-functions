function [A,B,TIMEout] = TS_Skeleton3D_v9(bw)
% 

% coder.extrinsic('bwlabeln')
% A = false(size(bw));

timeval = tic;
bw = padarray(bw,[1 1 1],false);
DistBW = bwdist(~bw);
% ******* v8 Engine *********
bw = Skeleton3D(bw);
B = bw(2:end-1,2:end-1,2:end-1);
DistBW(~bw) = 0;
% MaxDist = max(max(DistBW(:)),2);
DistBW_step = imfilter(DistBW,ones(3,3,3));
DistBW_step(~bw) = 0;
% ******* v8 Engine *********
 



s = sort(DistBW_step(:));
stepfind = find(diff(s)>0);
stepfind = stepfind';
DistStep = s([stepfind(2:end) length(s)]);
% clear s stepfind
Endn = numel(DistStep);
waitbarh = waitbar(0,'Please wait....');
%  set(waitbarh,'Name',[mfilename '  ,Skeletoning...'])
count = 1;
NUMbw = sum(bw(:));
% NUMdef = double(1);
% NUM = NUMdef;
xdata = 1:size(bw,2);
ydata = 1:size(bw,1);
zdata = 1:size(bw,3);
for n = 1:Endn
    distBW = DistBW_step==DistStep(n) ;    
%     [newY,newX,newZ] = TS_find(distBW,n-1);
    [newY,newX,newZ] = ind2sub(size(distBW),find(distBW(:)));
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
        ROI = bw(NowY-1:NowY+1, NowX-1:NowX+1 ,NowZ-1:NowZ+1);
        DistROI = DistBW_step(NowY-1:NowY+1, NowX-1:NowX+1 ,NowZ-1:NowZ+1);
        TF1 = eq(double(NUM),double(NUMdef)); %% Object Number is Equal or Not
        TF2 = ne(sum(ROI(:)),1); %% End point or Not
        % ************ v2 Original Term *************
        if ~TF2
            if DistROI(2,2,2) < DistROI(ROI)
                TF2 = true;
            end
        end
        % ********************************************
%                 TF3 = 
        if and(TF1,TF2)
            bw(NowY,NowX,NowZ) = false;
        end
        distBW(NowY,NowX,NowZ) = false;
        waitbar(count/NUMbw,waitbarh,['Please wait...  ' num2str(count) '/' num2str(NUMbw)]) 
        count = count + 1;
    end    
end
close(waitbarh)
TIMEout = toc(timeval);
disp(['ŒvŽZŽžŠÔ‚Í   ' num2str(floor(TIMEout/60)) '•ª ' num2str(TIMEout-60*floor(TIMEout/60)) '•b '])
A = bw(2:end-1,2:end-1,2:end-1);
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


