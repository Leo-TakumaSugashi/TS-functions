function [outputA,outputB,Ref] = TS_Shift2padreposi(A,B,shift_siz,varargin)
% [outputA,outputB] = TS_Shift2padreposi(A,B,shift_siz,{'crop'})
% shift_siz = TS_SliceReposition(A,B)
if and(size(A,3)~=1,size(B,3)~=1)
    error('Input A and B is not matrix');
end
siza = size(A);
sizb = size(B);
if max(siza ~= sizb)
    error('Input size of A and B is not equal');
end
if ~isvector(shift_siz)
    error('Input Shift size is NOT Correct')
end
ori_siz = size(A);
shift_siz = round(shift_siz);
output_siz = [size(A,1) size(A,2)] + abs(shift_siz);
Ref = shift_siz;
Ref(Ref>0) = 0; %% + shift --> B is nessceseeery to shift
Ref(Ref<0) = abs(Ref(Ref<0)); %% - shift --> A  is nessceseeery to shif

shift_siz(shift_siz<0) = 0;%% - shift --> A  is nessceseeery to shif

outputA = zeros([round(output_siz) 1 size(A,4) size(A,5)],'like',A);
outputB = outputA;
%% output 
outputA(Ref(1)+1:Ref(1)+ori_siz(1),Ref(2)+1:Ref(2)+ori_siz(2),:,:,:) = A;
outputB(shift_siz(1)+1:shift_siz+ori_siz(1),...
    shift_siz(2)+1:shift_siz(2)+ori_siz(2),:,:,:) = B;

%%
if strcmpi(varargin,'crop')
    outputA = outputA(Ref(1)+1:Ref(1)+ori_siz(1),Ref(2)+1:Ref(2)+ori_siz(2),:,:,:);
    outputB = outputB(Ref(1)+1:Ref(1)+ori_siz(1),Ref(2)+1:Ref(2)+ori_siz(2),:,:,:);
end