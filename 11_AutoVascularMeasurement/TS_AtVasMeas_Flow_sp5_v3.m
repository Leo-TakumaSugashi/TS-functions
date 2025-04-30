%% Measument Vessels program
% function output = TS_AtVasMeas_Flow_sp5_v3(Image,Reso)

% v3... 穿通ではなく、太い血管に変更
%     　太い血管の径は先に計算するが、毛細血管とのつながりはどうする？
%  　　１、表面と穿通と毛細（まずはこの3つに分解）
%    　２．オープニングを変えて、太い血管のみを残す。
%     ３。　アスペクト比とArea対長軸短軸による理論値の倍率から、楕円近似するものと、
%     　　普通の径計測するもので分ける。
%      ４．現状のものでまずはセグメント（⇒短いものは消す）
%      　現状のものから、表面と、穿通、それ以外に分ける。
%       ５．毛細血管とつなぎ合わせた、セグメントの書き換え
%       ６、毛細血管の径計測
%       ７最終的なoutputの整理


  folder_name = uigetdir('\\TS-QVHL1D2\usbdisk3\Sugashi\10_Since2016\20_Matlab\12_Matlab_data');
cd(folder_name)
disp(TS_ClockDisp)
AllTime = tic;
%% Input check
msgbox('   Input is Correct? Yes(y) or No(n);')
try
    fgh = TS_3dmipviewer(Image,Reso);
catch err
    disp(err)
    fgh = TS_3dmipviewer_old2016(Image,Reso);
end
waitfor(fgh);

yn = questdlg('Correct data ?',...
    'Quesstion' ,...
    'Yes', 'No','Yes');
if or(strcmpi('no',yn),isempty(yn))
    msgbox('.... Ok, Return. Bye By...')
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
  pause(.5)  
cd(STR)
NowDir = cd;
disp(NowDir)
pause(.5)


%% Surface 
TF = true;
while TF
fgh = msgbox('  Define Slice of Surface...');
waitfor(fgh);
fgh = TS_3dslider(Image);
waitfor(fgh);
Sind = inputdlg('Input Surface Index'); %% by hand, by eyes...., from Surface
if isempty(Sind)
    Sind = {'Inf'};
end
 Sind = eval(Sind{1});
fgh = questdlg(['Input Surface Index is ' num2str(Sind)],...
    'Surface Index' ,...
    'OK', ' Re input','OK');
if or(isempty(fgh),~strcmpi('OK',fgh))
    TF = true;
else
    TF = false;
end
end
 
% 
%% Save Original Image and Reso or TOPHAT
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
 figure('Name',STR),imagesc(MP),axis image off
 imwrite(MP,[STR '_MIP3Dview20_30.tif'])
 imwrite(A,[STR '_MIP3Dview20_30.tif'],'writeMode','append')
 imwrite(B,[STR '_MIP3Dview20_30.tif'],'writeMode','append')
 clear A B MP
 
 %% add Penetrating Program
 tic;
 [SEG_bold,BoldDiamImage,PenetDiamImage,cbw,PSNRImage,SNRImage] = ...
     TS_PenetDiamAnalysis_vsp5(RmfImage,REnhansed,NewReso);
%  [PenetDiamImage,DiamImage,bw,skel] = TS_PenetDiamAnalysis(RmfImage,NewReso);
%  [PenetDiamImage,DiamImage,bw,skel] = TS_PenetDiamAnalysis(testImage,NewReso);
 toc
 
 PR = 
 error('this is end')
 
 
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


