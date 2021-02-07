function [A,varargout] = TS_bwmorph3d_old(bw,meth,varargin)
%%  [A,varargout] = TS_bwmorph3d(bw,meth,varargin)
% EndPoint = TS_bwmorph3d(skeleton_bw,'endpoint')
% BranchPoint = TS_bwmorph3d(skeleton_bw,'branchpoint')
% [BranchPoint,BranchPoint_old,BranchPoint_oldest] = TS_bwmorph3d(skeleton_bw,'branchpoint')
% skel = TS_bwmorph3d(skeleton_bw,{'thin' or 'skeleton'})
% Ans = TS_bwmorph3d(skeleton_bw,Method,'view')
%  ---> output figure

%% View Check
if nargin>2 
    VIEW = varargin{1};
else
    VIEW = 'none';
end

if ~islogical(bw)
    error('Input is not logical')
end

%% Main func.
switch lower(meth)
    case 'endpoint'  %edit 2016.Aug.26
        A = false(size(bw));
        for n = 1:6
            se = CreateSE(n);
            fbw = imfilter(uint8(bw),se);            
            A = or(A,and(fbw==1,bw));
        end
        [y,x,z] = ind2sub(size(bw),find(A(:)));
        cropbw = padarray(bw,[1 1 1],0);
        for n = 1:length(y)
            ROI = cropbw(y(n):y(n)+2,x(n):x(n)+2,z(n):z(n)+2);
            ROI(2,2,2) = false;
            s = bwconncomp(ROI,26);
            NUM = s.NumObjects;
            if NUM>1
                A(y(n),x(n),z(n)) = false;
            end
        end
        
        switch lower(VIEW)
            case 'view'
                figure,
                [y,x,z] = ind2sub(size(bw),find(bw(:)));
                plot3(x,y,z,'g.')
                hold on,box on,daspect([1 1 1])
                [y,x,z] = ind2sub(size(A),find(A(:)));
                plot3(x,y,z,'ro')
            case 'none'
            otherwise
                warning([mfilename '... Input View type is NOT Definition.'])
        end    
    case 'branchpoint'  % % 2016.Aug.25 Edit
        [Y,X,Z] = ind2sub(size(bw),find(bw(:)));
        se1 = ones(3,3,3);
%         se2 = false(3,3,3);
%         se2(2,2,2) = true;
%         se2 = bwdist(se2);
        BPf1 = imfilter(uint8(bw),se1).*uint8(bw);
%         BPf2 = imfilter(single(bw),se2).*single(BPf1>3);
        oldestBP = BPf1>3;
        BP = false(size(BPf1));
        % % Maximum filtered B.P
        while max(BPf1(:))>3
            BP = or(BP,BPf1 == max(BPf1(:)));
            % %nearest 26 point ---> false
            bw(imdilate(BP,se1)) = false; 
            BPf1 = imfilter(uint8(bw),ones(3,3,3)).*uint8(bw);
        end        
        LBP = uint32(bwlabeln(BP,26));
        s = regionprops(LBP,'Centroid');
        outputBP = false(size(BP));
        % % Nearest to Centroid Point
        for n = 1:length(s)
            [y,x,z] = ind2sub(size(BP),find(LBP(:)==n));    
            if length(y)==1
                outputBP(y,x,z) = true;
                continue
            else
                p = s(n).Centroid;
                p = padarray(p,[length(y)-1 0],'symmetric','pre');
                xyz = cat(2,x,y,z);
                length_xyz = sqrt(sum((xyz - p).^2,2));
                [~,Ind] = min(length_xyz);
                outputBP(y(Ind(1)),x(Ind(1)),z(Ind(1))) = true;        
            end    
        end        
        A = outputBP;
        if nargout==2
            varargout{1} = BP;
        elseif nargout==3
            varargout{1} = BP;
            varargout{2} = oldestBP;
        end
