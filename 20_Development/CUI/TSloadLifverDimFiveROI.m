function imgList=TSloadLifverDimFiveROI(filename)

% elements = TSloadLif('filename') returns images in a Leica Image File
% Format (.lif). 'elements' is a struct array which includes image information.
% The list of images is displayed in standard output.
%
%  --- elements struct ---
% Name       (string)       Name of Elements
% Channels   (struct array) Channel Information
% Dimensions (struct array) Dimension Information
% Memory     (struct)       Memory Information
%
% See details in the m-file.
%
%  --- Access to image ---
% elements(n).Channels(m).Image
% This returns n-dimensional Image of numeric array.

% History
% 21-Apr-2010: return limited information concerning with images
% 13-May-2010: previewer added

% (c) Hiroshi Kawaguchi, Ph.D, 
% Molecular Imaging Center 
% National Institute of Radiological Sciences, Japan
%
% Edit, Sugashi Takuma.


fp=fopen(filename,'r');

[fp, xmlHdrStr] = ReadXMLPart(fp);

% xmlList is cell array (n x 5)
% rank(double) name(string) attributes(cell(n,2)) parant(double) children(double array)
xmlList=XMLtxt2cell(xmlHdrStr);

lifVersion = GetLifVersion(xmlList(1,:)); % lifVersion is double scalar
imgList = GetImageDescriptionList(xmlList);% imgList is struct vector

% memoryList is cell array (n x 4)
% ID(string), type(string(Unused)), data(uint8 array), Index(double)
memoryList  = ReadObjectMemoryBlocks(fp,lifVersion,imgList);

fclose(fp);

% change memory 2 friendly image
imgList=ReconstructionImages(imgList,memoryList);

function imgList=ReconstructionImages(imgList,memoryList)
% <ChannelDescription>
%%% DataType   [0, 1]               [Integer, Float]
%%% ChannelTag [0, 1, 2, 3]         [GrayValue, Red, Green, Blue]
% Resolution [Unsigned integer]   Bits per pixel if DataType is Float value can be 32 or 64 (float or double)
% NameOfMeasuredQuantity [String] Name
% Min        [Double] Physical Value of the lowest gray value (0). If DataType is Float the Minimal possible value (or 0).
% Max        [Double] Physical Value of the highest gray value (e.g. 255) If DataType is Float the Maximal possible value (or 0).
% Unit       [String] Physical Unit
% LUTName    [String] Name of the Look Up Table (Gray value to RGB value)
% IsLUTInverted [0, 1] Normal LUT Inverted Order
%%% BytesInc   [Unsigned long (64 Bit)] Distance from the first channel in Bytes
% BitInc     [Unsigned Integer]       Bit Distance for some RGB Formats (not used in LAS AF 1..0 ? 1.7)
%
% <DimensionDescription>
% DimID   [0, 1, 2, 3, 4, 5, 6, 7, 8] [Not valid, X, Y, Z, T, Lambda, Rotation, XT Slices, T Slices]
%%% NumberOfElements [Unsigned Integer] Number of elements in this dimension
% Origin           [Unsigned integer] Physical position of the first element (Left pixel side)
% Length   [String] Physical Length from the first left pixel side to the last left pixel side (Not the right. A Pixel has no width!)
% Unit     [String] Physical Unit
%%% BytesInc [Unsigned long (64 Bit)] Distance from one Element to the next in this dimension
% BitInc   [Unsigned Integer] Bit Distance for some RGB Formats (not used, i.e.: = 0 in LAS AF 1..0 ? 1.7)

for n=1:numel(imgList)
    % Get Dimension info
    dimension=ones(1,9);
    for m=1:numel(imgList(n).Dimensions)
        dimension(str2double(imgList(n).Dimensions(m).DimID))=str2double(imgList(n).Dimensions(m).NumberOfElements);
    end

    % Separate to each channel image
    nCh=numel(imgList(n).Channels);
    if nCh > 1;
        mem=memoryList{n,3};
        % mem=mem(1:prod(dimension)*nCh);
        % % Above is unnecessary but dimension does not match with memory size in some file
        mem=reshape(mem,...
            str2double(imgList(n).Channels(2).BytesInc)-str2double(imgList(n).Channels(1).BytesInc),[]);
        for m=1:nCh
            tmp=mem(:,m:nCh:end);
            imgList(n).Channels(m).Image=reshape(typecast(tmp(:),GetType(imgList(n).Channels(m))),dimension);
