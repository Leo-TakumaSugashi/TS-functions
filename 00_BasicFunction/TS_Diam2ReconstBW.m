function OutData = TS_Diam2ReconstBW(Diam,Reso,varargin)
%% Help TS_VesselsRemodeling
%  �א�������(Thininng)�Ɠ_�ɂ�����a��''���a''�v������(bwdist�Ȃ�)��AND�摜����
%  �{�����[���f�[�^�̔r�o
% This funciotn is Prototype...edit 2016 July 8th by Sugashi
if numel(Reso) ~= 1
    error('Input Resolution''s Numelis NOT ''1''');
end
% 
% if ndims(Diam)~=3
%     error('Input Diameter Image(each skeleton point''s) is NOT 3 Dimmenssion')
% end

%% offset (Resolution ) um -> pix
Diam = Diam / Reso;

% % SET UP
Maximum = max(Diam(:));
size_ori = size(Diam);
Ballsiz = double(ceil(Maximum + 1));
Center = uint16(floor(Maximum/2)+1);
Ballsiz = Ballsiz + double(floor(Ballsiz/2)==ceil(Ballsiz/2));
Ballsiz = repmat(Ballsiz,[1 3]);
OutData = false(size(Diam));
Padsiz = ceil(Ballsiz/2);
OutData = padarray(OutData,Padsiz,0);
Ballsiz = uint32(Ballsiz);
% % �i���S�ɂP��u���CBwdist�ɂ�ball�̓�l�f�[�^���쐬���u��������j
BallBox = zeros(Ballsiz);

BallBox(Center,Center,Center) = 1;
BallBox = bwdist(logical(BallBox)); %% This Parameter is Radius!!

% Ballsiz
% Padsiz
%% main�@function

[y,x,z] = ind2sub(size(Diam),find(Diam(:) > 0));
ballsiz = Ballsiz(1);
padsiz = Padsiz(1);
NUMn = length(y);
% wh = waitbar(0,'Wait...');
fprintf(mfilename)
TS_WaiteProgress(0)
for n = 1:length(y)
    Th = Diam(y(n),x(n),z(n));
    Th = max((Th/2),1); %% Diameter --> Radius length
    Ball = BallBox<=Th;
    ydata =  + ( y(n):y(n)+ballsiz-1);
    xdata =  + ( x(n):x(n)+ballsiz-1);
    zdata =  + ( z(n):z(n)+ballsiz-1);    
    OutData(ydata,xdata,zdata) = ...
        or(OutData(ydata,xdata,zdata),Ball);
%     waitbar(n/NUMn,wh,['Wait...' num2str(n) '/' num2str(NUMn)])
    TS_WaiteProgress(n/NUMn)
end
OutData = OutData(padsiz:end-padsiz-1,padsiz:end-padsiz-1,padsiz:end-padsiz-1);
% close(wh)
end


