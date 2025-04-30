function [imgList,Info,Detaile] = TSloadOifv0(FullPath)
% FullPath = UIgetfile('*.oif');
% [imgList,Info,Detaile] = TSloadOifv0(FullPath)
% 
% Output : Example
% imgList = 
%               Name: '"loc01_137um_post2.oif"'
%                FOV: [187.8910 187.8910 0]
%               Unit: '"um","um","um","ms"'
%         Resolution: [0.5890 0.5890 1 574.6160]
%               Size: [320 320 1 50 2]
%              Image: [5-D uint16]
%          TimeIndex: [50×1 double]
%      TimeIndexUnit: '"ms"'
%         DepthIndex: [50×1 double]
%     DepthIndexUnit: '"um"'
%      ChannelsColor: []
%     ExperimentDate: ''2018-04-04 19:29:29''
%    
% Info 
%   ViewOifProfile(Info)
%   
% Detaile....
%     they are each image infomation...
    
disp(FullPath)
   

Info = TSreadOlympusImageFormat(FullPath);
cc = GetProfileSaveInfo(Info);
[ReadList,ReadType] = GetPtyFiles(FullPath,cc);
[ReadList,AxisOrder] = AddDimminfo(ReadList,Info);
[imgList,Detaile] = ReconstImage(ReadList);
% Name
val = GetProperty(Info,'[File Info]');
imgList.Name = GetProperty(val,'DataName');
% Reso
val = GetProperty(Detaile,'[Image Parameters]');
Resox = eval(GetProperty(val,'WidthConvertValue'));
ResoxUni = GetProperty(val,'WidthUnit');
Resoy = eval(GetProperty(val,'HeightConvertValue'));
ResoyUni = GetProperty(val,'HeightUnit');
siz = imgList.Size;
if siz(3)==1
    Resoz = 1;
else
    Resoz = (max(imgList.DepthIndex) - min(imgList.DepthIndex))/(siz(3)-1);
end
if siz(4)==1
    Resot = 1;
else
    Resot = (max(imgList.TimeIndex) - min(imgList.TimeIndex))/(siz(4)-1);
end
Reso = [Resoy Resox Resoz Resot];
ResoUni = [ResoyUni ',' ResoxUni ',' imgList.DepthIndexUnit ',' imgList.TimeIndexUnit];
imgList.Resolution = Reso;
imgList.Unit = ResoUni;
% FOV
FOV = (siz(1:3)-1).* Reso(1:3);
imgList.FOV = FOV;
% Ex date
val = GetProperty(Info,'[Acquisition Parameters Common]');
imgList.ExperimentDate = GetProperty(val,'ImageCaputreDate');
% % uint8 or ?
if max(imgList.Image,[],'all') <=255
    imgList.Image = uint8(imgList.Image);
end

end

function [imgList,Detaile] = ReconstImage(ReadList)
n = 1;
Parent = ReadList{n,1};
p = find(Parent==filesep);
Parent = Parent(1:p(end));
List(1:size(ReadList,1)) = struct('im',[],'size',[],'info',[],'Z',[],'T',[]);
for n = 1:size(ReadList,1)
    info = TSreadOlympusImageFormat(ReadList{n,1});
    val = GetProperty(info,'[File Info]');
    val = GetProperty(val,'DataName');val(val=='"') = [];
    List(n).im= imread(fullfile(Parent,val)); 
    List(n).size = size(List(n).im);
    List(n).info = info(:,2);
    if n ==1
        LabelInfo = info(:,1);
        [Depth,Duni,Time,Tuni] = GetDepthTime(info);
        siz = max(cat(1,ReadList{:,2}),[],1);
        siz(isnan(siz)) = size(List(1).im,[1 2]);
        Image = zeros(siz,'like',List(1).im);
    else
        [Depth,~,Time,~] = GetDepthTime(info);
    end
    evalString = SliceInfo(ReadList{n,2});
    eval(evalString);
    List(n).Z = Depth;
    List(n).T = Time;
    List(n).C = ReadList{n,2}(5);
end
try
    Detaile = cat(2,LabelInfo,List.info);
catch err
    Detaile = info;
end
Z = cat(1,List.Z);
T = cat(1,List.T);
C = cat(1,List.C);
Z = Z(C==1);
T = T(C==1);


    function evalstring = SliceInfo(ind)
        STR = 'Image(';
        for ns = 1:length(ind)
            if isnan(ind(ns))
                STR = [STR ':,'];
            else
                STR = [STR,num2str(ind(ns)),','];
            end
        end
        evalstring = [STR(1:end-1), ') = List(n).im;'];
    end

    function [Depth,Duni,Time,Tuni] = GetDepthTime(info)
        valid = GetProperty(info,'[Axis 3 Parameters]');
        Uni = GetProperty(valid,'AbsPositionUnitName');
        valid=GetProperty(valid,'AbsPositionValue');
        valid = eval(valid);
        if strcmp(Uni,'"nm"')
            valid = valid/1000;
            Uni = '"um"';
        end
        Depth = valid;Duni = Uni;
        
        valid = GetProperty(info,'[Axis 4 Parameters]');
        Uni = GetProperty(valid,'AbsPositionUnitName');
        valid=GetProperty(valid,'AbsPositionValue');
        valid = eval(valid);
        Time = valid;Tuni = Uni;
    end

