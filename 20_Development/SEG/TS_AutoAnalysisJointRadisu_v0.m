function [NewSEG,Radius,Mov] = TS_AutoAnalysisJointRadisu_v0(fImage,inReso,MeasureType,SEG)



Sf = Segment_Functions;
Rf = Reconstruction_Group;
LinRotLength = 70;
interpMethod = 'makima';
DiameterInterpMethod = 'linear';
AddRadius = 0;

Sf.Segment = SEG;
Sf = Sf.Modify_BranchPointMatrix();
Pdata = Sf.Segment.Pointdata;

BPcheck = Sf.Segment.BPmatrix;
BPcheck(BPcheck(:,5)<3,:) = [];
theta = linspace(0,2*pi,360);
[X,Y] = Rf.GetLinePro2mesh([0 0],LinRotLength,inReso(1:2),theta);
center = ceil(size(X,1)/2);
Radius = nan(size(BPcheck,1),1);
Theta = Radius;


fgh = figure('Position',[10 10 900 400]);
axh = axes(fgh,'Position',[0.05 0.15 0.35 0.8]);

axh(2) = axes(fgh,'Position',[0.45 0.15 0.52 0.8]);
c = 1;
for n = 1:size(BPcheck,1)
    cla(axh(1))
    imh = imagesc(axh(1),fImage(:,:,1));axis(axh(1),'image');axis(axh(1),'off');
    Mov(c) = getframe(fgh);c = c+1;
    %% need set up 3d
    im = fImage;
    %%%%%%%%%%%%%%%%%
    Xq = X+BPcheck(n,1);
    Yq = Y+BPcheck(n,2);
    im = interp2(single(im),Xq,Yq,interpMethod);
    if strcmpi(MeasureType,'fwhm')
        fwhm = TS_FWHM2019(im,0.5);
    else
    end
    [R,ind] = min((fwhm(:,2)-center)*inReso(1));
    Radius(n) = R;
    Theta(n) = theta(ind);
%     %% for mov
%     for cn = 1:size(Xq,2)
%         xdata = Xq(center:end,cn);
%         ydata = Yq(center:end,cn);
%         hold(axh(1),'on')
%         if cn==1
%             ph1 = plot(axh(1),xdata,ydata);
%             ph1.LineWidth = 3;
%             ph1.Color = [0 .7 0];
%         else
%             ph1.XData = xdata;
%             ph1.YData = ydata;
%         end
%         ph2 = plot(axh(2),theta(1:cn),abs(fwhm(1:cn,2)-center)*inReso(1));
%         ph2.LineWidth = 3;
%         ph2.Color = [0.2 .2 .2];
%         axh(2).XLim = [0 2*pi];
%         axh(2).YLim = [0 LinRotLength/2+1];
%         ylabel(axh(2),'Radius [\mum]')
%         xlabel(axh(2),'\theta [rad.]')
%         drawnow
%         Mov(c) = getframe(fgh);c = c+1;
%     end
    
    %% for NewSEG
    IDs = Sf.FindID_xyz(BPcheck(n,1:3));
    IND = Sf.ID2Index(IDs)
    for k = 1:length(IND)
        xyz = Pdata(IND(k)).PointXYZ;
        TFx = single(BPcheck(n,1))==single(xyz(:,1));
        TFy = single(BPcheck(n,2))==single(xyz(:,2));
        TFz = single(BPcheck(n,3))==single(xyz(:,3));
        TF = and(and(TFx,TFy),TFz);
        Pdata(IND(k)).Diameter(TF) = Radius(n)*2;
        len = Sf.GetEachLength(BPcheck(n,1:3),xyz,SEG.ResolutionXYZ);
        EnableOffInd = len<=Radius(n)+AddRadius; %%%% Important
        
        EnableOffInd(TF) = false;
        
        BranchInd = Sf.BranchInXYZ(Pdata(IND(k)).Branch,xyz,SEG.ResolutionXYZ);
        if ~isempty(BranchInd)
            EnableOffInd(BranchInd) = false;
        end
        
        Pdata(IND(k)).Diameter_EnablePoint(EnableOffInd) = false;
        Dind = Pdata(IND(k)).Diameter_EnablePoint;
        Data = Pdata(IND(k)).Diameter;
        Data = Data(Dind);
        len = cumsum(Sf.xyz2plen(xyz,SEG.ResolutionXYZ));
        lenq = len(Dind);
        NewData = interp1(lenq,Data,len,DiameterInterpMethod);
        Pdata(IND(k)).Diameter = NewData;
    end
end
NewSEG = Sf.Segment;
NewSEG.Pointdata = Pdata;






