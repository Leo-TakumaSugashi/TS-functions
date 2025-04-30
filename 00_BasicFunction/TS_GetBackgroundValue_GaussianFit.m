function [M,expectS] = TS_GetBackgroundValue_GaussianFit(im)
im = double(im);
Maximum = max(im(:));
Minimum = min(im(:));
if Maximum == Minimum || isnan(Maximum) 
    M = Maximum;
    expectS = Maximum;
    return
end
% % % Nim = (im - Minimum) / (Maximum - Minimum);
% % % Level = graythresh(Nim);
% % % expectS = im(Nim>Level); %% version Oct.19,
% % % im = im(Nim <= Level);
% % % if isempty(im)
% % %     M = nan;
% % %     expectS = nan;
% % %     return
% % % elseif numel(im) <= 3
% % %     M = mode(IM(IM<max(IM(:))));
% % %     expectS = max(im(:));
% % %     return
% % % end    
% % % Maximum = max(im(:));
BIN = max(min(Maximum-Minimum,256),128);

[h,x] = histcounts(round(im(:)),linspace(Minimum,Maximum,BIN));
x = movmean(x,2);
x = x(2:end);
fg = fit(x(:),h(:),'gauss8');
Ave = zeros(1,8);
% for n = 1:8
% disp(['Ave(' num2str(n) ') = fg.b' num2str(n) ';'])
% end
Ave(1) = fg.b1;
Ave(2) = fg.b2;
Ave(3) = fg.b3;
Ave(4) = fg.b4;
Ave(5) = fg.b5;
Ave(6) = fg.b6;
Ave(7) = fg.b7;
Ave(8) = fg.b8;
Ave(Ave<0) = nan;
M = nanmin(Ave);
expectS = nanmax(Ave);