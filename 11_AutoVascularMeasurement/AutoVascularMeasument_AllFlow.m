
OutputReso = 1; % um/pix

mImage = TSmedfilt2(Image,[3 3]);

[RmImage,NewReso] = TS_EqualReso3d_parfor(mImage,Reso,OutputReso);
%% surface 


%% panetrating
Peneto_SEGmargin = 10; %% [um]
Peneto_CutLength = 50;
[Pdim,bw,skel] = TS_PenetDiamAnalysis(RmImage,NewReso);
SEG_penet = TS_AutoSegment_vP(skel,Reso,Peneto_SEGmargin,Peneto_CutLength);

%% compensation for de Analysis ellepsfitting

check = false(SEG_penet.InputSize);
check(SEG_penet.OutputSkelIndex)= 1;
check = and(check,~(Pdim>0));
output = TS_AutoAnalysisDiam_AddAdjPreFWHM(Image,check,Reso,70);

NewPdim = TS_MeasDiam2DiamImage(skel,output.Pointdata);
NewPdim = max(NewPdim,Pdim);

%% 
function 

%  PenetDiamImage = [];
% skel = [];
% Reso = [];
% NewReso = [];
% rsiz = []
MinimumDiameter = 5;

[y,x,z] = ind2sub(size(skel),find(skel(:)));

ty = round((y -1) * Reso(2) / NewReso(2)) + 1;
tx = round((x -1) * Reso(1) / NewReso(1)) + 1;
tz = round((z -1) * Reso(3) / NewReso(3)) + 1;

NewDiamImage = NaN(rsiz,'like',single(1));
for n = 1:length(y)
    NewDiamImage(ty(n),tx(n),tz(n)) = ...
        max(Pdim(y(n),x(n),z(n)),MinimumDiameter);
end

Reco = TS_Diam2Reconst(NewDiamImage,mean(NewReso));