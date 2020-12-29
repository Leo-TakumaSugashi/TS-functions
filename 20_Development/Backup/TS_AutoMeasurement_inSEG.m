function outputSEG = TS_AutoMeasurement_inSEG(Image,SEG,Len)
% セグメントデータから線に対する法線の角度を計算（+/-RefPoint),
% 簡易的に閾値０．５として、
% 径計測を試みた、プロトタイプのプログラム。。。
RefPoint = 5;

Reso = SEG.ResolutionXYZ;
xdata = 1:size(Image,2);
ydata = 1:size(Image,1);
zdata = 1:size(Image,3);

DiamImage = zeros(size(Image),'like',single(1));
SNRImage = DiamImage;


for n = 1:length(SEG.Pointdata)
    xyz = SEG.Pointdata(n).PointXYZ;
    nL = TS_xyz2Norm(xyz,RefPoint);
    Matrix = [];
    Diam = nan(size(xyz,1),1);
    for k = 1:length(nL)
        im = Image(:,:,xyz(k,3));
        xind = and(xdata >= xyz(k,1)-1,xdata <= xyz(k,1)+1);
        yind = and(ydata >= xyz(k,2)-1,ydata <= xyz(k,2)+1);
        zind = and(zdata >= xyz(k,3)-1,zdata <= xyz(k,3)+1);
        S = Image(yind,xind,zind);
        S = mean(S(:));
        N = double(mode(im(:)));
        vp = TS_GetLineProfileTheta(im,xyz(k,1:2),nL(k),Len,Reso);
        vp = (double(vp) - N) ./ (S - N);
        fwhm = TS_FWHM2016(vp(:),0.5,'Center',ceil(length(vp)/2));
        Diam(k) = diff(fwhm) * Reso(1);
        DiamImage(xyz(k,2),xyz(k,1),xyz(k,3)) = Diam(k);
        SNRImage(xyz(k,2),xyz(k,1),xyz(k,3)) = S / N ;
        Matrix(:,k) = vp(:);
    end
    SEG.Pointdata(n).Matrix = Matrix;
    SEG.Pointdata(n).Diemater = Diam;
    disp( [num2str(n) '/' num2str(length(SEG.Pointdata))])    
end
outputSEG = SEG;
outputSEG.DiamImage = DiamImage;
outputSEG.SNRImage = SNRImage;