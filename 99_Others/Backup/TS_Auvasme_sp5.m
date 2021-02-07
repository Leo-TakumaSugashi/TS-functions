%% Measument Vessels program
function output = TS_Auvasme_sp5(STR,Image,Reso)
% this original program is TS_AtVasMeas_Flow_sp5_v2.
% but this function need to input Name at first.
%% Input check 
if ndims(Image)~=3
    error('input Image is not 3d volume data');
end
if or(~isvector(Reso),numel(Reso)<3)
    error('Input Resolution Type is NOT correct')
end

if Reso(1) ~=Reso(2)
    error('Input Resolution(1,Y) and Resolution(2,X) is NOT equal.')
end
%%

AllTime = tic;
%% Name
disp(mfilename('fullpath'))
disp('Cehcking Input Dirctory Name...')
DirCheck = dir(STR);
while ~isempty(DirCheck)
    disp(' Upps... It alredy has been exist..')
    prompt = 'FileName = ';
    STR = input(prompt);
    DirCheck = dir(STR);
end
  mkdir(STR)
  disp('   Change Dir...')
cd(STR)
NowDir = cd;
disp(NowDir)
pause(1)


%% Surface 
Sind = {'Surface Index is not use for Auto Vascular Mesurement program.'};
save([STR '_Original.mat'],'Image','Reso','STR','Sind')


%% Main Flow
Time_st = tic;
Enhansed = TS_EnhancedImage_vSP5(Image,Reso);
disp('Enmphasize ... Time ...')
toc(Time_st)

%% Denoising
 Medsiz = [5 5];
 h = fspecial('gaussian',7,4/(2*sqrt(2*log(2))));
 mfImage = TSmedfilt2(Image,Medsiz);
 parfor n = 1:size(Image,3)
    mfImage(:,:,n) = imfilter(mfImage(:,:,n),h,'symmetric');
 end
 im = max(mfImage,[],3);
 im = rgbproj(cat(3,im,im,im));
 imwrite(im,[STR '_MIPxy.tif'],'tif') 
 save([STR '_Enhansed.mat'],'Enhansed','Medsiz','h','mfImage','-v7.3')
 toc(Time_st)
clear Medsiz h Time_st im n

  %% Resize Image
  EImage = Enhansed.EfImage;
  clear Enhansed
 [RmfImage,NewReso] = TS_EqualReso3d_2017(mfImage,Reso,1);
 REnhansed          = TS_EqualReso3d_2017(EImage,Reso,1);
 
 save([STR '_ResizData.mat'],'RmfImage','Reso','REnhansed',...
     'NewReso','-v7.3') 
 clear mfImage Image EImage Reso Enhansed
 
 %% MIP 3D
 A = TS_Image2uint8(TS_3DMIP_view3(RmfImage,NewReso,20,30));
 B = TS_3DMIP_view3(REnhansed,NewReso,20,30);
 MP = cat(2,A,zeros(size(A,1),5),B);
 figure,imagesc(MP),axis image off
 imwrite(MP,[STR '_MIP3Dview20_30.tif'])
 imwrite(A,[STR '_MIP3Dview20_30.tif'],'writeMode','append')
 imwrite(B,[STR '_MIP3Dview20_30.tif'],'writeMode','append')
 clear A B MP
 
 %% add Penetrating Program
 tic;
 [PenetDiamImage,DiamImage,bw,skel] = TS_PenetDiamAnalysis(RmfImage,NewReso);
%  [PenetDiamImage,DiamImage,bw,skel] = TS_PenetDiamAnalysis(testImage,NewReso);
 toc
 PR = TS_Diam2ReconstBW(DiamImage,1);
 
 Penetdata.Size = size(RmfImage);
 Penetdata.Resolution = NewReso;
 Penetdata.skel_ind = find(skel(:));
 Penetdata.PenetDiameter_ellipse = PenetDiamImage(skel);
 Penetdata.Diameter = DiamImage(skel);
 Penetdata.bw = bw;
 Penetdata.Reconstruct = PR;
 
 save([STR '_PenetoData.mat'],'Penetdata','NewReso','-v7.3') 
 
