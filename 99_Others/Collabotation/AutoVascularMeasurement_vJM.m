function AutoVascularMeasurement_vJM(Image,Reso,Type,folder_name,STR)
%% Measument Vessels program
% TS_AtVasMeas_Flow_2019c(Image,Reso,Type,folder_name,STR)
% Edit log, 
% 2019,06,30, Create New Version 2019c, 
%    GPGPU will be trying Before Measurement Diameter
%    by Sugashi
% Add Folder name, and SaveName,
%
% change to ,,,, 2019.08.13. Sugashi
% output = TS_AutoAnalysisDiam_SEG_v2019delta(mfImage,Reso,Type,SEG);

%%
disp(TS_ClockDisp)
disp(mfilename('fullpath'))
fprintf('    ....Check input your data,,,,\n')
fprintf(['    Image Size   : ' num2str(size(Image)) '\n'])
fprintf(['    Resolution   : ' num2str(Reso) ' [um/voxels]\n'])
fprintf(['    Image FOV    : ' num2str((size(Image)-1).* Reso) '\n'])
fprintf(['    Measure Type : ' Type '\n'])
CurrentFolder = pwd;
fprintf(['    Save Dir.    : ' folder_name '\n' ])
fprintf(['    Save Name.   : ' STR '\n' ])
fprintf([' Current Directory is. \n   ' CurrentFolder ...
    '\n Going to Save Directory... \n' folder_name '\n'])
cd(folder_name)
%% check input
if max(strcmpi(Type,{'sp5','sp8','fwhm'}))
    fprintf(['Input Type is ' Type '\n'])
else
    error('Input Type is NOT supported.')
end

if ~ischar(STR)
    error('   Input Name should be string.\n')    
end
DirCheck = dir(STR);
while ~isempty(DirCheck)
    error(' Upps... It alredy has been exist..')
end

fprintf('Now Creating New Directory(Files Folder)...\n')
mkdir(STR)
disp('   Change Dir...')
drawnow
cd(STR)
%% Timer Start.
AllTime = tic;
fprintf('Checking has Done... \n\n  #### #### #### START PROGRAM  #### #### #### \n')
fprintf(' Saving Original Image and Reso....')
save([STR '_Original.mat'],'Image','Reso','STR','Type')
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
% Emphasized = TS_2PM_VascularFilter_v2019a(mfImage,Reso);
% disp('Enmphasize ... Time ...')
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
%  save([STR '_Emphasized.mat'],'Emphasized','MedSizRadius','mfImage','Reso','-v7.3')
save([STR '_Denoised.mat'],'MedSizRadius','mfImage','Reso','-v7.3')
 toc(Time_st)
clear Medsiz h Time_st im n MedSizRadius
%  EImage = Emphasized.EfImage;
%  EImage_Penet = Emphasized.fImage;
% save([STR '_Data.mat'],'Reso','EImage','EImage_Penet','Reso','-v7.3') 

 %% MIP 
 if ismatrix(mfImage)
     A = TS_Image2uint8(mfImage);
 else
     A = TS_Image2uint8(TS_3DMIP_view3(mfImage,Reso,20,30));
 end
%  B = TS_3DMIP_view3(TS_Image2uint8(EImage),Reso,20,30);
%  MP = cat(2,A,zeros(size(A,1),5),B);
 figure,AXESH = axes;
%  imagesc(MP),
 imagesc(A),
 axis image off
%  imwrite(MP,[STR '_MIP3Dview20_30.tif'])
%  imwrite(A,[STR '_MIP3Dview20_30.tif'],'writeMode','append')
imwrite(A,[STR '_MIP3Dview20_30.tif'])
%  imwrite(B,[STR '_MIP3Dview20_30.tif'],'writeMode','append')
 clear A B MP
 
 %% Pre Skeleton 1
tic %% TS_PreSkeleton_v2019_sp8 is also sp5 
HoleSiz_Radi = 10; %% um
HoleSiz =round( (HoleSiz_Radi/Reso(1))*(HoleSiz_Radi/Reso(2))*pi );
VascularSiz = 50; %% um
if ismatrix(mfImage)
    blocksz = round([VascularSiz/Reso(1) VascularSiz/Reso(2)]);
else
    blocksz = round([VascularSiz/Reso(1) VascularSiz/Reso(2) VascularSiz/Reso(3)]);
    HoleSiz =round( (HoleSiz_Radi/Reso(1)) * ...
                (HoleSiz_Radi/Reso(2)) * ...
                (HoleSiz_Radi/Reso(3)) * 4/3 *pi );
end
bw = TS_im2bw_block_v2019a(mfImage,blocksz);
bw = bwareaopen(bw,HoleSiz,26);
bw = imfill(bw,'holes');
% bw = TS_PreSkeleton_v2019_sp8(EImage,EImage_Penet,Reso); 
clear Image EImage Emphasized 
toc
save([STR '_PreSkeletonBW.mat'],'bw','Reso') 
toc
%% 
if ismatrix(bw)
    A = bw;
else
    A = TS_3DMIP_view3_bw(bw,Reso,20,30);
end
imwrite(A,[STR '_MIP3D_bw.tif'])
clear A
%% Pre Skeleton 2 (Closing 3 um radius sph.)
Radius = 3;
BoldTh = Radius / Reso(1);
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
save([STR '_PreSkeletonBW_Closing.mat'],'cbw','se','Reso') 
clear bw se
% 
A = TS_3DMIP_view3_bw(cbw,Reso,20,30);
 imwrite(A,[STR '_MIP3D_cbw.tif'])
clear A
%%
clear im Medsiz EImage 
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
skel3D = TS_bwmorph3d_v2019a(skel3D,'thin');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Time = toc;
save([STR '_SkeletonAndSEG.mat'],'cbw','Time','skel3D')

% SEGment
tic,
fprintf('Now Segmentation, and Shaving.....')
% SEG = TS_AutoSegment_loop(skel3D,Reso,false(size(skel3D)),20);
SEG = TS_AutoSegment_v2019Charly(skel3D,Reso,false(size(skel3D)),20);
%     [SEG,loopNum] = TS_SEGloop(skel3D,Reso,false(size(skel3D)),20,STR);
fprintf('Done\n')
segTime  = toc    
save([STR '_SkeletonAndSEG.mat'],'SEG','segTime','-append')

%% Measurement of diameter
TIME = tic;
output = TS_AutoAnalysisDiam_SEG_v2019delta(mfImage,Reso,Type,SEG);
Analysis_Diam_Time = toc(TIME) 
save([STR '_MeasDiam.mat'],'output','Analysis_Diam_Time', '-v7.3')

%% D0ne
AllTime = toc(AllTime);
save AnalysisTime AllTime
text(0,AXESH.YLim(2)/2,'FINISH!!!','FontSize',70)
cd(folder_name)

