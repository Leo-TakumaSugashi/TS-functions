function SEG = TS_AutoSEG_mex(skel,NewReso,varargin)

%% input check 
tt = tic;
cutlen = 20;
if nargin >2
    AddBP = varargin{1};
    if isempty(AddBP)
        AddBP = false(size(skel));
    end
    if max((size(skel) ~= size(AddBP)))
        error('input Add Branch Point is not epsize')
    end
    if ~islogical(AddBP)
        error('Input Add Branch Point must BE logical');
    end
else
    AddBP = false(size(skel));
end
if nargin > 3
    cutlen = varargin{2};
    if ~isscalar(cutlen)
        error('input cutlength is not scalar')
    end
end
if ~islogical(skel)
    error('skel is not logical')
end

if ismatrix(skel)
    bw = padarray(skel,[0 0 1],false,'post');
    AddBP = false(size(bw));
    TF2D = true;
else
    bw = skel;
    TF2D = false;
end

%% main mex %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
try
    if ispc
        SEG = TS_AutoSegment_v2019Charly(bw,NewReso,AddBP,cutlen);
    else
        if ismac
            SEG = AutoSegment_OSX_mex(bw,NewReso,AddBP,cutlen);
        else
            SEG = AutoSegment_mex(bw,NewReso,AddBP,cutlen);%%
        end
    end
catch err
    warning(err.message)
    warning('Please report to Sugashi.')
    SEG = TS_AutoSegment_v2019Charly(bw,NewReso,AddBP,cutlen);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% delete too long
% DeletePdataInd = false(length(SEG.Pointdata),1);
DeletePdataInd = [];
for n = 1:length(SEG.Pointdata)
    if isnan(SEG.Pointdata(n).PointXYZ(1,1))
        DeletePdataInd = n;
        break
    end
end
if ~isempty(DeletePdataInd)
    SEG.Pointdata(DeletePdataInd:end) = [];
end
for n= 1:length(SEG.Pointdata)
    SEG.Pointdata(n).PointXYZ = nanCut(SEG.Pointdata(n).PointXYZ);
    SEG.Pointdata(n).Branch = nanCut(SEG.Pointdata(n).Branch);
    Type =SEG.Pointdata(n).Type;
    switch Type
        case 5
            SEG.Pointdata(n).Type = 'End to End';
        case 1
            SEG.Pointdata(n).Type = 'End to Branch';
        case 0
            SEG.Pointdata(n).Type = 'Branch to Branch';
        otherwise
            SEG.Pointdata(n).Type = 'Point';
    end     
end
if TF2D
    SEG.Output(:,:,2) = [];
    SEG.AddBP(:,:,2) = [];
    SEG.Branch(:,:,2) = [];
    SEG.BranchGroup(:,:,2) = [];
    SEG.End(:,:,2) = [];
    SEG.Original(:,:,2) = [];
end
fprintf(['\n    ==== ==== ==== ==== ==== ==== ==== ====  \n' ...
    '            Segment Time : ' ...
    num2str(toc(tt),'%.0f')...
    ' sec.\n    ==== ==== ==== ==== ==== ==== ==== ====  \n'])
end


function newxyz = nanCut(xyz)
    ind = ~isnan(xyz(:,1));
    newxyz= xyz(ind,:);
end