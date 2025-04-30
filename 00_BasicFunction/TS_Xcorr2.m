function A = TS_Xcorr2(TempNUM,varargin)
% Fot takada data.
%


data(1:nargin-1) = struct('Infomation',[],'Max',[]);
tic
for n = 1:nargin-1
    ROI = varargin{n};
    [Infom , CCM] = TSXCORR2(TempNUM,ROI);
    data(n).Infomation = Infom;
    data(n).Max = CCM;
    clear Infom CCM
end
Infom = cat(5,data.Infomation);
MaximumCC = cat(2,data.Max);
AnsInfomation = zeros(1,2,1,size(ROI,4));
Ans2 = AnsInfomation;
for n = 1:size(ROI,4)
    [~,b] = max(squeeze(MaximumCC(n,:)));
    AnsInfomation(:,:,:,n) = Infom(:,:,:,n,b);
    Ans2(:,:,:,n) = mode(double(Infom(:,:,:,n,:)),5);
end
A.data = data;
A.RePositInf = AnsInfomation;
A.Ans2 = Ans2;
toc


function [RePositInf1 , CCmaximum1] = TSXCORR2(TempNUM,ROI1)
RePositInf1 = zeros(1,2,1,size(ROI1,4));
CCmaximum1 = nan(size(ROI1,4),1);
Temp = ROI1(:,:,:,TempNUM);
for n = 1:size(ROI1,4)
    CC = normxcorr2(double(Temp),double(ROI1(:,:,1,n)));
    len = double(floor(size(CC)/2));
    [y,x] = find(CC==max(CC(:)));
    if ~isempty(y)
        CCmaximum1(n) = max(CC(:));
        RePositInf1(1,1,1,n) = double(y(1))-len(1)-1;
        RePositInf1(1,2,1,n) = double(x(1))-len(2)-1;
    end
end