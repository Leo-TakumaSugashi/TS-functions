function [A,varargout] = TS_bwmorph3d_v2019a(bw,meth,varargin)
%%  [A,varargout] = TS_bwmorph3d(bw,meth,varargin)
% EndPoint = TS_bwmorph3d(skeleton_bw,'endpoint')
% BranchPoint = TS_bwmorph3d(skeleton_bw,'branchpoint')
% [BranchPoint,BranchPoint_old,BranchPoint_oldest,EndP] = TS_bwmorph3d(skeleton_bw,'branchpoint')
% skel = TS_bwmorph3d(skeleton_bw,{'thin' or 'skeleton'})
% Ans = TS_bwmorph3d(skeleton_bw,Method,'view')
%  ---> output figure
% 
% Editor log, baseed function is from TS_bwmorph3d, 
%             Created 2019.0701, Sugashi. 
%       Using bwmorph3, 
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
    case 'endpoint'  
        %% edit 2017. May, 1st 
%         Index = find(bw(:));
%         [y,x,z] = ind2sub(size(bw),Index);
%         y1 = y -1; y2 = y + 1;
%         x1 = x -1; x2 = x + 1;
%         z1 = z -1; z2 = z + 1;clear x y z
%         xdata = 1:size(bw,2);
%         ydata = 1:size(bw,1);
%         zdata = 1:size(bw,3);
%         Id = false(size(y1));
%         for n = 1:length(y1)
%             x = and(xdata>=x1(n),xdata<=x2(n));
%             y = and(ydata>=y1(n),ydata<=y2(n));
%             z = and(zdata>=z1(n),zdata<=z2(n));
%             ROI = bw(y,x,z);
%             Id(n) = sum(ROI(:)) <=2;
%         end
%         Index = Index(Id);
%         A = false(size(bw));
%         A(Index) = true;
        %% edit 2016.Aug.26
        try
            A = bwmorph3(bw,'endpoint');
        catch err
            disp(err.message)
        
            A = false(size(bw));
            fprintf('Wait... Finding End Point')
            TS_WaiteProgress(0);
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
                TS_WaiteProgress(n/length(y))
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
        EndP = bwmorph3(bw,'endpoint');
%         Counter = padarray(bw,[1 1 1],false);
%         siz = ones(1,3);
%         for n = 1:3
%             siz(n) = size(bw,n);
%         end
        try
            BPf = imfilter(gpuArray(uint8(bw)),ones(3,3,3));
            BPf = BPf .* uint8(bw);
            BPf = gather(BPf);
            reset(gpuDevice)
        catch err
            disp(err.message)
            BPf = imfilter(uint8(bw),ones(3,3,3));
            BPf = BPf .* uint8(bw);
        end
        oldestBP = BPf  > 3;
%         oldestBP = bwmorph3(bw,'branch');
    
        
        [LBP,NUM] = bwlabeln(oldestBP,26);  
        s = regionprops(LBP,'Centroid','PixelIdxList');
        Siz = size(LBP);
        outputBP = false(size(bw));
        % Nearest to Centroid Point
        fprintf('Finding Centroid of Branch group points.\n')
        if ~isempty(gcp('nocreate'))
            fprintf([' Numels...' num2str(NUM)])
            Index(1:NUM) = struct('xyz',[]);
            parfor n = 1:NUM
                [y,x,z] = ind2sub(Siz,s(n).PixelIdxList);    
                if length(y)==1
                    Index(n).xyz = [x y z];
                else
                    p = s(n).Centroid;
                    xyz = cat(2,x,y,z);
                    length_xyz = sum((xyz - p).^2,2);
                    [~,Ind] = min(length_xyz);
                    Index(n).xyz = [x(Ind(1)),y(Ind(1)),z(Ind(1))];        
                end                
            end
            fprintf('..Writing...')
            for n = 1:NUM
                outputBP(Index(n).xyz(2),...
                    Index(n).xyz(1),...
                    Index(n).xyz(3)) = true;
            end
            fprintf('...Done. \n')
        else                   
            TS_WaiteProgress(0)
            for n = 1:NUM
                [y,x,z] = ind2sub(Siz,s(n).PixelIdxList);    
                if length(y)==1
                    outputBP(y,x,z) = true;
                    TS_WaiteProgress(n/NUM)
                    continue
                else
                    p = s(n).Centroid;                
                    xyz = cat(2,x,y,z);
                    length_xyz = sqrt(sum((xyz - p).^2,2));
                    [~,Ind] = min(length_xyz);
                    outputBP(y(Ind(1)),x(Ind(1)),z(Ind(1))) = true;        
                end
                TS_WaiteProgress(n/NUM)
            end        
        end
        A = outputBP;
        if nargout>1 , varargout{1} = [];end
        if nargout>2 , varargout{2} = oldestBP;end
        if nargout>3 , varargout{3} = EndP; end
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
%         waitbarh = waitbar(0,'Please wait....');
%          set(waitbarh,'Name',[mfilename '  ,Skeletoning...'])
        count = 1;
        NUMbw = sum(bw(:));
        
        for n = 1:Endn
            distBW = DistBW==DistStep(n) ;
            [newY,newX,newZ] = TS_find(distBW,n);
            fprintf(['Distance Numel : ' num2str(n) '/' num2str(Endn)])
            TS_WaiteProgress(0)
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
                TF1 = NUM == NUMdef; %% ??øΩ?øΩA??øΩ?øΩ??øΩ?øΩ??øΩ?øΩ??øΩ?øΩ??øΩ?øΩi??øΩ?øΩ??øΩ?øΩ??øΩ?øΩ??øΩ?øΩ??øΩ?øΩƒÇÔøΩ??øΩ?øΩAobject??øΩ?øΩ??øΩ?øΩ??øΩ?øΩ??øΩ?øΩ??øΩ?øΩs??øΩ?øΩœÇÔøΩ??øΩ?øΩj
                TF2 = sum(ROI(:))~=1; %% ??øΩ?øΩ[??øΩ?øΩ_??øΩ?øΩ≈ÇÔøΩ??øΩ?øΩÈÇ©??øΩ?øΩ«ÇÔøΩ??øΩ?øΩ??øΩ?øΩ1st
%                 TF3 = 
                if and(TF1 ,TF2)
                    bw(NowY,NowX,NowZ) = false;
                end
                distBW(NowY,NowX,NowZ) = false;
%                 waitbar(count/NUMbw,waitbarh,['Please wait...  ' num2str(count) '/' num2str(NUMbw)])                 
                TS_WaiteProgress(k/numel(newY))
            end    
        end
%         close(waitbarh)
        TIMEout = toc(timeval);
        disp([' Tic,toc, Time :   ' num2str(floor(TIMEout/60)) 'min. ' num2str(TIMEout-60*floor(TIMEout/60)) 'sec. '])
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

%% ??øΩ?øΩ??øΩ?øΩ??øΩ?øΩ??øΩ?øΩ??øΩ?øΩÃïÔøΩ??øΩ?øΩ??øΩ?øΩ??øΩ?øΩ??øΩ?øΩ??øΩ?øΩ??øΩ?øΩœçX
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
