function OutData = TS_Diam2Reconst(Diam,Reso)
%% Help TS_TS_Diam2Reconst
%  OutData = TS_Diam2Reconst(Diam,Reso)
%   Diam : 点における径の''径''計測結果
%   Reso : scholar , Need Resolution (XYZ) is Equal 
% This funciotn is Prototype...edit 2016 July 8th by Sugashi
if numel(Reso) ~= 1
    error('Input Resolution''s Numelis NOT ''1''');
end

if ndims(Diam)>3
    error('Input Diameter Image(each skeleton point''s) is NOT 3 Dimmenssion')
end
%% offset (Resolution ) um -> pix
Diam = Diam / Reso;


% % SET UP
Maximum = max(Diam(:));
size_ori = size(Diam);
Ballsiz = double(ceil(Maximum + 1));
Center = uint16(floor(Maximum/2)+1);
Ballsiz = Ballsiz + double(floor(Ballsiz/2)==ceil(Ballsiz/2));
Ballsiz = repmat(Ballsiz,[1 3]);
OutData = zeros(size(Diam),'like',single(1));
Padsiz = ceil(Ballsiz/2);
OutData = padarray(OutData,Padsiz,0);
Ballsiz = uint32(Ballsiz);
% % （中心に１を置き，Bwdistにてballの二値データを作成→置き換える）
BallBox = zeros(Ballsiz);

BallBox(Center,Center,Center) = 1;
BallBox = bwdist(logical(BallBox)); %% This Parameter is Radius!!

% Ballsiz
% Padsiz
%% main　function

[y,x,z] = ind2sub(size(Diam),find(Diam(:) > 0));
ballsiz = Ballsiz(1);
padsiz = Padsiz(1);
wh = waitbar(0,'Reconstructing...');
for n = 1:length(y)
    pDiam = Diam(y(n),x(n),z(n));
    Th = (pDiam/2); %% Diameter --> Radius length
    if or(Th==0,isnan(Th))
        continue
    end
    Ball = single(BallBox<=Th) * pDiam;
    ydata =  + ( y(n):y(n)+ballsiz-1);
    xdata =  + ( x(n):x(n)+ballsiz-1);
    zdata =  + ( z(n):z(n)+ballsiz-1);    
    OutData(ydata,xdata,zdata) = ...
        max(cat(4,OutData(ydata,xdata,zdata),Ball),[],4);
    waitbar(n/length(y),wh,['Reconstructing...' num2str(n) '/' num2str(length(y))])
end
close(wh)
OutData = OutData(padsiz:end-padsiz-1,padsiz:end-padsiz-1,padsiz:end-padsiz-1);
end


