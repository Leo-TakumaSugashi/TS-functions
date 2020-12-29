function bw = TS_Label2choice(L,nl)
% input
% L : label data
% nl: choice object number
% 
% output 
%     bw : choiced logical data
nl = double(nl);
[h,x] = hist(nl,1:max(nl(nl>0)));
nl = x(h>0);


bw = false(size(L));
for n = 1:length(nl)
    bw = or(bw,L == nl(n));
end



