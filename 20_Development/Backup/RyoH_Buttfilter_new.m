%% new butterworth filter edit by RyoH in 2016.09.12
% function output = input(vectl ,reso ,stepsize ,cutofflen)
vectl = v; % 深さ方向のラインプロファイル
reso = 4.94; % 元のstepsize
stepsize = 0.1; % interp後のstepsize
cutofflen = 5; % カットしたい長さ[μm]

% サンプリング周波数の決定
Fs = round((length(v) - 1) * reso / stepsize);

%% spline
spv = interp1(1:length(vectl),double(vectl),(length(vectl)/(Fs - 1):1/(Fs/length(vectl)):length(vectl),'spline');

% [X,Y,Z] = meshgrid(1:size(bz,2),1:size(bz,1),1:1/(Fs-1)*(size(bz,3)-1):size(bz,3));
% spl = interp3(double(med),X,Y,Z,'spline');
% clear X Y Z

%% making butter
cutofffrequency = cutofflen/stepsize;
Wn = 2 * pie * (cutofffrequency / (Fs / 2));
[b a] = butter(1,Wn); % 後に次数も変更

%% filtering
left = filter(b,a,spv);
right = filter(b,a,flip(spv));
right = flip(right);
hv = max((left+right)/2,0); % 負の値を0にしている
clear left right

figure
plot(spv)
hold on
plot(hv)

output.acutualstepsize = 805/(length(spv) - 1);
output.filtervectl = hv;