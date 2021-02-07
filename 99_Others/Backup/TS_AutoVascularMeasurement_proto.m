%% Measument Vessels program flow

% function TS_AutoVascularMeasurement_proto(STR,Image,Reso)

%% Input
% Image  = [];
% Reso = [];
% STR = 

NowDir = cd;
pcoj = parcluster;
pcoj.NumWorkers = 8;

if isdir(STR)
%     error('Input Dir.Name is Exist')
end
if ndims(Image)~=3
    error('Input Image Dim. is NOT 3')
end
if and(~isscalar(Reso),length(Reso)~=3)
    error('Input Resolution is Not Correct')
end

%% Make Dir
mkdir(STR)
 cd(STR)
 save([STR '_Original.mat'],'Image','Reso','STR') 
 
%% Main Flow
% STR = 'K27d00_S36_Loc3';
Time_st = tic;
Enhansed = TS_EnhancedImage(Image,Reso);
%  data =  TS_ExtractionPenet_old(Image,Reso);
toc(Time_st)
 Medsiz = [5 5];
 h = fspecial('gaussian',7,4/(2*sqrt(2*log(2))));
 mfImage = TSmedfilt2(Image,Medsiz);
 mfImage = imfilter(mfImage,h,'symmetric');
 im = max(mfImage,[],3);
 im = rgbproj(cat(3,im,im,im));
 imwrite(im,[STR '_MIPxy.tif'],'tif') 
 save([STR '_Enhansed.mat'],'Enhansed','Medsiz','h','mfImage')
 
 %% Penetrating
 output = TS_ExtraPenet_rescue(Image,Enhansed,Reso);
  SurfaceInd = output.Surface_Index;
  save([STR '_ExtraPenet.mat'],'output')
  clear output
  %% Resize Image
 [RmfImage,NewReso] = TS_EqualReso3d(mfImage,Reso,1);
 REnhansed          = TS_EqualReso3d(Enhansed,Reso,1);
 
 save([STR '_ResizData.mat'],'RmfImage','Reso','REnhansed','NewReso') 
 clear data mfImage Image
 
 %% Skeleton
 bw = TS_PreSkeleton(REnhansed,NewReso);
save([STR '_PreSkeletonBW.mat'],'bw','NewReso') 
 % prepre skel 
    BoldTh = 5 / NewReso(1);
    sesiz = repmat(round(BoldTh*2)+1,1,3);
    SE = false(sesiz);
    SE(round(BoldTh)+1,round(BoldTh)+1,round(BoldTh)+1) = true;
    se = bwdist(SE)<=5;
    tic,cbw = imclose(bw,se);toc,
    %% New Skeleton
    tic,
    C_skel = TS_Skeleton3D_v8(cbw);
    Time = toc;
    save([STR '_NewSkeleton.mat'],'cbw','C_skel','Time','se')
   
    %% 
    DiamOutline = TS_DiamOutline(cbw,C_skel,NewReso);
    Bold  = DiamOutline > 10;
    [skel_Surf,skel_Penet] = TS_Bold2SP(Bold,SurfaceInd);
    skel_SP = and(skel_Surf,skel_Penet);
  save([STR '_DiamOutline.mat'],'DiamOutline','Bold','SurfaceInd','skel_Surf','skel_Penet','skel_SP')
%  skel = Skeleton3D(BW);
%  tic
%  skel2 = TS_bwmorph3d(skel,'thin');toc
%% DiamÅ@measure
Cap_skel = and(C_skel,~skel_SP);
 tic;
poj = parpool;
toc
TIME = tic;
 output_Cap = TS_AutoAnalysisDiam_proto(RmfImage,Cap_skel,NewReso,20);
 Analysis_Diam_Time = toc(TIME)
 save([STR '_MeasDiam.mat'],'output_Cap','Cap_skel','NewReso','Analysis_Diam_Time', '-v7.3')
 clear output_Cap 
 toc(TIME)
 
 output_Bold = TS_AutoAnalysisDiam_proto(RmfImage,skel_SP,NewReso,10+round(max(DiamOutline(:))));
 Analysis_Diam_Time = toc(TIME)
 save([STR '_MeasDiam.mat'],'output_Bold','skel_SP','NewReso','Analysis_Diam_Time', '-v7.3')
 clear output_Bold 
%  output2 = TS_AutoAnalysisDiam_proto(RmfImage(100:200,100:200,end-20:end),skel2(100:200,100:200,end-20:end),NewReso);
%  output = TS_AutoAnalysisDiam_proto(RmfImage,skel2,NewReso);
 
%% SEGMENT

SEG_Cap = TS_AutoSegment1st_New20161021(Cap_skel,NewReso,and(Cap_skel,imdilate(skel_SP,ones(3,3,3))));
save([STR '_SEG_Cap.mat'],'SEG_Cap', '-v7.3')

SEG_Bold = TS_AutoSegment1st_New20161021(skel_SP,NewReso,and(Cap_skel,imdilate(skel_SP,ones(3,3,3))));
save([STR '_SEG_SP.mat'],'SEG_SP', '-v7.3')

 
 
 
 
 
 
 
 
 
 