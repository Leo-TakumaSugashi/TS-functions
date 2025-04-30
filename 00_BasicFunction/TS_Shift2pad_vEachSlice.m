function [outputA,outputB] = TS_Shift2pad_vEachSlice(A,B,shift_siz,varargin)
% [outputA,outputB] = TS_Shift2pad2d(A,B,shift_siz)
% shift_siz = TS_SliceReposition(A,B)


Minimum = min(shift_siz,[],1);
Maximum = max(shift_siz,[],1);




% Ref = round(abs(Minimum));
% % edit 2016 12 17
Ref = round(abs(Minimum) .* double(Minimum <0));
ori_siz = [size(A,1) size(A,2)];

if ~isvector(shift_siz)   
    output_siz = [size(A,1) size(A,2)] + (max(Maximum,0)- Minimum);    
    Sshift_siz = round(shift_siz + repmat(Ref,[size(shift_siz,1) 1]) +1 );
else    
    output_siz = [size(A,1) size(A,2)] + abs(shift_siz);
%     Sshift_siz = shift_siz - (shift_siz) +1;
    % % edit 2016 12 16
    Sshift_siz = shift_siz - (shift_siz.*double(shift_siz<0))+1;
end
outputA = zeros([round(output_siz) size(A,3) size(A,4) size(A,5)],'like',A);
outputB = outputA;

outputA(Ref(1)+1:Ref(1)+ori_siz(1),Ref(2)+1:Ref(2)+ori_siz(2),:,:,:) = A;

for n = 1:size(Sshift_siz,1)
    y = Sshift_siz(n,1);
    x = Sshift_siz(n,2);
    outputB(y:y+ori_siz(1)-1,x:x+ori_siz(2)-1,n,:,:) = B(:,:,n,:,:);    
end

% edit 2016 12 23
outputA = zeros(size(outputB),'like',A);
outputA(Ref(1)+1:Ref(1)+ori_siz(1),Ref(2)+1:Ref(2)+ori_siz(2),:,:,:) = A;

if strcmpi(varargin,'crop')
    outputA = outputA(Ref(1)+1:Ref(1)+ori_siz(1),Ref(2)+1:Ref(2)+ori_siz(2),:,:,:);
    outputB = outputB(Ref(1)+1:Ref(1)+ori_siz(1),Ref(2)+1:Ref(2)+ori_siz(2),:,:,:);
end