%% Measument Vessels program flow

%% Input
% Image  = [];
% Reso = [];

%% Main Flow
STR = 'MG21_Loc3_marginAll';
 data =  TS_ExtractionPenet_old(Image,Reso);

 Medsiz = [5 5];
 h = fspecial('gaussian',7,4/(2*sqrt(2*log(2))));

 mfImage = TSmedfilt2(Image,Medsiz);
 mfImage = imfilter(mfImage,h,'symmetric');

 mkdir(STR)
 cd(STR)
 save([STR '_EnhaData.mat'],'data','Reso','Medsiz','h','mfImage') 
 
 %% Resize Image
 [RmfImage,NewReso] = TS_EqualReso3d(mfImage,Reso,1);
 REnhanced          = TS_EqualReso3d(data.EnhancedImage,Reso,1);
 
 save([STR '_ResizData.mat'],'RmfImage','Reso','REnhanced','NewReso') 
 clear data mfImage Image
 
 %% Skeleton
 bw = TS_PreSkeleton(REnhanced,NewReso);

 % prepre skel 
    BoldTh = 5 / NewReso(1);
    sesiz = repmat(round(BoldTh*2)+1,1,3);
    SE = false(sesiz);
    SE(round(BoldTh)+1,round(BoldTh)+1,round(BoldTh)+1) = true;
    se = bwdist(SE)<=5;
    tic,cbw = imclose(bw,se);toc,
    %%
    tic,C_skel = TS_Skeleton3D_4Ccode(cbw);toc

    DistBW = bwdist(~cbw);
    Radi = max((DistBW.*single(C_skel)) - 1,0);
    Bold  = Radi > BoldTh;

  save([STR '_BWdata.mat'],'Bold','BoldTh','bw','sesiz','SE','se','cbw','C_skel','DistBW','Radi')
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
 
 
 
 
 
 
 
 
 
 
 