
function [outB,vp,Shift_z,FlexRatio] = TS_AdjFlexibility(A,B,Reso)
%% Flip
if Reso(1) ~= Reso(2)
    error('input Resolution is NOT Equal X and Y')
end
A = flip(A,3);
B = flip(B,3);

imA = squeeze(max(A(:,:,:,1,1),[],1)); %% add Fov check
imB = squeeze(max(B(:,:,:,1,1),[],1));
for n = 1:size(imB,2)
    v = imB(:,n);
    if max(v)==0
        continue
    else
        ZeroNst = n - 1;
        break
    end
end
if ZeroNst>0
    imB(:,1:ZeroNst) = [];
    B(:,:,1:ZeroNst,:,:) = [];
end

for n = size(imB,2):-1:1
    v = imB(:,n);
    if max(v)==0
        continue
    else
        ZeroNen = n + 1;
        break
    end
end
if ZeroNen<size(imB,2)
    imB(:,ZeroNen:end) = []; %% add Fov check
    B(:,:,ZeroNen:end,:,:) = [];
end

%% Add FOV check
xy_cutsiz = 200; %% unit. um
xy_cutHalfSiz = round(xy_cutsiz/Reso(1)/2);
xcenter = round(size(A,2)/2);
ycenter = round(size(A,1)/2);

xdata = 1:size(A,2);
ydata = 1:size(A,1);
xdata = and(xdata >=xcenter - xy_cutHalfSiz , xdata <=xcenter + xy_cutHalfSiz);
ydata = ydata > 0;
% ydata = and(ydata >=ycenter - xy_cutHalfSiz , ydata <=ycenter + xy_cutHalfSiz);

imA = squeeze(max(TS_AdjImage(A(ydata,xdata,:,1,1)),[],1));
imB = squeeze(max(TS_AdjImage(B(ydata,xdata,:,1,1)),[],1));


%% shift type
comppix = 100; %% unit. um
CompNum = round(comppix/Reso(3)); %% Even Number
CompNum = CompNum + ne(floor(CompNum/2),ceil(CompNum/2));
zp = nan(1,size(imA,2)-CompNum);
parfor ck = 1:size(imB,2)-CompNum
C = imB(:,ck:ck+CompNum);
Ref = imA(:,ck:ck+CompNum);
shift_siz = TS_SliceReposition(Ref,C);
zp(ck) = ck +  shift_siz(2) -1;
end
clear k C DepthR Ref ind ck r

ZP = zp;
for n = 2:length(zp)
    ZP(n) = max(ZP(n-1:n));
end
[~,Indmax] = max(ZP);
if length(ZP)>Indmax
ZP(Indmax+1:end) = [];
end
clear Indmax


Shift_z = zp(1);
%% interpolation point-->vp
zp_vec = ZP - min(ZP) + 1;
L = zeros(1,max(zp_vec));
L(zp_vec) = 1:length(zp_vec);
nL = L==0;
[~,ind] = bwdist(~nL);
iL = L;
iL(nL) = L(ind(nL));

% FlexRatio = (max(iL) - min(iL))/length(iL); %% old
Grad_zp = zp;
for k = 1:length(Grad_zp)-1
    Grad_zp(k+1) = max(Grad_zp(k:k+1));
end

figure,plot(Grad_zp),hold on
zdata = 1:length(Grad_zp);
Scoef = 300; %% um,
Scoef = Scoef/Reso(3); 
Delete_Deep_shift = zdata>Scoef - Shift_z;
% Delete_Deep_shift = false(size(Grad_zp));
% for k = length(Grad_zp):-1:2
%     if Grad_zp(k) == Grad_zp(k-1)
%         Delete_Deep_shift(k) = true;
%     else
%         break
%     end
% end
Grad_zp(Delete_Deep_shift) = [];
plot(Grad_zp)
pfit = polyfit(1:length(Grad_zp),Grad_zp,1);
text(0,0,[num2str(pfit(1)) 'x + ' num2str(pfit(2)) ]),drawnow
FlexRatio = 1/pfit(1);
% pfit = polyfit(1:length(iL),iL,1);
% FlexRatio = 1/pfit(1);

disp([' ...Flexibility Ratio :' num2str(FlexRatio)])
%% Old vp
% % vp = linspace(1,round(CompNum/2),round(CompNum/2/FlexRatio));
% % vp = [vp vp(end)+iL];
% % EndVp = size(imA,2)-length(vp) - Shift_z;
% % if EndVp>0
% %     EndVp = 1:(EndVp);
% % end
% % vp = [vp vp(end)+EndVp];

%% New(2016. 11 23) vp
vp = linspace(1,size(B,3),round(size(B,3)/FlexRatio));

%%
siz = size(A);
siz(3) = length(vp);
outB = zeros(siz,'like',B);
B = permute(B,[1 3 2 4 5]);
outB = permute(outB,[1 3 2 4 5]);
resiz = size(outB);
B = reshape(B,size(B,1),size(B,2),[]);
outB = reshape(outB,size(outB,1),size(outB,2),[]);
[~,Y] = meshgrid(1:length(vp),1:size(A,1));
X = repmat(vp,[size(A,1) 1]);
CLASS = class(B);
parfor n = uint16(1:size(outB,3))
    im = double(B(:,:,n));    
    outB(:,:,n) = feval(CLASS,interp2(1:size(im,2),1:size(im,1),im,X,Y,'nearest'));
end
outB = reshape(outB,resiz);
outB = permute(outB,[1 3 2 4 5]);

if Shift_z>0
    outB = padarray(outB,[0 0 Shift_z 0 0],0,'pre');
elseif Shift_z<0
    outB(:,:,1:abs(Shift_z),:,:) = [];
end
zdata = 1:size(outB,3);
if size(outB,3)>size(A,3)    
    zdata = zdata > size(A,3);
    outB(:,:,zdata,:,:) = [];
elseif size(outB,3) < size(A,3)
    PadNum = size(A,3) - size(outB,3);
    outB = padarray(outB,[0 0 PadNum 0 0],0,'post');    
end   

outB = flip(outB,3);

end

