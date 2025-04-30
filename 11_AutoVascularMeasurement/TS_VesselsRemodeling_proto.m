function OutData = TS_VesselsRemodeling_proto(Thin_Dist_Image,Reso,varargin)
%% Help TS_VesselsRemodeling
%  細線化結果(Thininng)と点における径の''半径''計測結果(bwdistなど)のAND画像から
%  ボリュームデータの排出
% This funciotn is Prototype...edit 2016 July 8th by Sugashi
if numel(Reso) ~= 1
    error('Input Resolution''s Numelis NOT ''1''');
end

% % SET UP
Maximum = max(Thin_Dist_Image(:));
size_TDI = [size(Thin_Dist_Image,1) size(Thin_Dist_Image,2) size(Thin_Dist_Image,3)];
siz = double(ceil(2*Maximum + 1));
OutData = zeros(size(Thin_Dist_Image));
OutData = padarray(OutData,[siz,siz,ceil(siz/2)],0);
siz = uint32(siz);
% % （中心に１を置き，Bwdistにてballの二値データを作成→置き換える）
BallBox = zeros(siz,siz,siz);
Center = uint16(round(Maximum));
BallBox(Center,Center,Center) = 1;
BallBox = bwdist(logical(BallBox));

%% main　function
[y,x,z] = ind2sub(size(Thin_Dist_Image),find(Thin_Dist_Image(:) > 0));
for n = 1:length(y)
    Th = Thin_Dist_Image(y(n),x(n),z(n));
%     Ball = BallBox.*(~(BallBox>Th)); % BallBox take a value 0 to Maximum in the range Th.
    Ball = double(BallBox<=Th)*(Th*2-1)*Reso;    
%     Ball = double(BallBox<=Th)*(Th*4-1)*Reso;
    OutData(y(n):y(n)+siz-1,x(n):x(n)+siz-1,z(n):z(n)+siz-1) = ...
        max(cat(4,OutData(y(n):y(n)+siz-1,x(n):x(n)+siz-1,z(n):z(n)+siz-1),Ball),[],4);
    
    
%     Ball = Ball(:,:,Center);
%     OutData(y(n):y(n)+siz-1,x(n):x(n)+siz-1,z(n))= Ball;
    
%     disp(num2str(n))
end
% siz = double(siz);
% OutData = flip(OutData,3);
disp(['OutData = OutData(1:' num2str(size_TDI(1)) ',1:'...
    num2str(size_TDI(2)) ',1:' num2str(siz) ');'])

%% Volumedata
if nargin>2
bw = OutData > 0;
fv = isosurface(uint8(bw),0.5,OutData);
fgh = figure('Color','k',...
    'InvertHardcopy','off',...
    'ResizeFcn',@ResizeFcn,...
    'Position',[42 386 1107 591]);
I = imread('CheckerbordImage.tif');
I = double(I);
I(I==0) = 0.5;
axes('Posi',[0 0 1 1],'visible','off')
 imagesc(cat(3,I,I,I));
 axes('Posi',[.1 .1 .8 .8])
p = patch(fv);
% Ydirection --> Reverse
% set(get(p,'Parent'),'Ydir','reverse')
set(p,'EdgeColor','none','FaceColor','Interp')
set(gca,'Ydir','reverse')
view(3)
daspect([1 1 1])
axis off

end
end

function ResizeFcn(fgh,dummy)
    Posi = get(fgh,'Position');
    set(fgh,'PaperPosition',[.6 .6 20.5 20*Posi(4)/Posi(3)])
    set(fgh,'PaperPositionMode','auto')
end

