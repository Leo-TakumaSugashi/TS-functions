function A = TS_DiamOutline(BW,skel,Reso)
% A = TS_DimaOutline(BW,skel)
if ~isvector(Reso)
    error('input Resolution is NOT correct')
end

Dist = zeros(size(BW),'like',single(1));
A = Dist;
parfor n = 1:size(BW,3)
    sliceim = BW(:,:,n);
    Dist(:,:,n) = bwdist(~sliceim);        
end

A(skel) = (Dist(skel)  * 2 ) * mean(Reso(1:2));

% if nargin>3
%     if and(strcmp(varargin{1},'figure'),length(Reso)>=3)
%         
%     figure,
%     axes
%     drawnow
%     
%     num = max(A(:));
%     map = jet(ceil(num));
%     [y,x,z] = ind2sub(size(skel),find(skel(:)));
%     Y = (y-1) * Reso(2);
%     X = (x-1) * Reso(1);
%     Z = (z-1) * Reso(3);
%     n = 1;
%     num = ceil(A(y(n),x(n),z(n)));
%     plot3(Y(n),X(n),Z(n),'Color',map(num,:))
%     view(3)
%     hold on
%         for n = 2:length(y)
%             num = ceil(A(y(n),x(n),z(n)));
%             plot3(Y(n),X(n),Z(n),'.','Color',map(num,:))
%             drawnow
%         end
%     end
% end