%         return
        % Check figure BP
        switch lower(VIEW)
            case 'view'
                figure,        
                plot3(X,Y,Z,'g.')
                hold on,box on,daspect([1 1 1])
                [y,x,z] = ind2sub(size(BP),find(BP(:)));
                plot3(x,y,z,'ro')
                [y,x,z] = ind2sub(size(outputBP),find(outputBP(:)));
                plot3(x,y,z,'b>')
                axis tight
                legend('Input','oldBP','BP','location','EastOutside')
            case 'none'
            otherwise
                warning([mfilename '... Input View type is NOT Definition.'])
        end 
    case {'thin','skeleton'}
        if ismatrix(bw)
            A = bwmorph(bw,'thin',Inf);
            return
        end
        timeval = tic;
        bw = padarray(bw,[2 2 2],false);
        DistBW = bwdist(~bw);
        s = sort(DistBW(:));
        stepfind = find(diff(s)>0);
        stepfind = stepfind';
        DistStep = s([stepfind(2:end) length(s)]);
        clear s stepfind
        Endn = numel(DistStep);
        waitbarh = waitbar(0,'Please wait....');
         set(waitbarh,'Name',[mfilename '  ,Skeletoning...'])
        count = 1;
        NUMbw = sum(bw(:));
        for n = 1:Endn
            distBW = DistBW==DistStep(n) ;
            [newY,newX,newZ] = TS_find(distBW,n);
            for k = 1:numel(newY)
                NowY = newY(k);
                NowX = newX(k);
                NowZ = newZ(k);
                ROI = bw (NowY-2:NowY+2, NowX-2:NowX+2 ,NowZ-2:NowZ+2);
                    s = bwconncomp(ROI,26);
                    NUMdef = s.NumObjects;
                ROI(3,3,3) = false;
                    s = bwconncomp(ROI,26);
                    NUM = s.NumObjects;
                ROI = ROI(2:4,2:4,2:4);
                TF1 = NUM == NUMdef; %% 連結性（消しても、object数が不変か）
                TF2 = sum(ROI(:))~=1; %% 端点であるかどうか1st
%                 TF3 = 
                if and(TF1 ,TF2)
                    bw(NowY,NowX,NowZ) = false;
                end
                distBW(NowY,NowX,NowZ) = false;
                waitbar(count/NUMbw,waitbarh,['Please wait...  ' num2str(count) '/' num2str(NUMbw)]) 
                count = count + 1;
            end    
        end
        close(waitbarh)
        TIMEout = toc(timeval);
        disp(['計算時間は   ' num2str(floor(TIMEout/60)) '分 ' num2str(TIMEout-60*floor(TIMEout/60)) '秒 '])
        A = bw(3:end-2,3:end-2,3:end-2);
    otherwise
        error('Input Method is NOT able to analysis...')
end
end

%% for End point
function se = CreateSE(num)
se = ones(3,3,3);
switch num
    case 1
        se(:,3,:) = 0;% Left Plane
    case 2
        se(:,1,:) = 0;% Right Plane
    case 3
        se(3,:,:) = 0;% Top Plane
    case 4
        se(1,:,:) = 0;% Bottom Plane
    case 5
        se(:,:,3) = 0;% Surface Plane
    case 6
        se(:,:,1) = 0;% Deep Plane
end
end

%% 消去の方向性を変更
function [y,x,z] = TS_find(ROI,val)
val = (val/4 - floor(val/4)) * 4;
y = [];
x = [];
z = [];
switch val
    case 0
        for k = 1:size(ROI,3)
            [Y,X] = find(ROI(:,:,k)==true);    
            y = cat(1,y,Y);x = cat(1,x,X);
            z = cat(1,z,ones(numel(Y),1)*k);
        end
    case 1
        for k = 1:size(ROI,3)
            [Y,X] = find(ROI(:,:,k)==true);
            X = flipud(X); Y = flipud(Y);           
            y = cat(1,y,Y);x = cat(1,x,X);
            z = cat(1,z,ones(numel(Y),1)*k);
        end
    case 2
        for k = 1:size(ROI,3)
            [Y,X] = find(ROI(:,:,k)==true);
            [Y,idx] = sort(Y,1,'descend');X = X(idx);
            y = cat(1,y,Y);x = cat(1,x,X);
            z = cat(1,z,ones(numel(Y),1)*k);
        end
    case 3
        for k = 1:size(ROI,3)
            [Y,X] = find(ROI(:,:,k)==true);
            [Y,idx] = sort(Y,1,'descend');X = X(idx);
            X = flipud(X); Y = flipud(Y);   
            y = cat(1,y,Y);x = cat(1,x,X);
            z = cat(1,z,ones(numel(Y),1)*k);
        end
end
        
end
