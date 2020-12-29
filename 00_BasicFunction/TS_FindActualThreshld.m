function [outputTh,outputfwhm] = TS_FindActualThreshld(L,BeadSiz,Center,Reso)


Threshold = 0:0.001:1;
FWHM = zeros(length(Threshold),1);
parfor n = 1:length(Threshold)
 fwhm = TS_FWHM2016(L,Threshold(n),'Center',Center);
 FWHM(n) = abs(diff(fwhm)) * Reso;
end

[~,Id] = min(abs(FWHM - BeadSiz));
outputTh = Threshold(Id);

outputfwhm.Threshold = Threshold;
outputfwhm.FWHM = FWHM;