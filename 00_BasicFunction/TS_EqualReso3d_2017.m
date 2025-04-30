function [output,ActualReso] = TS_EqualReso3d_2017(Image,Reso,NewReso,varargin)
% [output,ActualReso] = TS_EqualReso3d(Image,Reso(X Y Z),NewReso(scalar))


if or(ndims(Image)>3,isvector(Image))
    error('Input Dim. is NOT 3 or 2.')
end
    
%% interp. val
Type = 'cubic';
if nargin == 4
    Type = varargin{1};
end
%% main 
siz = size(Image);
FOV = (siz-1) .*Reso;
NewSiz = ceil(FOV ./NewReso + 1);
output = imresize3(Image,NewSiz,Type);
NewSiz = size(output);
ActualReso = FOV ./(NewSiz -1 );
return


