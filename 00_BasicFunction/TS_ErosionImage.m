
function [output,Label] = TS_ErosionImage(bwcenter,bw,varargin)
%% Original Function is TS_SegmentWithVideo.m
%  [output,Label] = TS_ErosionImage(bwcenter,bw)

if ~and(islogical(bwcenter),islogical(bw))
    error('input is NOT LOGICAL data')
end
if ~max(size(bwcenter)==size(bw))
    error('input size is not Equal')
end

if nargin <3
    MaxDist = inf;
else
    MaxDist = varargin{1};
end


whole_bw = or(bwcenter,bw);
output = NaN(size(bw));
output(bwcenter) = 0;
[Label,Num] = bwlabeln(bwcenter);
if Num < 2^8
    Label = uint8(Label);
elseif Num < 2^16
    Label = uint16(Label);
elseif Num <2^32
    Label = uint32(Label);
end

TF = true;
Numel = sum(whole_bw(:));
fprintf(mfilename)
TS_WaiteProgress(0)
Num = Numel - sum(bwcenter(:));
NumPre = Num;
se = false(5,5,5);
se(3,3,3) = 1;
se = bwdist(se)<=2;
while TF
    newPoint = and(imdilate(bwcenter,se),whole_bw);
    check_New = newPoint;
    check_New(bwcenter) = 0;
    if max(check_New(:))
        [Dis,Ind] = bwdist(bwcenter);
        newPoint(bwcenter) = false;
        Ind = Ind(newPoint);
        output(newPoint) = Dis(newPoint) + output(Ind);
        Label(newPoint) = Label(Ind);
        bwcenter = or(bwcenter,newPoint);
    else
        TF = false;
    end
    Num = Numel - sum(bwcenter(:));
    if or(Num == NumPre,MaxDist<max(output(newPoint)))
        TF = false;
    else
        NumPre = Num;
    end
    TS_WaiteProgress(Num/Numel)
end
if Num/Numel < 1
    TS_WaiteProgress(1)
end

