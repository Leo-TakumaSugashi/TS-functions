function ROIdata = TS_Centroid2ROIdata(s,Color)

if isstruct(s)
    xyz = cat(1,s.Centroid);
elseif ismatrix(s)
    xyz = s;
else
    error('input is not correct');
end

if size(xyz,2) == 3
    z = round(xyz(:,3));
elseif size(xyz,2) == 2
    z = 1;
else
    error('input xyz or struct ''s'' is Not Correct')
end
x = xyz(:,1);
y = xyz(:,2);

if nargin==1
    Color = [0.6 .3 1];
end

ROIdata(1:length(y)) = struct(...
      'handle',[],...
     'Lineobh',[],...
     'existTF',1,...
     'class','impoint',...
    'Position',[1 1],...
       'Plane','xy',...
       'Depth',1,...
        'Time',1,...
       'Color',Color);

for n = 1:length(y)
    ROIdata(n).Position = [x(n) y(n)];
    ROIdata(n).Depth = z(n);
end
