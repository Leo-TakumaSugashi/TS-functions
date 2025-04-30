function [A, B] = TS_PaddingImage1and2(Image1,Image2)
% 3次元データのつなぎ合わせをするために、
% 二つのイメージサイズを合わせるpaddingのプログラム

siz1 = size(Image1);
siz2 = size(Image2);

PadSiz = siz1 - siz2;

%% Z
if PadSiz(3)~=0
if PadSiz(3) > 0
    Image2 = padarray(Image2,[0 0 PadSiz(3)],0,'Pre');
elseif PadSiz(3) < 0
    Image1 = padarray(Image1,[0 0 abs(PadSiz(3))],0,'Pre');
end
end
%% X
if PadSiz(2) ~= 0
if PadSiz(2) > 0
    Image2 = padarray(Image2,[0 PadSiz(2)],0,'Post');
elseif PadSiz(2) < 0
    Image1 = padarray(Image1,[0 abs(PadSiz(2))],0,'Post');
end
end
%% Y
if PadSiz(1) ~= 0
if PadSiz(1) > 0
    Image2 = padarray(Image2,[PadSiz(1) 0],0,'Post');
elseif PadSiz(1) < 0
    Image1 = padarray(Image1,[abs(PadSiz(1)) 0],0,'Post');
end
end
A = Image1;
B = Image2;