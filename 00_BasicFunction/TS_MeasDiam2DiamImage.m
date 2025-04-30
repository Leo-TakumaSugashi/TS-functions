function [DiamImage,SNRImage] = TS_MeasDiam2DiamImage(skel,Pdata)
% [DiamImage,SNRImage] = TS_MeasDiam2DiamImage(skel,Pdata)

DiamImage = zeros(size(skel),'like',single(1));
SNRImage = DiamImage;
for n = 1:length(Pdata)
xyz = round(Pdata(n).XYZ);
D = Pdata(n).Diameter;
S = Pdata(n).Signal;
N = Pdata(n).Noise;
SNR = 10 * log10(S/N);
for k = 1:size(xyz,1)
    DiamImage(xyz(k,2),xyz(k,1),xyz(k,3))  = D(k);
    SNRImage(xyz(k,2),xyz(k,1),xyz(k,3))  = SNR(k);
end
clear D S N SNR xyz
end