Pskel = skel;
Pskel(~PR) = false;
PDiamImage = DiamImage;
% PDiamImage = zeros(Penetdata.Size,'like',single(1));
% PDiamImage(Penetdata.skel_ind) = Penetdata.Diameter;


SEG_penet = TS_PenetResult2SEG(PR,PDiamImage,NewReso,Pskel);
save([STR '_PenetoData.mat'],'SEG_penet','-append') 
clear PenetDiamImage DiamImage bw skel



 
 
 %% PreSkeleton
 tic
 bw = TS_PreSkeleton(REnhansed,NewReso);
% %  main func.
% %    bw = TS_ExtractionObj2Mask(EnhancedImage,ObjSiz,Reso,'ball');
% %    im = imfill(im,'hole');
% %    im = bwareaopen(im,HoleSiz);
toc
save([STR '_PreSkeletonBW.mat'],'bw','NewReso') 
toc
%% 
A = TS_3DMIP_view3_bw(bw,NewReso,20,30);
 imwrite(A,[STR '_MIP3D_bw.tif'])
clear A
 %% prepre skel 
    Radius = 3;
    BoldTh = Radius / NewReso(1);
    sesiz = repmat(round(BoldTh*2)+1,1,3);
    SE = false(sesiz);
    SE(round(BoldTh)+1,round(BoldTh)+1,round(BoldTh)+1) = true;
    se = bwdist(SE)<= Radius;
    tic,cbw = imclose(bw,se);toc,
    clear sesiz SE BoldTh
    save([STR '_PreSkeletonBW_Closing.mat'],'cbw','se','NewReso') 
    clear bw se
% 
A = TS_3DMIP_view3_bw(cbw,NewReso,20,30);
 imwrite(A,[STR '_MIP3D_cbw.tif'])
clear A
%%
clear im Medsiz REnhansed 

    %% Skeleton and Segment...
    tic,
%     delete(gcp)
    skel3D = Skeleton3D(cbw);
    Time = toc;
    save([STR '_SkeletonAndSEG.mat'],'cbw','Time','skel3D')
    
    % SEGment
    tic,
    skel3D(PR) = false;
%     skel3D = or(skel3D,Pskel);
    AddBranch = imdilate(PR,ones(3,3,3));
    
    
    SEG = TS_AutoSegment_loop(skel3D,NewReso,AddBranch,20)
%     [SEG,loopNum] = TS_SEGloop(skel3D,NewReso,false(size(skel3D)),20,STR);
    segTime  = toc
    save([STR '_SkeletonAndSEG.mat'],'SEG','segTime','-append')

%% Measurement of diameter
try
    skel_seg = SEG.Output; %% Correct 
catch
    skel_seg = SEG.Input; %% old function is ''Input '' Is output...
end
 clear cbw skel3D
 TIME = tic;
 output = TS_AutoAnalysisDiam_sp5(RmfImage,skel_seg,NewReso,70);
 Analysis_Diam_Time = toc(TIME) 

 save([STR '_MeasDiam.mat'],'output','skel_seg','NewReso','Analysis_Diam_Time', '-v7.3')


%% DiamImage and SNRImage
[DiamImage,SNRImage] = TS_MeasDiam2DiamImage(skel_seg,output.Pointdata);
% R = TS_Diam2ReconstBW(DiamImage,mean(NewReso));

%%
NewDiamImage = DiamImage;
NewDiamImage(SNRImage<2) = nan;

% R1 = TS_Diam2ReconstBW(NewDiamImage,mean(NewReso));

[SEG_diam,NewDiamImage] = TS_SEGandDiam(SEG,NewDiamImage);
NewDiamImage = max(cat(4,NewDiamImage,PDiamImage),[],4);

save NewSEGandDiamImage SEG_diam DiamImage SNRImage NewDiamImage PDiamImage -v7.3

 AllTime = toc(AllTime);
 save AnalysisTime AllTime

% R2 = TS_Diam2ReconstBW(NewDiamImage,mean(NewReso));


