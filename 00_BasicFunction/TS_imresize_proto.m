function A = TS_imresize_proto(data,xyz,varargin)

Time = tic;
if nargin>2
    Type = varargin{1};
else
    Type = 'cubic';
end
Class = class(data);

for n = 1:size(data,1)
    im = squeeze(data(n,:,:));
    im = imresize(im,[xyz(1) xyz(3)],Type);
    im = imrotate(im,90);
    A(n,:,:) = im;
end
Time = toc(Time);
A = feval(Class,flip(permute(A,[1 3 2]),3));
Time = round(Time * 10) /10;
disp(['Time of Processing Resize data is ' num2str(Time) ' sec'])
disp(['  ... by ' mfilename ])