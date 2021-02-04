function output = RyoH_butterfilter_ts(vectl,reso,stepsize,cutofflen,varargin)
% output = RyoH_butterfilter(vectl,reso,stepsize,cutofflen)
% Input : 
%     vectl  % �[�������̃��C���v���t�@�C��
%     reso  % ����stepsize mum/pixesl
%     stepsize = 0.1  % interp���stepsize unit mum
%     cutofflen = 5; % �J�b�g����������[��m]

Butter_Dim = 1;
LineWidth = 2;
FontSize = 12;
% �T���v�����O���g���̌���
Fs = round((length(vectl) - 1) * reso / stepsize);


%% spline
xdata = 1:length(vectl);
% xvp = (length(vectl)/(Fs - 1):1/(Fs/length(vectl)):length(vectl);
xpv = linspace(1,length(vectl),Fs);
ActualStep = diff(xpv(1:2)) * reso;
spv = interp1(xdata,double(vectl),xpv,'spline');

%% making butter
cutoff_samplNUM = cutofflen/ActualStep;% cutoff���������̂̃T���v�����O��
% % % ����50�~�N�����̒����̂��̂��A1�~�N�����Ԋu�Ŏ擾����ƁA
% % % 50Hz�i���T�O/�P�j�ƂȂ�B
% % % ������A�O.�P�~�N�����Ԋu�̃X�e�b�v�ɂ���ƁB
% % % �T���v�����O���iFs�j�͖�500���i���m�ɂ�,���ۂ̃X�e�b�v�Ԋu���Z�o�j�ƂȂ�A
% % % �T���v�����O���g���Ƃ��Ă�500Hz�ƂȂ�B
% % % Input�łQ�D�T�~�N������cutoff�������Ƃ�����B�B�B
% % % cutoff�������T���v�����O���Ƃ��Ă�,�Q�D�T�~�N����/0.1�ʁ@=�@25���A�ƂȂ�A
% % % �S�̂̃T���v�����O���iFs�j����l����ƁA���g����
% % % �@�@Fs/25�@=�@500/25�@=�@20 Hz,
% % %  ��Wn = Cutoff[Hz] / (Sample[Hz] /2);���@�@�@�@-->����͓��͂��S�āA0.5Hz�ƂȂ�悤�ɂ���Ă�B
% % %  �@Wn = 20 / (500/2) = (500/25) / (500/2) = (1/25) / (1/2) = 2/25�ƂȂ�B

% cutofffrequency = Fs / cutoff_samplNUM; % ���g���ɕϊ�(Fs / cutoff_samplNUM)
% Wn =  cutofffrequency / (Fs/2); % matlab. butter�p��Wn�ɕϊ�
% Wn = (1/cutoff_samplNUM)/(1/2);
Wn = 2/cutoff_samplNUM;
[b,a] = butter(Butter_Dim,Wn,'high'); % Butter_Dim

%% filtering
left = filter(b,a,spv);
right = filter(b,a,flip(spv));
right = flip(right);
hv = max((left+right)/2,0); % ���̒l��0�ɂ��Ă���


output.Input = vectl;
output.Resolution = [num2str(reso) ' um'];
output.InputStepSize = [num2str(stepsize) ' um/pixels'];
output.CutoffLength = [num2str(cutofflen ) ' um'];
output.ButterDim = Butter_Dim;
output.Interp_spline = spv;
output.Interp_xdata = xpv;
output.ActualStepSize = [num2str(ActualStep ) ' um/pixels'];
output.Filtered_Left = left;
output.Filtered_Right = right;
output.Output = hv;
output.Fs = Fs;
output.Wn = Wn;

%% Check figure
if nargin<=4
    return
end
if and(~isempty(varargin{:}),strcmpi(varargin{:},'figure'))
fgh = figure('Posi',[20 20 1000 800],'Color','w');
    centerfig(fgh)
xdata = (xdata-1) * reso;
xpv = (xpv-1) * reso;
plot(xdata,Normalized_vec(vectl),'ko')
set(gca,'FontSize',FontSize)
hold on
plot(xpv,Normalized_vec(spv,cutofffrequency),'k--','LineWidth',LineWidth)
plot(xpv,Normalized_vec(left,cutofffrequency),'r:','LineWidth',LineWidth)
% plot(xpv + cutofflen,Normalized_vec(left,cutofffrequency),'r:')
plot(xpv,Normalized_vec(right,cutofffrequency),'b:','LineWidth',LineWidth)
% plot(xpv - cutofflen,Normalized_vec(right,cutofffrequency),'b:')
plot(xpv,Normalized_vec(hv,cutofffrequency),'g-','LineWidth',LineWidth)
legend('input','Spline','left','right','output')
grid
axis tight
xlabel('Axis Z(Depth) [\mum]')
ylabel('Normalized pixels value [a.u.]')
TextAdd(output,fgh)
end

function A= Normalized_vec(Line,varargin)
if nargin>1
    cut = round(varargin{1});
    Line(1:cut) = nan;
    Line(end-cut+1:end) = nan;
end
Line(~isnan(Line)) = max(Line(~isnan(Line)),0);
Line = double(Line - min(Line(:)));
A = Line./max(Line);

function TextAdd(output,fgh)
STR = {['Input Resolution: ' output.Resolution ...
    ', /Input Step Size: ' output.InputStepSize ...
    ', /Actual Step Size(interpolation value):' output.ActualStepSize];
    [' Cutoff Length: ' output.CutoffLength ...
    ',  /Fs: ' num2str(output.Fs) ' [samples],' ...
    ',  /Wn: ' num2str(output.Wn / pi/2) ' ��[rad./samples]']};
posi = get(fgh,'posi');
h = uicontrol('Style','text','Unit','pixels',...
    'Posi',[0 posi(4)-30 posi(3) 30],...
    'String',STR,...
    'BackgroundColor',get(fgh,'Color'),...
    'FontSize',11);
set(h,'Unit','Normalized')











