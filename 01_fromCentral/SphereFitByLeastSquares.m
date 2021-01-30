function [Center,Radius] = SphereFitByLeastSquares(X)
% this fits a sphere to a collection of data using a closed form for the
% solution (opposed to using an array the size of the data set). 
% Minimizes Sum((x-xc)^2+(y-yc)^2+(z-zc)^2-r^2)^2
% x,y,z are the data, xc,yc,zc are the sphere's center, and r is the radius
% Assumes that points are not in a singular configuration, real numbers, ...
% if you have coplanar data, use a circle fit with svd for determining the
% plane, recommended Circle Fit (Pratt method), by Nikolai Chernov
% http://www.mathworks.com/matlabcentral/fileexchange/22643
% Input:
% X: n x 3 matrix of cartesian data
% Outputs:
% Center: Center of sphere 
% Radius: Radius of sphere
% Author:
% Alan Jennings, University of Dayton
A=[mean(X(:,1).*(X(:,1)-mean(X(:,1)))), ...
    2*mean(X(:,1).*(X(:,2)-mean(X(:,2)))), ...
    2*mean(X(:,1).*(X(:,3)-mean(X(:,3)))); ...
    0, ...
    mean(X(:,2).*(X(:,2)-mean(X(:,2)))), ...
    2*mean(X(:,2).*(X(:,3)-mean(X(:,3)))); ...
    0, ...
    0, ...
    mean(X(:,3).*(X(:,3)-mean(X(:,3))))];
A=A+A.';
B=[mean((X(:,1).^2+X(:,2).^2+X(:,3).^2).*(X(:,1)-mean(X(:,1))));...
    mean((X(:,1).^2+X(:,2).^2+X(:,3).^2).*(X(:,2)-mean(X(:,2))));...
    mean((X(:,1).^2+X(:,2).^2+X(:,3).^2).*(X(:,3)-mean(X(:,3))))];

Center=(A\B).';

Radius=sqrt(mean(sum([X(:,1)-Center(1),X(:,2)-Center(2),X(:,3)-Center(3)].^2,2)));
end








% function [R,xyz] = SphereFitByLeastSquares(XYZ)
% % % % A = -2*a
% % % % B = -2*b
% % % % C = -2*c
% % % % D = a^2 + b^2 + c^2 - r^2
% % % warning('This Function has error.....by Sugashi')
% % % 
% % % if size(XYZ,1)<3
% % %     error('Input X,Y,Z point need 4 or more')
% % % end
% % % 
% % % A1 = [2*sum(XYZ(:,1).^2,1), sum(prod(XYZ(:,[1 2]),2),1),...
% % %     sum(prod(XYZ(:,[1 3]),2),1), sum(XYZ(:,1),1)];
% % % A2 = [sum(prod(XYZ(:,[1 2]),2),1), 2*sum(XYZ(:,2).^2,1),...
% % %     sum(prod(XYZ(:,[2 3]),2),1), sum(XYZ(:,2),1)];
% % % A3 = [sum(prod(XYZ(:,[1 3]),2),1), sum(prod(XYZ(:,[2 3]),2),1),...
% % %      2*sum(XYZ(:,3).^2,1), sum(XYZ(:,3),1)];
% % % A4 = [sum(XYZ,1),2];
% % % A0 = cat(1,A1,A2,A3,A4);
% % % 
% % % B0 = -[...
% % %     sum(XYZ(:,1).^3) + sum(XYZ(:,1).*XYZ(:,2).^2) + sum(XYZ(:,1).*XYZ(:,3).^2);
% % %     sum(XYZ(:,2).*XYZ(:,1).^2) + sum(XYZ(:,2).^3) + sum(XYZ(:,2).*XYZ(:,3).^2);
% % %     sum(XYZ(:,3).*XYZ(:,1).^2) + sum(XYZ(:,3).*XYZ(:,2).^2) + sum(XYZ(:,3).^3);
% % %     sum(sum(XYZ.^2,2),1)];
% % % 
% % % ABCD = A0 \ B0;
% % % 
% % % a = -ABCD(1)/2;
% % % b = -ABCD(2)/2;
% % % c = -ABCD(3)/2;
% % % r =sqrt(a^2 + b^2 + c^2  - ABCD(4) );
% % % 
% % % R = r;
% % % xyz = [a b c];