%             if (length(size(imgList(n).Channels(m).Image))==3)
%                 imgList(n).Channels(m).Image = permute(imgList(n).Channels(m).Image,[2 1 3]);
%             elseif (length(size(imgList(n).Channels(m).Image))==2)
%             if (length(size(imgList(n).Channels(m).Image))==2)
%                 imgList(n).Channels(m).Image = imgList(n).Channels(m).Image';
%             end           
        end
    else
%       ######�g���ύX
        vecdata = typecast(memoryList{n,3},GetType(imgList(n).Channels));
        if length(vecdata)~=prod(dimension)
            if length(vecdata)>prod(dimension)
                vecdata = vecdata(1:end-(length(vecdata)-prod(dimension)));
            else
                vecdata = [vecdata;zeros(prod(dimension)-length(vecdata),1)];
            end
        end
%       #############
        imgList(n).Channels.Image=reshape(vecdata,dimension);
%         if (length(size(imgList(n).Channels(1).Image))==3)
%             imgList(n).Channels(1).Image = permute(imgList(n).Channels.Image,[2 1 3]);
%         elseif (length(size(imgList(n).Channels(1).Image))==2)
%             imgList(n).Channels(1).Image = imgList(n).Channels(1).Image';
%         end           
    end
    
%     for m = 1:nCh
%         if ndims(imgList(n).Channels(m).Image)==3
%             imgList(n).Channels(m).Image = permute(imgList(n).Channels(m).Image,[2 1 3 4 5]);
%         end
%     end
    
    
end



return;

function chType=GetType(Channels)
switch str2double(Channels.DataType)
    case 0 % int case 
        switch str2double(Channels.Resolution);
            % currently, resolution is constant through the channels
            case 8;   chType='uint8';
            case 12;  chType='uint16';
            case 32;  chType='uint32';
            case 64;  chType='uint64';
            otherwise;error('Unsupporeted data bit. ')
        end
    case 1 % float case
        switch str2double(Channels.Resolution);
            % currently, resolution is constant through the channels
            case 32;  chType='single';
            case 64;  chType='double';
            otherwise;error('Unsupporeted data bit. ')
        end
end
% ================================================== 
% ================================================== 
function mems = GetImageDescriptionList(xmlList)
%  For the image data type the description of the memory layout is defined
%  in the image description XML node (<ImageDescription>).

% <ImageDescription>
imgIndex  =SearchTag(xmlList,'ImageDescription');
numImgs=numel(imgIndex);

% <Memory Size="21495808" MemoryBlockID="MemBlock_233"/>
memIndex  =SearchTag(xmlList,'Memory');
memSizes  =cellfun(@str2double,GetAttributeVal(xmlList,memIndex,'Size'));
memIndex=memIndex(memSizes~=0);
memSizes=memSizes(memSizes~=0);
if numImgs~=numel(memIndex);
    error('Number of ImageDescription and Memory did not match.')
end

% Matching ImageDescription with Memory
imgParentElmIndex =  zeros(numImgs,1);
for n=1:numImgs
    imgParentElmIndex(n) = SearchTagParent(xmlList,imgIndex(n),'Element');
end
memParentElmIndex =  zeros(numImgs,1);
for n=1:numImgs
    memParentElmIndex(n) = SearchTagParent(xmlList,memIndex(n),'Element');
end
[imgParentElmIndex, sortIndex]=sort(imgParentElmIndex); imgIndex=imgIndex(sortIndex); 
[memParentElmIndex, sortIndex]=sort(memParentElmIndex); memIndex=memIndex(sortIndex);memSizes=memSizes(sortIndex);
if ~all(imgParentElmIndex==memParentElmIndex)
    error('Matching ImageDescriptions with Memorys')
end

for n=1:numImgs
    mems(n).Name = char(GetAttributeVal(xmlList, imgParentElmIndex(n),'Name'));  %#ok<AGROW>
    [mems(n).Channels mems(n).Dimensions]= MakeImageStruct(xmlList,imgIndex(n)); %#ok<AGROW>
    mems(n).Memory.Size=memSizes(n);%#ok<AGROW>
    mems(n).Memory.MemoryBlockID=char(GetAttributeVal(xmlList,memIndex(n),'MemoryBlockID'));%#ok<AGROW>
end


return

