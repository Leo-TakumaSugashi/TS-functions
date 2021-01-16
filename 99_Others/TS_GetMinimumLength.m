function lenMap = TS_GetMinimumLength(X,Y)
% lenMap = TS_GetMinimumLength(X,Y)
% This functio is for Simulation Scatter 
% 
% lenMap = zeros(size(X));
% xyz = cat(2,X,Y);  
% parfor n = 1:length(X)
%     Target = [X(n),Y(n)];  
%     len =   sqrt( sum( (xyz - Target).^2,2 ) ) ;
%     len(n) = nan;    
%     lenMap(n) = min(len);
% end
%
% edit by Sugashi.T. 2021 Jan. 16th

lenMap = zeros(size(X));
xyz = cat(2,X,Y);  
parfor n = 1:length(X)
    Target = [X(n),Y(n)];  
    len =   sqrt( sum( (xyz - Target).^2,2 ) ) ;
    len(n) = nan;    
    lenMap(n) = min(len);
end