%% reshape
imgList = struct(...
 'Name',[],...           : char Format is (filename / Element Name)
  'FOV',[],...                : numeric 
  'Unit',[],...               : char (Unit of FOV)
  'Resolution',[],...         : [um./pix].. == FOV ./ (Size -1)
  'Size',size(Image,[1:5]),...               : numeric (size of Image = pixels/voxels size)
  'Image',Image,...              : [Y, X(scan dir.), Z(optical dir.), T(time), "ch"(channels data)]
  'TimeIndex',T,...
  'TimeIndexUnit',Tuni,...
  'DepthIndex',Z,...
  'DepthIndexUnit',Duni,...
  'ChannelsColor',[],...      : char (Channels Color)
  'ExperimentDate',[]) ;  %: can't read correct yet. Current version has UniequID
end

% {'[Axis Parameter Common]'}
function [ReadList,AxisOrder] = AddDimminfo(ReadList,Info)

val = GetProperty(Info,'[Axis Parameter Common]');
val = GetProperty(val,'AxisOrder');val(val=='"')=[];
AxisOrder = val;
ind = nan(size(val));
checkind = false(size(val));
for n = 1:length(val)
    ind(n) = DimType2ind(val(n));
end
checkind(ind) = true;
for n = 1:size(ReadList,1)
    ReadList{n,2}(~checkind) = 1;
end

end
function [cc,ind] = GetProfileSaveInfo(Info)
    for ind = 1:size(Info,1)
        if contains(Info{ind,1},'ProfileSaveInfo')
            cc = Info{ind,2};
            return
        end
    end
%     prefix  ... T1
%     Attribution  ... T2
end

function [ReadList,ReadType,Parent] = GetPtyFiles(FullPath,cc)
p = find(FullPath == filesep);
Parent = FullPath(1:p(end));
%     {'"\s_C002T050.pty"'  }
%     {'"\s_C001T001.pty"'  }
%     {'"\s_%s.pty"'        }
%     {'"\s_C%03dT%03d.pty"'}
% % Read Pty File Name properties
val = GetProperty(cc,'PtyFileNameS');val(val=='"') = [];
    p = find(val=='\');%% Olympas Image file create on Windows.
Foldername = val(1:p(end)-1);
ptyFileStart =val(p(end)+1:end);
    [L,N] = bwlabel(~isnan(Isnumfromstring(ptyFileStart)));
    StartNum = zeros(1,N);
    for n = 1:N; StartNum(n) = str2double(ptyFileStart(L==n));end
    
val = GetProperty(cc,'PtyFileNameE');val(val=='"') = [];
    p = find(val=='\');
ptyFileEnd =val(p(end)+1:end);
    [L,N] = bwlabel(~isnan(Isnumfromstring(ptyFileEnd)));
    EndNum = zeros(1,N);
    for n = 1:N; EndNum(n) = str2double(ptyFileEnd(L==n));end
val = GetProperty(cc,'PtyFileNameT1');val(val=='"') = [];
    p = find(val=='\');
ptyFileTable1 =val(p(end)+1:end);
val = GetProperty(cc,'PtyFileNameT2');val(val=='"') = [];
    p = find(val=='\');
ptyFileTable2 =val(p(end)+1:end);

Parent = fullfile(Parent,Foldername);
p = find( ptyFileTable1 =='%');
fileprefix = ptyFileTable1(1:p(1)-1);
expoint = find(ptyFileTable2=='.');
checktype= ptyFileTable2(length(fileprefix)+1:expoint-1);
[numLabel,Numel] = bwlabel(~isnan(Isnumfromstring(checktype)));
p = find(numLabel==0);
ReadType(1:Numel) = struct('Type',[],'numNumel',[],'Limit',[]);

c = 1;
for n = 1:length(p)
    if strcmp(checktype(p(n)),'%') || strcmp(checktype(p(n)),'d')
        continue
    else
        ReadType(c).Type = checktype(p(n));
        ReadType(c).numNumel = str2double(checktype(numLabel==c));
        ReadType(c).Numbers = StartNum(c):EndNum(c);
        c = c+ 1;
    end
end
%% make read list
Count = ones(1,5);
for n = 1:length(ReadType)
    Count(n) = length(ReadType(n).Numbers);
end
ReadList = cell(prod(Count),2);
for n = 1:prod(Count)
    [ind1,ind2,ind3,ind4,ind5] = ind2sub(Count,n);
    STR = [];
    DimInd = nan(1,5);
    for k = 1:length(ReadType)
        DimType = ReadType(k).Type;
        NUM = ReadType(k).Numbers(eval(['ind' num2str(k)]));
        Num = TS_num2strNUMEL(NUM,ReadType(k).numNumel);
        STR = cat(2,STR,DimType,Num);
        DimInd(DimType2ind(DimType)) = NUM;
    end
    ReadList{n,1} = fullfile(Parent,[ fileprefix, STR, '.pty']);
    ReadList{n,2} = DimInd;
end



end

function ind = DimType2ind(type)
switch type
    case 'X'
        ind = 2;
    case 'Y'
        ind = 1;
    case 'Z'
        ind = 3;
    case 'T'
        ind = 4;
    case 'C'
        ind = 5;
    otherwise
        ind = nan;
end
end

function ISLabel = Isnumfromstring(STR)
ISLabel = nan(size(STR));
for n = 1:length(STR)
    ISLabel(n) = str2double(STR(n));
end
ISLabel(imag(ISLabel)==1) = nan;
ISLabel = real(ISLabel);
end

function val = GetProperty(cc,Name)
val = [];
for n = 1:size(cc,1)
    if strcmp(cc{n,1},Name)
        val = cc{n,2};
        return
    end
end
end

