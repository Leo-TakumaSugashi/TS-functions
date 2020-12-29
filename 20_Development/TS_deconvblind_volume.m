function [J,NewReso,P] = TS_deconvblind_volume(Image,Reso)
tic
NewReso = [.5 .5 .5];
[RImage,NewReso] = TS_EqualReso3d_2017(single(Image),Reso,NewReso);
p1 = 1;
p2 = 1;
p3 = 1;
Fun = @(PSF) padarray(PSF(p1+1:end-p1,p2+1:end-p2,p3+1:end-p3),[p1 p2 p3]);

OverPSF = ones(11,11,21);
iterN = 30;

[J,P] = deconvblind(RImage,OverPSF,iterN,[],[],Fun);
toc