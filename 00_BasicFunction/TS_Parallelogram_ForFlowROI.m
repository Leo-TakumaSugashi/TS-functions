function varargout = TS_Parallelogram_ForFlowROI(Reso,mask,varargin)


narginchk(2,3)
if ~ismatrix(mask)
    error('Input mask is NOT Correct')
end

if ~islogical(mask)
    error('Input Mask is NOT Logical')
end


if nargin == 2
    skel = TS_Skeleton3D_v7(mask);
else
    skel = varargin{1};
end

%% 1st Šm”F
fgh = figure('posi',[10 10 500 500]);
centerfig(fgh)
axh = axes('posi',[0 0 1 1]);
imh = imagesc(cat(3,mask,skel,false(size(mask))));
axis image off
Input = input('This is Correct ? (true or false) ; ');
Input = logical(Input);
if ~Input
    close(fgh)
    varargout{1} = [];
    return
end

%% 2nd, input  Start and End
set(axh,'posi',[0 .05 1 .945])
impixelinfo

SP = input('Input Start Position [Y X] = ');
hold on
plot(SP(2),SP(1),'ob')
EP = input('Input End   Position [Y X] = ');
plot(EP(2),EP(1),'sb')
legend('Start','End')
High = input('Input Half of Hight [pix.] = ');

%% create Mask

dim = bwdist(~mask) .*single(skel);%% radius point data

[sLineMask,sNewMask] = TS_NormLine_v170412(SP,dim,skel,Reso);

StartMask = and(bwdist(sLineMask) <= High,mask);
 sL = bwlabel(StartMask);
 StartMask = sL == mode(sL(and(sNewMask,sL>0)));

 
 
[eLineMask,eNewMask] = TS_NormLine_v170412(EP,dim,skel,Reso);

EndMask = and(bwdist(eLineMask) <= High,mask);
 eL = bwlabel(EndMask);
 EndMask = eL == mode(eL(and(eNewMask,eL>0)));

 imh.CData = cat(3,or(mask,or(StartMask,EndMask)),skel,or(StartMask,EndMask));
XLIM = xlim;
YLIM = ylim;
text(mean(XLIM)- diff(XLIM)*0.1,mean(YLIM),...
    'Finish!!',...
    'BackGroundColor',[1 1 1])

if nargout == 1
    output.StartMask = StartMask;
    output.EndMask   = EndMask;
    output.StartPosition = SP;
    output.EndPosition = EP;
    output.HalfSize = High;
    output.InputMask = mask;
    output.Skeleton = skel;
    output.Resolution = Reso;
    varargout{1} = output;
end
    














