%% Measument Vessels program
function TS_AtVasMeas_Flow_2019b(Image,Reso,Type)
disp(TS_ClockDisp)
disp(mfilename('fullpath'))
fprintf('1. You need check input your data,,,,\n')
fprintf(['Image Size : ' num2str(size(Image)) '\n'])
fprintf(['Resolution : ' num2str(Reso) ' [um/voxels]\n'])
fprintf(['Image FOV  : ' num2str((size(Image)-1).* Reso) '\n'])
if max(strcmpi(Type,{'sp5','sp8','fwhm'}))
    fprintf(['Input Type is ' Type '\n'])
else
    error('Input Type is NOT supported.')
end
fprintf('... Check in Figure... \n')

%% Input check
fgh = TS_3dmipviewer(Image,Reso);
% waitfor(fgh);
disp('   Input is Correct? Yes(y) or No(n);')
yn = input('Yes or No : ','s');
if ~strcmpi('y',yn(1))
    close(fgh)
    disp('.... Ok, Return. Bye...')
    return
end
close(fgh)
%% Select Save Folder for New File Folder
fprintf('2. Please Select a directory for files to save (for creating new folder) \n')
% folder_name = uigetdir('\\TS-QVHL1D2\usbdisk3\Sugashi\10_Since2016\20_Matlab\12_Matlab_data');
folder_name = uigetdir();
if or(isempty(folder_name),folder_name ==0)
    disp('.... Ok, Return. Bye Bye...')
    return
end
fprintf([' Current Directory is. \n   ' pwd ...
    '\n Going to Save Directory... \n' folder_name '\n'])
cd(folder_name)

