%% Measument Vessels program
function output = TS_AtVasMeas_Flow(Image,Reso)
  folder_name = uigetdir('\\TS-QVHL1D2\usbdisk3\Sugashi\10_Since2016\20_Matlab\12_Matlab_data');
cd(folder_name)
disp(TS_ClockDisp)
AllTime = tic;
%% Input check
fgh = TS_3dmipviewer(Image,Reso);
waitfor(fgh);
disp('   Input is Correct? Yes(y) or No(n);')
yn = input('Yes or No : ');
if ~strcmpi('y',yn(1))
    disp('.... Ok, Return. Bye...')
    return
end


%% Name
disp('What''s Name Making Dirctory??')
prompt = 'FileName = ';
STR = input(prompt);
while ~ischar(STR)
    STR = input(prompt);
end
DirCheck = dir(STR);
while ~isempty(DirCheck)
    disp(' Upps... It alredy has been exist..')
    STR = input(prompt);
    DirCheck = dir(STR);
end
  mkdir(STR)
  disp('   Change Dir...')
  pause(2)  
cd(STR)
NowDir = cd;
disp(NowDir)
pause(3)


%% Surface 
disp('  Define Slice of Surface...')
fgh = TS_3dslider(Image);
waitfor(fgh)
 Sind = inputdlg; %% by hand, by eyes...., from Surface
 Sind = eval(Sind{1});
% 
%% Save Original Image and Reso or TOPHAT
fgh = figure;imagesc(max(Image(:,:,Sind:end),[],3))
title('Need TOPHAT filter at Surface ??')
ok = inputdlg('Need TOPHAT filter at Surface ??','tophat',1,{'Yes'});
close(fgh)
if ~isempty(ok)
     SV = Image(:,:,Sind:end);
     SV = TS_SurfaceTOPHAT(SV,Reso);
     Image(:,:,Sind:end) = SV;
     save([STR '_TOPHAT.mat'],'Image','ok','Reso','STR','Sind') 
else
     save([STR '_Original.mat'],'Image','Reso','STR','Sind','ok')
end

%% Main Flow
Time_st = tic;
Enhansed = TS_EnhancedImage(Image,Reso);
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
  EImage = Enhansed.EmhaGammfImage;
  clear Enhansed
 [RmfImage,NewReso] = TS_EqualReso3d_parfor(mfImage,Reso,1);
 REnhansed          = TS_EqualReso3d_parfor(EImage,Reso,1);
 
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
    BoldTh = 5 / NewReso(1);
    sesiz = repmat(round(BoldTh*2)+1,1,3);
    SE = false(sesiz);
    SE(round(BoldTh)+1,round(BoldTh)+1,round(BoldTh)+1) = true;
    se = bwdist(SE)<=5;
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
    delete(gcp)
    skel3D = Skeleton3D(cbw);
    Time = toc;
    save([STR '_SkeletonAndSEG.mat'],'cbw','Time','skel3D')
    
    % SEGment
    tic,
    SEG = TS_AutoSegment_loop(skel3D,NewReso,false(size(skel3D)),20)
%     [SEG,loopNum] = TS_SEGloop(skel3D,NewReso,false(size(skel3D)),20,STR);
    segTime  = toc
    save([STR '_SkeletonAndSEG.mat'],'SEG','segTime','-append')

%% Measurement of diameter
try
    skel_seg = SEG.Output; %% Correct 
catch
    skel_seg = SEG.Input; %% old function is ''Input '' Is output...
end
 clear SEG cbw skel3D
 TIME = tic;
 output = TS_AutoAnalysisDiam_AddAdjPreFWHM_perSlice(RmfImage,skel_seg,NewReso,70);
 Analysis_Diam_Time = toc(TIME) 

 save([STR '_MeasDiam.mat'],'output','skel_seg','NewReso','Analysis_Diam_Time', '-v7.3')
 AllTime = toc(AllTime);
 save AnalysisTime AllTime

