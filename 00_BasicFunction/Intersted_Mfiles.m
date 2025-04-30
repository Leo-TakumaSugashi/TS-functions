%% umat   不確かさをもつ行列
disp('=================================================================')
help umat
%  umat は、通常 ATOM と他の umat の操作によって作成されます。
%   加算、乗算、逆行列、水平方向や垂直方向の結合などの多くの標準的な行列の操作が
%   可能です。 umat の 行/列 の指定により、参照や割り当てが可能です。
%  
%   コマンド umat は、滅多に使われません。 しかし、M が DOUBLE の場合、
%   H = umat(M) は、M を不確実性のない不確かさをもつ行列にします。
%   同様に、M が不確かさをもつATOMの場合、H = umat(M) は、ただ単に、M を不確かさをもつ
%   行列の値にします。 いずれの場合も、SIMPLIFY(H,'class') は、M と同じになります。
%  
%   M が umat の場合、M.NominalValue は、M に
%   ある各 ATOM をこのNominalValueで置き換えた結果になります。
%  
%   M が umat の場合、M.Uncertainty は、M にある不確かさをもつ ATOMのすべてが
%   記述されたオブジェクトです。すべてのATOMを参照することができ、これらの
%   プロパティを、Uncertaintyゲートウェイを使って修正することができます。
%   たとえば、M が umat で、B が M 内の不確かさをもつ実数パラメータ (UREAL) の場合、
%   M.Uncertainty.B により、M の不確かさをもつATOM B にアクセスできます。
%  
%     % 例題 (カット/ペースト)
%     % 3つの ATOM を作成
%     a = ureal('a',5,'Range',[2 6]);
%     b = ucomplex('b',1+j,'Radius',0.5);
%     c = ureal('c',3,'Plusminus',0.4);
%     % a と b から 2×2 の umat を作成
%     M1 = [a b;b*a 7];
%     % CLASS(M1) のチェック
%     class(M1)
%     % a と c から別の2×2 の umat を作成
%     M2 = [c 0;2+a a];
%     class(M2)
%     % 2つの不確かさをもつ行列の操作
%     M = M1*M2
%  
%     参考: ureal, ucomplex, methods(umat), usample, usubs
% 
%     オーバーロード メソッド:
%        StaticModel/umat
% 
%     ヘルプ ブラウザー内の参照ページ
%        doc umat

%% ind2sub - 線形インデックスから添字を抽出
disp('=================================================================')
help ind2sub
%     この MATLAB 関数 はサイズ siz の行列の行列 IND の各線形インデックスに相当する行と列の添字を含む行列 I と J を返します。siz は
%     ndim(A) 要素 (この場合は 2) があるベクトルで、siz(1) は行数、siz(2) は列数です。
% 
%     [I,J] = ind2sub(siz,IND)
%     [I1,I2,I3,...,In] = ind2sub(siz,IND)
% 
%     ind2sub のリファレンス ページ
% 
%     参考 find, size, sub2ind

%% mfilename - 現在実行中の関数のファイル名
disp('=================================================================')
help mfilename
%     この MATLAB 関数
%     は、現在呼び出されている関数のファイル名を含む文字列を返します。ファイルから呼び出された場合は、そのファイルの名前を返します。このため、ファイル名が変更されている場合でも、関数はその名前を識別できます。
% 
%     mfilename
%     p = mfilename('fullpath')
%     c = mfilename('class')
% 
%     mfilename のリファレンス ページ
% 
%     参考 dbstack, function, inputname, nargin, nargout

%% waitbar - ウェイト バーのダイアログ ボックスを開くまたは更新する
disp('=================================================================')
help waitbar
%     この MATLAB 関数 は、長さの割合が x のウェイト バーを表示します。ウェイト バー Figure は、制御するコードによって閉じられるまで、あるいは
%     [ウィンドウを閉じる] ボタンをクリックするまで表示されます。ウェイト バーの Figure のハンドル番号は、h に返されます。引数 x は、0 と 1
%     の間の数値でなければなりません。
% 
%     h = waitbar(x,'message')
%     waitbar(x,'message','CreateCancelBtn','button_callback')
%     waitbar(x,'message',property_name,property_value,...)
%     waitbar(x)
%     waitbar(x,h)
%     waitbar(x,h,'updated message')
% 
%     waitbar のリファレンス ページ
% 
%     参考 close, delete, dialog, getappdata, msgbox, setappdata

%% 
disp('=================================================================')
load topo
x = 0:359;                                % longitude
y = -89:90;                               % latitude
% % 等高線
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