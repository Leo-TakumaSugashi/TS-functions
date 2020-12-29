function output = TS_EachDepthDiam(skel,DiamImage,Sind,zReso)

zbin = 50;
BIN = [0 3 6 10 inf]; %% unit, Length um
%% 
skel = flip(skel,3);
DiamImage = flip(DiamImage,3);
% % add nan
DiamImage(~skel) = nan;

zdata = (0:size(DiamImage,3)-1) - Sind;


zstep = 0:zbin:zdata(end);
if zstep(end) ~= zdata(end)
    zstep = [zstep zdata(end)];
end

Numel = zeros(1,length(zstep));
Hist = struct('Num',Numel,'Average',[],'SD',[]);
for n = 1:length(zstep)
    if n == 1
        z = zdata<=0;
    else
        z = and(zdata>zstep(n-1),zdata<=zstep(n));
    end
    imskel = skel(:,:,z);
    im = DiamImage(:,:,z);
    diam_im = im(imskel);
    Numel(n) = sum(imskel(:));
    for k = 1:length(BIN)-1
        bw = and(diam_im>=BIN(k),diam_im<BIN(k+1));
        Hist(k).Num(n) = sum(bw);
         bw = and(bw,~isnan(diam_im));
        Hist(k).Average(n) = mean(diam_im(bw));
        Hist(k).SD(n)  = std(diam_im(bw));        
    end
    
end
Label = cell(1,length(zstep));
Label{1} = 'Surface (0 \mum)';
for n = 2:length(zstep)
    Label{n} = [num2str(zstep(n)) ' \mum'];
end
XLS = num2cell(cat(1,Numel,cat(1,Hist.Num),cat(1,Hist.Average),cat(1,Hist.SD)));
STR = cell(length(Hist),1);
for n = 1:length(BIN)-1
    STR{n} = num2str([BIN(n) BIN(n+1)]);
end


STR = cat(1,{'Numel'},STR,STR,STR);

XLS = cat(2,STR,XLS);
addLabel = cat(2,{[]},Label);
XLS = cat(1,addLabel,XLS);

output.Numel = Numel;
output.Label = Label;
output.zStep = zstep;
output.Depth_ind = zdata*zReso;
output.DiamHist = Hist;
output.XLS = XLS;






