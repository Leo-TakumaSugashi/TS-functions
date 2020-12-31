function [pipexdata,pipeydata,pipezdata]=sweep(cutdata,pathdata)
% [pipexdata,pipeydata,pipezdata]=sweep(cutdata,pathdata)
% Sweep a cross section data to generate a pipe data
% 
% Input Argument:
% cutdata   cross section data, m x 3 matrix
% pathdata  sweep pathdata, m x 3 matrix, the first point of pathdata must
% in the cross section plane
% Output Argument:
% pipexdata     output pipe x data
% pipeydata     output pipe y data
% pipezdata     output pipe z data
% 
% Usage:
%   t=linspace(0,4*pi,31);
%   % A circle in x-y plane
%   cutdata=[cos(t(:)) sin(t(:)) zeros(31,1)];
%   % A half-circle path
%   t=linspace(0,pi,51);
%   R=20;
%   pathdata=R*[cos(t(:))-1 zeros(51,1) sin(t(:))];
%   [pipexdata,pipeydata,pipezdata]=sweep(cutdata,pathdata);
%   surf(pipexdata,pipeydata,pipezdata)
%   axis equal;xlim([-50,10]);ylim([-30,30]);
%
%   Author: Changshun Deng
%   Email: heroaq_2002@163.com
%   WEB-Log: http://waitingforme.yculblog.com
%   15/12/2006, Some Rights Reserved
[mp,np]=size(pathdata);
[mc,nc]=size(cutdata);
if np~=3 error('The column number of pathdata must be 3!'); end
%normal direction of cutdata
cutnorm=cross(cutdata(2,:)-cutdata(1,:),cutdata(3,:)-cutdata(2,:));
cutnorm=cutnorm/sqrt(sum(cutnorm.^2));
%judge if the start point is in the cutplan
if dot(cutnorm,pathdata(1,:)-cutdata(1,:))~=0
    error('The start point of the path must in the corss section plane!')
end
%direction verctor
nv=diff(pathdata);
%initialize return data
nv=[0 0 0;nv;nv(end,:)];
cutdata=cutdata-repmat(pathdata(1,:),mc,1);
for i=1:mp
    xtemp=cutdata(:,1)+pathdata(i,1);
    ytemp=cutdata(:,2)+pathdata(i,2);
    ztemp=cutdata(:,3)+pathdata(i,3);
    dotval=dot(nv(i+1,:)./sqrt(sum(nv(i+1,:).^2)),cutnorm);
    rang=acos(dotval)*180/pi;
    ax=cross(cutnorm,nv(i+1,:));
    if all(ax==0)
        ax=cutnorm;
    end
    [xtemp,ytemp,ztemp]=rotatedata(xtemp,ytemp,ztemp,ax,rang,pathdata(i,:));
    pipexdata(:,i)=xtemp;
    pipeydata(:,i)=ytemp;
    pipezdata(:,i)=ztemp;
end
pipexdata=pipexdata';
pipeydata=pipeydata';
pipezdata=pipezdata';