% ================================================== 
% ================================================== 
function [C D]=MakeImageStruct(xmlList,iid)
% ChannelDescription   DataType="0" ChannelTag="0" Resolution="8" 
%                      NameOfMeasuredQuantity="" Min="0.000000e+000" Max="2.550000e+002"
%                      Unit="" LUTName="Red" IsLUTInverted="0" BytesInc="0"
%                      BitInc="0"
% DimensionDescription DimID="1" NumberOfElements="512" Origin="4.336809e-020" 
%                      Length="4.558820e-004" Unit="m" BitInc="0"
%                      BytesInc="1"
% Memory �@�@�@�@�@�@�@  Size="21495808" MemoryBlockID="MemBlock_233"
iidChildren=xmlList{iid,5};
for n=1:numel(iidChildren)
    if strcmp(xmlList{iidChildren(n),2},'Channels')
        id=xmlList{iidChildren(n),5};
        p=xmlList(id,3);
        nid=numel(id);
        tmp=cell(11,nid);
        for m=1:nid
            tmp(:,m)=p{m}(:,2);
        end
        C=cell2struct(tmp,p{1}(:,1),1);
    elseif strcmp(xmlList{iidChildren(n),2},'Dimensions')
        id=xmlList{iidChildren(n),5};
        p=xmlList(id,3);
        nid=numel(id);
        tmp=cell(7,nid);
        for m=1:nid
            tmp(:,m)=p{m}(:,2);
        end
        D=cell2struct(tmp,p{1}(:,1),1);
    else
        error('Undefined Tag')
    end
end


% ================================================== 
% ================================================== 
function lifVersion = GetLifVersion(xmlList)
% return version of header
index  =SearchTag(xmlList,'LMSDataContainerHeader');
value  =GetAttributeVal(xmlList,index,'Version');
lifVersion = str2double(cell2mat(value(1)));
return



% ==================================================
% ================================================== 
function pindex=SearchTagParent(xmlList,index,tagName)
% return the row index of given tag name
pindex=xmlList{index,4};

while pindex~=0
    if strcmp(xmlList{pindex,2},tagName)
        return;
    else
        pindex=xmlList{pindex,4};
    end
end
error('Cannot Find the Parent Tag "%s"',tagName);
return;

% ================================================== 
% ================================================== 
function index=SearchTag(xmlList,tagName)
% return the row index of given tag name
listLen=size(xmlList,1);
index=[];
for n=1:listLen
    if strcmp(char(xmlList(n,2)),tagName)
        index=[index; n]; %#ok<AGROW>
    end
end

% ================================================== 
% ================================================== 
function value=GetAttributeVal(xmlList, index, attributeName)
% return cell array of attributes row index of given tag name
value={};
for n=1:length(index)
    currentCell=xmlList{index(n),3};
    for m=1:size(currentCell,1)
        if strcmp(char(currentCell(m,1)),attributeName)
            value=[value; currentCell(m,2)]; %#ok<AGROW>
        end
    end
end


% ================================================== 
% ================================================== 
function CheckTestValue(value,errorMsg)
switch class(value)
    case 'uint8';  trueVal=hex2dec('2A');
    case 'uint32'; trueVal=hex2dec('70');
    otherwise; 
        error('Unsupported Error Number: %d',value)
end
if value~=trueVal
    error(errorMsg); 
end
return;

% ================================================== 
% ================================================== 
function [fp, str, ketPos] = ReadXMLPart(fp)                    
                                               % Size(bytes) Total(bytes) description
CheckTestValue(fread(fp,1,'*uint32'),...        % 4  4 Test Value 0x70   
    'Invalid test value at Part: XML.');
xmlChunk = fread(fp, 1, 'uint32');              % 4  8 Binary Chunk length NC*2 + 1 + 4
CheckTestValue(fread(fp,1,'*uint8'),...         % 1  9 Test Value 0x2A
    'Invalid test value at XML Content.');
nc = fread(fp,1,'uint32');                      % 4 13 Number of UTF-16 Characters (NC)
if (nc*2 + 1 + 4)~=xmlChunk;  % 
    error('Chunk size mismatch at Part: XML.');
end
str= fread(fp,nc*2,'char');                     % 2*nc - XML Object Description

