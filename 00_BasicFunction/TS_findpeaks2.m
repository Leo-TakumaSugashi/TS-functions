function [pks2,X,Y] = TS_findpeaks2(Image)
%  
% Mask = TS_findpeaks2(Image)
% parfor ...
%         x and y axis
%        pks = findpeaks(vec)
%        ....
% edit 2016 11 11, Sugashi . T

if ~ismatrix(Image)
    error('NOT Matrix data')
end
Image = double(Image);
X = false(size(Image));
Y = X;
parfor n = 1:size(Image,1);
    vec = Image(n,:);
    try
    [~,pks] = findpeaks(vec);
    Ind = false(size(vec));
    Ind(pks) = 1;
    X(n,:) = Ind;
    catch        
    end
    
end

parfor n = 1:size(Image,2);
    vec = Image(:,n);
    try
    [~,pks] = findpeaks(vec);
    Ind = false(size(vec));
    Ind(pks) = 1;
    Y(:,n) = Ind;
    catch
    end
end
pks2 = and(X,Y);