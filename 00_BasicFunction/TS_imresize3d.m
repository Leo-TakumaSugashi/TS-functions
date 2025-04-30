function A = TS_imresize3d(data,xyz,varargin)

Time = tic;
if nargin>2
    Type = varargin{1};
else
    Type = 'cubic';
end

data = imresize(data,xyz(1:2),Type);
data = permute(data,[1 3 2 4 5]);
A = imresize(data,[xyz(1) xyz(3)],Type);
A = permute(A,[1 3 2 4 5]);
Time = round(toc(Time) * 10) /10;
disp(['Time of Processing Resize data is ' num2str(Time) ' sec'])
disp(['  ... by ' mfilename ])