AllTime = tic;
%% Name
fprintf(['3. Next Step is Creating New Directory...\n' ...
    '  Input New Folder Name ?? \n' ...
    '  (*Don''''t foreget Individual Identification Number and Day(s). \n'])
prompt = 'FileName = ';
STR = input(prompt,'s');
while ~ischar(STR)
    fprintf('   Input should be string.\n')
    STR = input(prompt);
end
DirCheck = dir(STR);
while ~isempty(DirCheck)
    disp(' Upps... It alredy has been exist..')
    STR = input(prompt);
    DirCheck = dir(STR);
end
fprintf('Now Creating New Directory(Files Folder)...\n')
mkdir(STR)
disp('   Change Dir...')
drawnow
cd(STR)
NowDir = cd;
disp(NowDir)
pause(3)
%% Surface 
fprintf(['4. Before Last Step ,Auto Segment and measure Diameter...\n' ...
    '  Input Surface Index From 3D-slice slider by human check, for \n' ...
    '  tophat filtering only over Surface (denoising reflection artifact.)\n'])
disp('  Define Slice of Surface...')
fgh = TS_3dslider(Image);
Sind = input('Slice Number = '); %% by hand, by eyes...., from Surface
try
    close(fgh);
catch     
end
if isempty(Sind)
    Sind = Inf;
elseif isstr(Sind)
    Sind = eval(Sind);
end

% 
%% Save Original Image and Reso or TOPHAT
fprintf('5. Last Step ,Deside to need tophat or no \n');
try
    fgh = figure;imagesc(max(Image(:,:,Sind:end),[],3))
catch
    imagesc(false(size(Image,1),size(Image,2)))
end
title('Need TOPHAT filter at Surface ??')
ok = input('Need TOPHAT filter at Surface Yes[y],No[n]??','s');
close(fgh)
fprintf(' Saving Original Image and Reso....')
save([STR '_Original.mat'],'Image','Reso','STR','Sind','ok')
fprintf('Done \n\n  #### #### #### START PROGRAM  #### #### #### \n')
if strcmpi(ok(1),'y')
     SV = Image(:,:,Sind:end);
     SV = TS_SurfaceTOPHAT(SV,Reso);
     Image(:,:,Sind:end) = SV;
     save([STR '_TOPHAT.mat'],'Image','ok','Reso','STR','Sind') 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Main Flow %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Time_st = tic;
%% Denoising
% By experience, about 3-4 um diameter Capirally will be extracted because
% of 2 um radius circle kernel median filter.
MedSizRadius = min(ceil(2 / Reso(1)),5); %
mfImage = TS_Circmedfilt2d(Image,MedSizRadius);
clear Image
if max(strcmpi(Type,{'sp5','fwhm'}))
    Enhansed = TS_EnhancedImage_vSP5(mfImage,Reso);
elseif strcmpi(Type,'sp8') %% Guess , Dont Need Shading Processing....
    Enhansed = TS_EnhancedImage_vSP8(mfImage,Reso);
else
    error('Input Type is NOT supported.')
end
disp('Enmphasize ... Time ...')
toc(Time_st)
% 
%  h = fspecial('gaussian',7,4/(2*sqrt(2*log(2))));
%  parfor n = 1:size(mfImage,3)
%     mfImage(:,:,n) = imfilter(mfImage(:,:,n),h,'symmetric');
%  end
%% Save MIP Image,
 im = max(mfImage,[],3);
 im = rgbproj(cat(3,im,im,im));
 imwrite(im,[STR '_MIPxy.tif'],'tif') 
 save([STR '_Enhansed.mat'],'Enhansed','MedSizRadius','mfImage','Reso','-v7.3')
 toc(Time_st)
clear Medsiz h Time_st im n MedSizRadius

%% Resize Image
EImage = Enhansed.EfImage;
[RmfImage,NewReso] = TS_EqualReso3d_2017(mfImage,Reso,1);
 REnhansed          = TS_EqualReso3d_2017(EImage,Reso,1); 
 save([STR '_ResizData.mat'],'RmfImage','Reso','REnhansed',...
     'NewReso','-v7.3') 
 if strcmpi(Type,'sp8')
     Remphasized_Penet = TS_EqualReso3d_2017(Enhaseed.fImage,Reso,1);
     save([STR '_ResizData.mat'],'Remphasized_Penet','-append') 
 end
 %% MIP 3D
 A = TS_Image2uint8(TS_3DMIP_view3(RmfImage,NewReso,20,30));
 B = TS_3DMIP_view3(REnhansed,NewReso,20,30);
 MP = cat(2,A,zeros(size(A,1),5),B);
 figure,AXESH = axes;
 imagesc(MP),
 axis image off
 imwrite(MP,[STR '_MIP3Dview20_30.tif'])
 imwrite(A,[STR '_MIP3Dview20_30.tif'],'writeMode','append')
 imwrite(B,[STR '_MIP3Dview20_30.tif'],'writeMode','append')
 clear A B MP
 
 %% Pre Skeleton 1
 tic
 if strcmpi(Type,'sp5')
     bw = TS_PreSkeleton_v2017(REnhansed,NewReso);
 elseif strcmpi(Type,'sp8')
     bw = TS_PreSkeleton_v2019_sp8(REnhansed,Remphasized_Penet,NewReso);
 else
     bw = TS_PreSkeleton_v2017(REnhansed,NewReso);
 end

clear Image EImage Enhansed 
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
%% Pre Skeleton 2 (Closing 3 um radius sph.)
Radius = 3;
BoldTh = Radius / NewReso(1);
sesiz = repmat(round(BoldTh*2)+1,1,3);
SE = false(sesiz);
SE(round(BoldTh)+1,round(BoldTh)+1,round(BoldTh)+1) = true;
se = bwdist(SE)<= Radius;
tic,
try %% try GPGPU
    gbw = gpuArray(bw);
    gcbw = imclose(gbw,se);
    cbw = gather(gcbw);
catch err
    warning(err.message)
    cbw = imclose(bw,se);
end
try
    reset(gpuDevice)
catch err
    warning(err.message)
end
cbw = imfill(cbw,'holes');
toc,
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
try
    skel3D = bwskel(cbw);
catch err
    warning(err.message)
    skel3D = Skeleton3D(cbw);
end
%%%%% Add 2019.06.12 %%%%%%
skel3D = TS_bwmorph3d(skel3D,'thin');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Time = toc;
save([STR '_SkeletonAndSEG.mat'],'cbw','Time','skel3D')

% SEGment
tic,
fprintf('Now Segmentation, and Shaving.....')
SEG = TS_AutoSegment_loop(skel3D,NewReso,false(size(skel3D)),20);
%     [SEG,loopNum] = TS_SEGloop(skel3D,NewReso,false(size(skel3D)),20,STR);
fprintf('Done\n')
segTime  = toc    
save([STR '_SkeletonAndSEG.mat'],'SEG','segTime','-append')

%% Measurement of diameter
TIME = tic;
output = TS_AutoAnalysisDiam_SEG_v2019a(mfImage,Reso,Type,SEG);
Analysis_Diam_Time = toc(TIME) 
save([STR '_MeasDiam.mat'],'output','Analysis_Diam_Time', '-v7.3')

%% D0ne
AllTime = toc(AllTime);
save AnalysisTime AllTime
text(0,AXESH.YLim(2)/2,'FINISH!!!','FontSize',70)

