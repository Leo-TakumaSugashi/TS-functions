---
### **A set of MATLAB functions aimed at automatically evaluating vascular structures imaged by 2-photon laser scanning fluorescence microscopy(2PLSM).**
---

## Description
One of the micro-imaging characteristics of the *In vivo* captured by the 2PLSM is that the resolution in the planar and optical axis directions are different. In addition, there are effects of light scattering by cells and tissues. **AND SIMPLY TOO MANY BLOOD VESSELS!**

## Purpose
**Automated quantitative evaluation of three-dimensional (also two-dimensional) vascular networks.**
*Actual images require visual confirmation at intermediate steps, taking into account SN, influence of other tissues, etc.*
*I will also provide a Viewer/Editor application for this purpose.*

## Required environment (programming language version, libraries, etc.)
Software: \n
    MATLAB (>R2022a)\n
    ├── Image Processing Toolbox   
│   └── Parallel Computing Toolbox      
               
Hardware: 
  Minimum specification 
    CPU: Greater than 4Core. 
    Memory : Greater than 32GB.

  Recommended 
    CPU   : 8Core/Threds, 3GHz or higher.
    Memory:  64GB or more.

  *Depends on the total number of pixels in the volume image.*
  *1024*1024*20 with 16GB of memory works on a Linux environment, but not on Windows 11.*
　
## Installation procedure
Add all Directories, including subfolders, to the path.

## Basic usage and execution
## Step 0 : Image and Resolution 

### If no sample is available.
Sf = Segment_Functions;
[SEG,mImage,Reso] = Sf.make_sample


### If you have images you would like to analyze.
*Please prepare the image and resolution information.*
Image : [n x m x k] matrix.
Reso  : Resolution. vector. [Y,X,Z]; if input 2D image, Z should be ***1***.

## Step 1 : pre-processing 
 mImage = TSmedfilt2(Image,[3 3]);
 *If there is any other recommended denoising process, please apply it.*

## Step 2 : check Image
DimFive(mImage,Reso)
[DimFive sample1](https://sugashi-phd.com/images/DimFive_sample.png)



SEG = TS_AutoAnalysisDiam_SEG_v2024Alpha(Image,Reso,"FWHM",SEG,'MaximumStep',128);

  SEG = TS_AutoAnalysisDiam_SEG(fImage,Reso,ThresholdType,SEG,{Options...})
   Option are like below,,
  SEG = TS_AutoAnalysisDiam_SEG(...,'ID','all',...
                               'SNRLim',3,'SNRUnit','a.u.',...
                               'LineLength',40,...
                               'NoiseType','Slice',...
                               'MeasureType','All',...
                               'Progressbar','off',...
                               'ForceParfor','on');
  
  fImage        : just medianfiltered raw-Image
  Reso          : Resolution(X,Y,Z) as Input of "fImage", % um/pix.
  ThresholdType : {sp5, sp8, photo count, pmt, ..}*
  SEG           : output of TS_AutoSegment_loop and
                   **Segment_Function.set_Segment(SEG,'f')
  
  Options.... default
              ID = '>0'; %% must Be ">0",'all',or numeric
              Progressbar ='on'; %% on or off
              SNRLim = 2; %%
              SNRUnit = 'dB'; %% dB or a.u., will be calicualte
              LineLength = 70; % Numeric,[um],
              NoiseType = 'Eachpoint'; 
                     EachPoint, Slice(if siz(3)==1), Numeric(==Constant)
              MeasureType = 'LineRot'; 
                            {'LineRot','NormLine','Elliptic','Hybrid','Speed','All'}
                             Hybrid =='LineRot&Elliptic', Speed =='NormLine&Elliptic'
              ForceParfor = 'on'; %% on or off
              MaximumStep = 512; % Numeric,
   
  Compensation by SNR (this value is for PMT or Photon Count ver. Image)
  th = TS_GetThreshold_sp5_v2019(S,N);
  th = TS_GetThreshold_sp8(S);
 
  ROI as rotate line profile is defined below length as default.
  Len = 70 ; % um , is xy-plane.
   
   see alo so , Sugashi_AutoAnalysisDiam, TS_AutoSEG_mex, Segment_Functions
  TS_AutoAnalysisDiam_AddAdjPreFWHM_perSlice  Group...










TS_3dmipviewer(Image,Reso);
R = Sugashi_ReconstructGroup;

[Fv,p] =R.SEGdiam2TubePatch(SEG);
figure,p = patch(Fv);
view(3)
daspect(ones(1,3))
p.EdgeColor = 'none';
p.FaceColor = 'interp';
camh = camlight(gca);
box on
axis tight



SegEditor_v2025(Image,Reso,SEG)



##Project structure

##License information

##How to contribute (how to report an Issue, how to create a Pull Request, etc.)

##Contact Information
