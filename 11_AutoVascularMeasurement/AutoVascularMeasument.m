%% Measument Vessels program flow

%% Input
% Image  = [];
% Reso = [];
STR = 'MG21_Loc3_marginAll';

 mkdir(STR)
 cd(STR)

%% Main Flow
%% Enhanced Image and denoising
 data =  TS_ExtractionPenet_old(Image,Reso);
 Medsiz = [5 5];
 h = fspecial('gaussian',7,4/(2*sqrt(2*log(2))));
 mfImage = TSmedfilt2(Image,Medsiz);
 mfImage = imfilter(mfImage,h,'symmetric');

 save([STR '_EnhaData.mat'],'data','Reso','Medsiz','h','mfImage') 
 
 %% Resize Image
 [RmfImage,NewReso] = TS_EqualReso3d(mfImage,Reso,1);
 REnhanced          = TS_EqualReso3d(data.EnhancedImage,Reso,1);
 
 save([STR '_ResizData.mat'],'RmfImage','Reso','REnhanced','NewReso') 
 clear data mfImage Image
 
 %% Skeleton
 % Create bw and imfill('hole')
 % main func. is ,bw = TS_Extract2ObjMask, imfill(bw,'hole')
    bw = TS_PreSkeleton(REnhanced,NewReso);
 % pre skel(Noise Reduction)
    BoldTh_um = 5; %% Radius [um]
    BoldTh = BoldTh_um / NewReso(1);
    sesiz = repmat(round(BoldTh*2)+1,1,3);
    SE = false(sesiz);
    SE(round(BoldTh)+1,round(BoldTh)+1,round(BoldTh)+1) = true;
    se = bwdist(SE)<=ceil(BoldTh);
    dips('Closing Processing befor skeletoning to reduct Noise(Shaving)')
    tic,
    cbw = imclose(bw,se);
    toc,
 % skeleton
    tic,
    C_skel = TS_Skeleton3D(cbw);
    toc

 % Diameter outline
 DiamOutline = TS_DiamOutline(cbw,C_skel,[1 1 1]);
 Bold  = DiamOutline > (BoldTh*2);
  save([STR '_BWdata.mat'],'Bold','BoldTh_um','bw','sesiz','SE','se','cbw','C_skel','DiamOutline')
 % Surface and Penet
 [skel_Surf,skel_Penet] = TS_Bold2SP(Bold,size(Bold,3)-100);
  skel_SP = or(skel_Surf,skel_Penet);
%  skel = Skeleton3D(BW);
%  tic
%  skel2 = TS_bwmorph3d(skel,'thin');toc
 %% DiamÅ@measure
 tic;
poj = parpool;
toc
TIME = tic;
 output = TS_AutoAnalysisDiam_proto(RmfImage,C_skel,NewReso);
 Analysis_Diam_Time = toc(TIME)
 save([STR '_MeasDiam.mat'],'output','C_skel','NewReso','Analysis_Diam_Time')
 toc(TIME)
%  output2 = TS_AutoAnalysisDiam_proto(RmfImage(100:200,100:200,end-20:end),skel2(100:200,100:200,end-20:end),NewReso);
%  output = TS_AutoAnalysisDiam_proto(RmfImage,skel2,NewReso);
 
 
 
 
 
 
 
 
 
 
 