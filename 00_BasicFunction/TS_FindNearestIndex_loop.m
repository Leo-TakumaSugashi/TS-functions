% function 
% AssuranceLength = 20; % um
% Base = Centroid(1).xyz;
% Comp = Centroid(2).xyz;

% % Main Function
function [NearestIndx,Map,LEN] = TS_FindNearestIndex_loop(Base,Comp,Reso,AssuranceLength)

%% 1st
[NearestIndx,Map,~] = TS_FindNearestIndex(Base,Comp,Reso,AssuranceLength);
TF = true;
X = [];
Y = [];
% LEN = [];
%% loop
num = 1;
while TF
    [y,x] = find(NearestIndx);
    X = [X ; x];
    Y = [Y ; y];
%     LEN = [LEN ; Len];
    Base(x,:) = nan;
    Comp(y,:) = nan;
    [NearestIndx,~,Len] = TS_FindNearestIndex(Base,Comp,Reso,AssuranceLength);
    if isempty(Len)
        TF = false;
    end
    disp([mfilename ' loop num = ' num2str(num)])
    num = num + 1;
end

NearestIndx = false(size(Map));
for n = 1:length(Y)
    NearestIndx(Y(n),X(n)) = true;
end
[y,x] = find(NearestIndx);
LEN = zeros(size(y));
for n = 1:length(y)
    LEN(n) = Map(y(n),x(n));
end



% PlotXYZ = cat(3,Base(x,:),Comp(y,:));
% PlotXYZ = permute(PlotXYZ,[3 2 1]);
% Len = zeros(size(y));
% for n = 1:length(y)
%     Len(n) = Map(y(n),x(n));
% end
% disp([ '  1st Find...[Max. Min:] = ' num2str([max(Len) min(Len)])])
% figure,
% axes('Nextplot','add')
% for n = 1:size(PlotXYZ,3)
%     plot3(PlotXYZ(:,1,n),PlotXYZ(:,2,n),PlotXYZ(:,3,n),...
%         'Color','b')
% end
% view(3)

