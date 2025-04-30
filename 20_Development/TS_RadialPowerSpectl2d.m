function [PowerFreq,HistDist,DistImage] = TS_RadialPowerSpectl2d(im,varargin)
% [PowerFreq,HistDist,DistImage] = TS_RadialPowerSpectl2d(im)
% ... = TS_RadialPowerSpectl2d(im,OverLim)
% Input : 
%     im mustBe matrix, or vector...
%     OverLim mean ...  DistImage > OverLim --> round (Default is 0)
% Output :
%     PowerFreq is Powere Spectram summated from DistImage(1x N size vector)
%     HistDist is PowerFreq's Dist(=Frequency)
%     DistImage is Based on Caluicualte PowerFreq.
% 
% Edit, 30th,June,2019, by Sugashi

narginchk(1,2)
if nargin >1
    OverLim = varargin{1}; 
else
    OverLim = 0;     
end

siz = size(im);
OddTF = IsOdd(siz);
if OddTF(1) == 0
    im = padarray(im,[1 0],0,'post');
end

if OddTF(2) == 0
    im = padarray(im,[0 1],0,'post');
end

m = 2^nextpow2(size(im,1));
n = 2^nextpow2(size(im,2));
X = fft2(im,m,n);

Power1 = abs( fftshift(X) );
Power2 = Power1(1:m/2+1,n/2+1:end);

bw = false(size(Power2));
bw(end,1) = true;
DistImage = bwdist(bw);
DistImage(DistImage>OverLim) = round(DistImage(DistImage>OverLim));
HistDist = TS_GetSameValueSort(DistImage);
PowerFreq = zeros(1,length(HistDist));
for n = 1:length(HistDist)
    Ind = DistImage == HistDist(n);
    PowerFreq(n) = sum(Power2(Ind));
end
