function Ans = RyoT_MG_Vessels_Distance_v2019Alpha(NoImageResult,output)


SNR_Limit = 2;
%% initialize

SaveDir = TS_ConvertOurNAS(NoImageResult.SaveDir);
NewDirName = NoImageResult.NewDir;

S = Segment_Functions;
S.Segment = output;
VesReso = output.ResolutionXYZ;
Signal = cat(1,output.Pointdata.Signal);
Noise = cat(1,output.Pointdata.Noise);
SNR = 10* log10(Signal./Noise);
TF = SNR>SNR_Limit;
Diameter = cat(1,output.Pointdata.Diameter);
Diameter(~TF,:) = [];
Signal(~TF,:) = [];
Noise(~TF,:) = [];
SNR(~TF,:) = [];
VXYZ = cat(1,output.Pointdata.PointXYZ);
VXYZ(~TF,:) = [];
Vxyz = (VXYZ-1) .*VesReso;

% % % MG % % %
MGReso = NoImageResult.Resolution;
Ans(1:length(NoImageResult.Result)) = struct(...
    'MG_ID',[],'Minimum_Dist',[],'Vess_ID',[],'Vess_Class',[]);
for n = 1:length(NoImageResult.Result)
    Rdata = NoImageResult.Result(n);
    MGXYZ = Rdata.Output_CentroidXYZ;
    MGxyz = (MGXYZ-1).*MGReso;
    Dist_MG2C = S.GetEachLength(MGxyz,Vxyz,ones(1,3));
    Dist = Dist_MG2C - Diameter/2;
    [D,Ind] = min(Dist);
    try
        Ind = Ind(1);
        D= D(1);
        IDs = S.FindID_xyz(VXYZ(Ind,:));
        Index = S.ID2Index(IDs);
        CLASS = [];
        for k = 1:length(Index)
            CLASS = [CLASS S.Segment.Pointdata(Index(k)).Class ', '];
        end
    catch err
        IDs = 'empty';
        CLASS = 'empty';
        D = nan;
    end    
    Ans(n).MG_ID = Rdata.ID;
    Ans(n).Minimum_Dist = D;
    Ans(n).Vess_ID = IDs;
    Ans(n).Vess_Class = CLASS;
end

%% output figure,
MGxyz = (cat(1,NoImageResult.Result.Output_CentroidXYZ)-1).*MGReso;
V = Sugashi_ReconstructGroup;
p = V.SEGview_Limit([],output,'Diameter');
fgh = gcf;
set(gcf,'Posi',[117    87   707   850])
set(gca,'Posi',[0.0480    0.0735    0.7155    0.8000])
p.LineWidth = 2;
caxis([2 8])
hold on
plot3(MGxyz(:,1),MGxyz(:,2),MGxyz(:,3),'o',...
    'Color',[0 .7 0],...
    'MarkerSize',6);
DistMinus = cat(1,Ans.Minimum_Dist)<-1;
plot3(MGxyz(DistMinus,1),MGxyz(DistMinus,2),MGxyz(DistMinus,3),'*',...
    'Color',[.6 0 0],...
    'MarkerSize',6);

lh = legend('Vasculature Centers','MG Centoroid','Disntance less than -1 um');
lh.Position = [ 0.5433    0.8833    0.4176    0.0871];
ch = colorbar;
ch.Position = [0.7783    0.3024    0.0364    0.3559];
ch.Label.String = 'Diameter [\mum]';

saveas(fgh,[SaveDir filesep NewDirName filesep 'Figure_MG2Vasculature.fig'])

%% write to XLS
X = struct2table(Ans);
writetable(X,...
    [SaveDir filesep NewDirName filesep 'XLSData_MG2Vasculature.csv'])