% UTF-16 -> UTF-8 (cut zeros)
str     = char(str(1:2:end)');
% Insert linefeed(char(10)) for facilitate visualization -----
% str=strrep(str,'><',['>' char(10) '<']);
ketPos =strfind(str,'>'); % find position of ">" for fast search of element
return;

% ================================================== 
% ================================================== 
function memoryList=ReadObjectMemoryBlocks(fp,lifVersion,imgLists)
% get end of file and return current point
cofp=    ftell(fp);
fseek(fp,0,'eof');
eofp=    ftell(fp);
fseek(fp,cofp,'bof');

nImgLists=length(imgLists);
memoryList=cell(nImgLists,4);
% ID(string), type(string(Unused)), data(uint8 array), Index(double)
for n = 1:nImgLists
    memoryList{n,1}=imgLists(n).Memory.MemoryBlockID;
    
%     switch str2double(imgLists(n).Channels(1).Resolution);
%         % currently, resolution is constant through the channels
%         case 8;   memoryList{n,2}='uint8';
%         case 12;  memoryList{n,2}='uint16';
%         case 32;  memoryList{n,2}='single';
%         case 64;  memoryList{n,2}='double';
%         otherwise;error('Unsupporeted data bit') 
%     end
end

% read object memory blocks
while ftell(fp) < eofp;
    
    CheckTestValue(fread(fp,1,'*uint32'),...        % Test Value 0x70
        'Invalied test value at Object Memory Block');
    
    objMemBlkChunk = fread(fp, 1, '*uint32');%#ok<NASGU> % Size of Description
    
    CheckTestValue(fread(fp,1,'*uint8'),...         % Test Value 0x2A
        'Invalied test value at Object Memory Block');
    
    
    switch uint8(lifVersion)            % Size of Memory (version dependent)
        case 1; sizeOfMemory = fread(fp, 1, '*uint32');
        case 2; sizeOfMemory = fread(fp, 1, '*uint64');
        otherwise; error('Unsupported LIF version. Update this program');
    end
    
    CheckTestValue(fread(fp,1,'*uint8'),...         % Test Value 0x2A
        'Invalied test value at Object Memory Block');
    
    nc = fread(fp,1,'*uint32');                     % Number of MemoryID string
    
    str = fread(fp,double(nc*2),'*char')';                  % Number of MemoryID string (UTF-16)
    str = char(str(1:2:end));                      % convert UTF-16 to UTF-8
    
    for n=1:nImgLists
        if strcmp(char(memoryList{n,1}),str)
            memoryList{n,4}=n;
            break;
        end
    end
    
    if sizeOfMemory > 0
        memoryList{n,3}=fread(fp, double(sizeOfMemory), '*uint8');
        %         mem = fread(fp, sizeOfMemory, '*uint8');
        %         memoryList{index,3}=typecast(mem,memoryList{memoryList{index,4},2});
    end
end


return;

% ================================================== 
% ================================================== 
function tagList=XMLtxt2cell(c)
% rank(double) name(string) attributes(cell(n,2)) parant(double) children(double array)

tags  =regexp(c,'<("[^"]*"|''[^'']*''|[^''>])*>','match')';
nTags=numel(tags);
tagList=cell(nTags,5);
tagRank=0;
tagCount=0;
for n=1:nTags
    currentTag=tags{n}(2:end-1);
    if currentTag(1)=='/'
        tagRank=tagRank-1;
        continue;
    end
    tagRank=tagRank+1;
    tagCount=tagCount+1;
    [tagName, attributes]=ParseTagSting(currentTag);
    tagList{tagCount,1}=tagRank;
    tagList{tagCount,2}=tagName;
    tagList{tagCount,3}=attributes;
    % search parant
    if tagRank~=1
        if tagRank~=tagList{tagCount-1,1};
            tagRankList=cell2mat(tagList(1:tagCount,1));
            parent=find(tagRankList==tagRank-1,1,'last');
            tagList{tagCount,4}=parent;
        else
            tagList{tagCount,4}=tagList{tagCount-1,4};
        end
    else
        tagList{tagCount,4} = 0;
    end
    if currentTag(end)=='/'
        tagRank=tagRank-1;
    end
end

tagList   =tagList(1:tagCount,:);
parentList=cell2mat(tagList(:,4));
% Make Children List
for n=1:tagCount
    tagList{n,5}=find(parentList==n);
end

return;

% ================================================== 
% ================================================== 
function [name, attributes]=ParseTagSting(tag)
[name tmpAttributes]=regexp(tag,'^\w+','match', 'split');
name=char(name);
attributesCell=regexp(char(tmpAttributes(end)),'\w+=".*?"','match');
if isempty(attributesCell)
    attributes={};
else
    nAttributes = numel(attributesCell);
    attributes=cell(nAttributes,2);
    for n=1:nAttributes
        currAttrib=char(attributesCell(n));
        dqpos=strfind(currAttrib,'"');
        attributes{n,1}=currAttrib(1:dqpos(1)-2);
        if dqpos(2)-dqpos(1)==1 % case attribute=""
            attributes{n,2}='';
        else
            attributes{n,2}=currAttrib(dqpos(1)+1:dqpos(2)-1);
        end
    end
end


