fixed = dicomread('knee1.dcm');
moving = dicomread('knee2.dcm');
% 位置のずれたイメージを表示します。
imshowpair(fixed, moving,'Scaling','joint')
% 異なるセンサーから得たイメージであるため、モダリティを 'multimodal' に設定
[optimizer, metric] = imregconfig('multimodal')

% 問題が大域的最大値に落ち着き、より多くの反復が可能となるように、オプティマイザーのプロパティを調整します。
optimizer.InitialRadius = 0.009;
optimizer.Epsilon = 1.5e-4;
optimizer.GrowthFactor = 1.01;
optimizer.MaximumIterations = 300;

% レジストレーションを実行します。\
movingRegistered = imregister(moving, fixed, 'affine', optimizer, metric);

% レジストレーションが行われたイメージを表示します。
figure
imshowpair(fixed, movingRegistered,'Scaling','joint')