function [outA,outB,overrap] = TS_3dReposiPre_v2(A,B,Reso,varargin)
% [outA,outB,overrap] = TS_3dReposiPre_proto(A,B,{'crop'})
% Z size eqalizer

siza = size(A);
sizb = size(B);

% RefPosiZ = 1; 
if siza(3)>sizb(3)
    B = padarray(B,[0 0 siza(3)-sizb(3)],0,'pre');
elseif siza(3)<sizb(3)
    A = padarray(A,[0 0 sizb(3)-siza(3)],0,'pre');
%     RefPosiZ = RefPosiZ +  (sizb(3)-siza(3));
end
rap1 = siza(3) - sizb(3);

%% 1st Control Depth(axis-z)
MIPxum = 300; %% um
MIPxnum = ceil(MIPxum / Reso(2));
USEzum = 300; %% um
USEznum = ceil(USEzum / Reso(3)) - 1 ;

a = squeeze(max(TS_AdjImage(A(:,1:MIPxnum,end - USEznum: end,1,1)),[],2));
b = squeeze(max(TS_AdjImage(B(:,1:MIPxnum,end - USEznum: end,1,1)),[],2));

%% add Reuint8
a = TS_Image2uint8(single(a),'all');
b = TS_Image2uint8(single(b),'all');
% figure,imagesc(rgbproj(cat(3,a,b)))

shift_d = TS_SliceReposition(a,b);
if sign(shift_d(2))==-1
    A = padarray(A,[0 0 round(-shift_d(2))],0,'pre');
    B = padarray(B,[0 0 round(-shift_d(2))],0,'post');
    
elseif sign(shift_d(2))==1
    A = padarray(A,[0 0 round(shift_d(2))],0,'post');
    B = padarray(B,[0 0 round(shift_d(2))],0,'pre');
    
end

n = 1;
im = A(:,:,n,1,1);
while max(im(:))==0
    n = n+ 1;
    im = A(:,:,n,1,1);
end
NoneSliceA = n-1;

n = 1;
im = B(:,:,n,1,1);
while max(im(:))==0
    n = n+ 1;
    im = B(:,:,n,1,1);
end
NoneSliceB = n-1;

cutdepth = min([NoneSliceA NoneSliceB]);
if cutdepth>0
    A(:,:,1:cutdepth,:,:) = [];
    B(:,:,1:cutdepth,:,:) = [];
end
outA = A;
outB = B;
overrap = rap1 + cutdepth;

if max(strcmpi(varargin,'crop'))
    NoneSliceA = NoneSliceA - cutdepth;
    outA = outA(:,:,NoneSliceA+1:NoneSliceA+siza(3),:,:);
    outB = outB(:,:,NoneSliceA+1:NoneSliceA+siza(3),:,:);
    overrap = NoneSliceB - cutdepth;
end




