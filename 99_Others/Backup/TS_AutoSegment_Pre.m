function Output = TS_AutoSegment_Pre(bwthindata,varargin)
% Output = TS_AutoSegment1(skeleton_logicaldata,Resolution)
% 0. Pre Processing
% 1. End point to Branch or End Point
% 2. Branch to Branch Point
%  * Resolution need X:Y:Z = [1:1:1]!!!
% % 
narginchk(1,3)
Reso = ones(1,3);
AddBP = [];
% CutLen = 20;
if nargin > 1
    Reso = varargin{1};
end
if nargin > 2
    AddBP = varargin{2};
    if ~isempty(AddBP)
        AddBP = and(bwthindata,AddBP);
    end
end
% if nargin == 4
%     CutLen = varargin{3};
% end

tic
OriginalBW = bwthindata;
% Resi = sum(bwthindata(:));

% % PointXYZ is matrix, Type is 'End to Branch' or 'Branch to Branch'
Pdata(1:10000) = struct('PointXYZ',[],'Type',[],'Length',[],'Branch',[]); %  point--->[Y X Z]

%% Analysis Branch-point and End-point 
% disp('Analysis Branch-point and End-point ')
 [BPcentroid,~,BPgroup,EndP] = TS_bwmorph3d(bwthindata,'branchpoint','none');
BPcentroid(AddBP) = true;
EndP(AddBP) = false;
 %% % term add . 2016.10.17
 BPgroup = or(BPcentroid,BPgroup);


%% main process
% disp('Analysis Branch-point and End-point ')
[bpy,bpx,bpz] = ind2sub(size(BPcentroid),find(BPcentroid(:)));
 % BP point infomation,[X Y Z Number Count]
 BPmatrix = cat(2,bpx,bpy,bpz,find(BPcentroid(:)),zeros(size(bpx))); 
 clear bpy bpx bpz

Output.Input = OriginalBW;
Output.AddBP = AddBP;
Output.Branch = BPcentroid;
Output.BranchGroup = BPgroup;
Output.End = EndP;
Output.Pointdata = Pdata;
Output.ResolutionXYZ = Reso;

bwthindata = padarray(bwthindata,[1 1 1],0); %% For Crop;Nearest 26 point
%  pointview(bwthindata,Reso,'figure')
BPcentroid = padarray(BPcentroid,[1 1 1],0);
BPgroup = padarray(BPgroup,[1 1 1],0);
[~,DistInd] = bwdist(BPcentroid);
L_BPgroup = uint32(bwlabeln(BPcentroid,26));
L_BPgroup(BPgroup) = L_BPgroup(DistInd(BPgroup));
clear DistInd
bwthindata(BPcentroid) = false; %% bwthindata --->í‚Á‚Äs‚«A‚È‚­‚È‚Á‚½‚çI—¹
bwthindata(BPgroup) = false;

EndP = padarray(EndP,[1 1 1],0);
%% End point to a Branchpoint or a Endpoint
% disp('   ... 1st End point to a Branchpoint or a Endpoint')
Output = TS_AtSEG1(Output,bwthindata,BPcentroid,BPgroup,L_BPgroup,EndP,BPmatrix);
end

