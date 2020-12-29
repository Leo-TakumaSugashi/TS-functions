function varargout = imagescReso(varargin)
% varargout = TS_imagesc(varargin)
% TS_imagesc(im,Reso)
% TS_imagesc(axh,im,Reso)
% image_handle = TS_imagesc(~)
%
% edit 2019,11,07 Sugashi,

[axh,im,Reso] = input_param(varargin{:});
xdata = 1:size(im,2);
xdata = (xdata-1).*Reso(1);

ydata = 1:size(im,1);
ydata = (ydata-1).*Reso(2);

h = imagesc(axh,im,'XData',xdata,'YData',ydata);
if nargout ==1
    varargout{1} = h;
end
end



function [axh,im,Reso] = input_param(varargin)
    narginchk(2,3)
    a = varargin{1};
    b = varargin{2};
    if and(ishandle(a),isscalar(a))
        axh = a;
        im = b;
        Reso = varargin{3};
    else
        axh = axes;
        im = a;
        Reso = b;
    end    
end

