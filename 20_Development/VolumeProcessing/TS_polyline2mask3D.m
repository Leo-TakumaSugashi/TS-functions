function varargout = TS_polyline2mask3D(XYZ,MNL)
tic
x = XYZ(:,1); y = XYZ(:,2); z = XYZ(:,3);
M = MNL(1); N =MNL(2); L =MNL(3);
validateattributes(x,{'double','single'},{},mfilename,'XYZ',1);
% validateattributes(y,{'double'},{},mfilename,'Y',2);
% validateattributes(y,{'double'},{},mfilename,'Z',3);
% if length(x) ~= length(y)
%     error(message('images:poly2mask:vectorSizeMismatch'));
% end
if length(x)~=length(y) || length(x)~=length(z) || length(y)~=length(z)
    error('input x,y,z, length missing match.')
end

validateattributes(x,{'double'},{'real','vector','finite'},mfilename,'XYZ',1);
% validateattributes(y,{'double'},{'real','vector','finite'},mfilename,'Y',2);
% validateattributes(y,{'double'},{'real','vector','finite'},mfilename,'Z',3);
validateattributes(M,{'double'},{'real','integer','nonnegative'},mfilename,'MNL',2);
% validateattributes(N,{'double'},{'real','integer','nonnegative'},mfilename,'N',5);
% validateattributes(N,{'double'},{'real','integer','nonnegative'},mfilename,'L',6);

[xe,ye,ze] = ts_poly2edgelist(x,y,z);
if nargout>0
    ind = sub2ind([M,N,L],round(ye),round(xe),round(ze));
    varargout{1} = ind;
end
if nargout>1
    BW = false(M,N,L);
    BW(ind) = true;
    varargout{2} = BW;
end

end

function [xe, ye, ze] = ts_poly2edgelist(x,y,z)
%   [xe,ye,ze] = ts_poly2edgelist(x,y,z,scale)
% Based on poly2edgelist,
%POLY2EDGELIST Computes list of horizontal edges from polygon.
%   [XE,YE] = POLY2EDGELIST(X,Y) rescales the polygon represented
%   by vectors X and Y by a factor of 5, and then quantizes them to
%   integer locations.  It then creates a new polygon by filling in
%   new vertices on the integer grid in between the original scaled
%   vertices.  The new polygon has only horizontal and vertical
%   edges.  Finally, it computes the locations of all horizontal
%   edges, returning the result in the vectors XE and YE.
%
%   [XE,YE] = POLY2EDGELIST(X,Y,SCALE) rescales by a factor of
%   SCALE instead of 5.  SCALE must be a positive odd integer.
%
%   See also EDGELIST2MASK, POLY2MASK, ROIPOLY.
%
%   Copyright 1993-2008 The MathWorks, Inc.

num_segments = length(x) - 1;
x_segments = cell(num_segments,1);
y_segments = cell(num_segments,1);
z_segments = cell(num_segments,1);
for k = 1:num_segments
    [x_segments{k},y_segments{k},z_segments{k}] = ts_intline(...
        x(k),x(k+1),y(k),y(k+1),z(k),z(k+1));
end

% Concatenate segment vertices.
xe = cat(1,x_segments{:});
ye = cat(1,y_segments{:});
ze = cat(1,z_segments{:});
end

function [x,y,z] = ts_intline(x1, x2, y1, y2, z1, z2)
dx = abs(x2 - x1);
dy = abs(y2 - y1);
dz = abs(z2 - z1);
Nu = round(max([dx,dy,dz]))+1;
% Check for degenerate case.
if ((dx == 0) && (dy == 0) && (dz ==0))
  x = x1;
  y = y1;
  z = z1;
  return;
end
x = linspace(x1,x2,Nu).';
y = linspace(y1,y2,Nu).';
z = linspace(z1,z2,Nu).';
end
