%% umat   �s�m���������s��
disp('=================================================================')
help umat
%  umat �́A�ʏ� ATOM �Ƒ��� umat �̑���ɂ���č쐬����܂��B
%   ���Z�A��Z�A�t�s��A���������␂�������̌����Ȃǂ̑����̕W���I�ȍs��̑��삪
%   �\�ł��B umat �� �s/�� �̎w��ɂ��A�Q�Ƃ⊄�蓖�Ă��\�ł��B
%  
%   �R�}���h umat �́A�ő��Ɏg���܂���B �������AM �� DOUBLE �̏ꍇ�A
%   H = umat(M) �́AM ��s�m�����̂Ȃ��s�m���������s��ɂ��܂��B
%   ���l�ɁAM ���s�m����������ATOM�̏ꍇ�AH = umat(M) �́A�����P�ɁAM ��s�m����������
%   �s��̒l�ɂ��܂��B ������̏ꍇ���ASIMPLIFY(H,'class') �́AM �Ɠ����ɂȂ�܂��B
%  
%   M �� umat �̏ꍇ�AM.NominalValue �́AM ��
%   ����e ATOM ������NominalValue�Œu�����������ʂɂȂ�܂��B
%  
%   M �� umat �̏ꍇ�AM.Uncertainty �́AM �ɂ���s�m���������� ATOM�̂��ׂĂ�
%   �L�q���ꂽ�I�u�W�F�N�g�ł��B���ׂĂ�ATOM���Q�Ƃ��邱�Ƃ��ł��A������
%   �v���p�e�B���AUncertainty�Q�[�g�E�F�C���g���ďC�����邱�Ƃ��ł��܂��B
%   ���Ƃ��΁AM �� umat �ŁAB �� M ���̕s�m�������������p�����[�^ (UREAL) �̏ꍇ�A
%   M.Uncertainty.B �ɂ��AM �̕s�m����������ATOM B �ɃA�N�Z�X�ł��܂��B
%  
%     % ��� (�J�b�g/�y�[�X�g)
%     % 3�� ATOM ���쐬
%     a = ureal('a',5,'Range',[2 6]);
%     b = ucomplex('b',1+j,'Radius',0.5);
%     c = ureal('c',3,'Plusminus',0.4);
%     % a �� b ���� 2�~2 �� umat ���쐬
%     M1 = [a b;b*a 7];
%     % CLASS(M1) �̃`�F�b�N
%     class(M1)
%     % a �� c ����ʂ�2�~2 �� umat ���쐬
%     M2 = [c 0;2+a a];
%     class(M2)
%     % 2�̕s�m���������s��̑���
%     M = M1*M2
%  
%     �Q�l: ureal, ucomplex, methods(umat), usample, usubs
% 
%     �I�[�o�[���[�h ���\�b�h:
%        StaticModel/umat
% 
%     �w���v �u���E�U�[���̎Q�ƃy�[�W
%        doc umat

%% ind2sub - ���`�C���f�b�N�X����Y���𒊏o
disp('=================================================================')
help ind2sub
%     ���� MATLAB �֐� �̓T�C�Y siz �̍s��̍s�� IND �̊e���`�C���f�b�N�X�ɑ�������s�Ɨ�̓Y�����܂ލs�� I �� J ��Ԃ��܂��Bsiz ��
%     ndim(A) �v�f (���̏ꍇ�� 2) ������x�N�g���ŁAsiz(1) �͍s���Asiz(2) �͗񐔂ł��B
% 
%     [I,J] = ind2sub(siz,IND)
%     [I1,I2,I3,...,In] = ind2sub(siz,IND)
% 
%     ind2sub �̃��t�@�����X �y�[�W
% 
%     �Q�l find, size, sub2ind

%% mfilename - ���ݎ��s���̊֐��̃t�@�C����
disp('=================================================================')
help mfilename
%     ���� MATLAB �֐�
%     �́A���݌Ăяo����Ă���֐��̃t�@�C�������܂ޕ������Ԃ��܂��B�t�@�C������Ăяo���ꂽ�ꍇ�́A���̃t�@�C���̖��O��Ԃ��܂��B���̂��߁A�t�@�C�������ύX����Ă���ꍇ�ł��A�֐��͂��̖��O�����ʂł��܂��B
% 
%     mfilename
%     p = mfilename('fullpath')
%     c = mfilename('class')
% 
%     mfilename �̃��t�@�����X �y�[�W
% 
%     �Q�l dbstack, function, inputname, nargin, nargout

%% waitbar - �E�F�C�g �o�[�̃_�C�A���O �{�b�N�X���J���܂��͍X�V����
disp('=================================================================')
help waitbar
%     ���� MATLAB �֐� �́A�����̊����� x �̃E�F�C�g �o�[��\�����܂��B�E�F�C�g �o�[ Figure �́A���䂷��R�[�h�ɂ���ĕ�����܂ŁA���邢��
%     [�E�B���h�E�����] �{�^�����N���b�N����܂ŕ\������܂��B�E�F�C�g �o�[�� Figure �̃n���h���ԍ��́Ah �ɕԂ���܂��B���� x �́A0 �� 1
%     �̊Ԃ̐��l�łȂ���΂Ȃ�܂���B
% 
%     h = waitbar(x,'message')
%     waitbar(x,'message','CreateCancelBtn','button_callback')
%     waitbar(x,'message',property_name,property_value,...)
%     waitbar(x)
%     waitbar(x,h)
%     waitbar(x,h,'updated message')
% 
%     waitbar �̃��t�@�����X �y�[�W
% 
%     �Q�l close, delete, dialog, getappdata, msgbox, setappdata

%% 
disp('=================================================================')
load topo
x = 0:359;                                % longitude
y = -89:90;                               % latitude
% % ������
figure
contour(x,y,topo,[0 0])
axis equal                                % set axis units to be the same size
box on                                    % display bounding box
ax = gca;                                 % get current axis
a.XLim = [0 360];                        % set x limits
a.YLim = [-90 90];                       % set y limits
a.XTick = [0 60 120 180 240 300 360];    % define x ticks
a.YTick = [-90 -60 -30 0 30 60 90];      % define y ticks
set(ax,a)
clear a
pause(1)

% % Output Image
image([0 360],[-90 90], flip(topo), 'CDataMapping', 'scaled')
colormap(topomap1)
axis equal                                % set axis units to be the same size
ax = gca;                                 % get current axis
a.XLim = [0 360];                        % set x limits
a.YLim = [-90 90];                       % set y limits
a.XTick = [0 60 120 180 240 300 360];    % define x ticks
a.YTick = [-90 -60 -30 0 30 60 90];      % define y ticks
set(ax,a)
clear ax a
pause(1)

% % Texturemap
clf
[x,y,z] = sphere(50);          % create a sphere
sh = surface(x,y,z);            % plot spherical surface

s.CData = topo;                % set color data to topographic data
s.FaceColor = 'texturemap';    % use texture mapping
s.EdgeColor = 'none';          % remove edges
s.FaceLighting = 'gouraud';    % preferred lighting for curved surfaces
s.SpecularStrength = 0.4;      % change the strength of the reflected light

lh = light('Position',[-1 0 1]);     % add a light

axis square off                % set axis to square and remove axis
view([-30,30])                 % set the viewing angle
set(sh,s)
clear ax s topo topolegend topomap1 topomap2 x y z sh

%% light control
[az,el] = lightangle(lh);
Theta = -pi:pi/180:pi; % Class az
Fai = 45 * pi/180; % Class el
for rp = 1:2
for n = 1:length(Theta)
%     lightangle(lh,Theta(n)*180/pi,sin(Theta(n))*90)
%     view(Theta(n)*180/pi+45,sin(Theta(n))*90)
    lightangle(lh,Theta(n)*180/pi,45)
    view(Theta(n)*180/pi+90,30)
    drawnow
end
end
% clear Theta Fai az el rp n lh
         

%% 
disp('=================================================================')

%%
























disp('=================================================================')