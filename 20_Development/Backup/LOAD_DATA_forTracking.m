STR = {...
    'Series030-1.mat',...
    'Series034-2.mat',...
    'Series036-3.mat',...
    'Series038-4.mat'};
% Dir =  '/mnt/NAS/SSD/MatLab/TS/000_Data/K27';
Dir =  '/mnt/RAIDs0/Data/K27';
for n  = 1:4
    load([Dir '/' STR{n}])
    Name = STR{n};
    eval(['Loc' num2str(n) '=TS_setupImage(Name,Image,Reso)'])
    clear Name Image Reso
end

clear Dir STR n Name 

%%
TS_Tracking_proto(Loc1,Loc2)

%% 
TS_DepthAdjGUI(Loc1.Image,Loc2.Image)

%%
Pd = '/mnt/RAIDs0/MatFunction/Development20190128/';
load([Pd 'TESTIMAGE.mat'])
load([Pd 'TESTSEG.mat'],'SEG')
TS_SegmentEditor('testprogram',Image,Reso,SEG)