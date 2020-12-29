function [TF,BranchMatrix] = TS_CheckBranch(TrueBranch,AutoBranch,CheckLen)

[y,x,z] = ind2sub(size(TrueBranch),find(TrueBranch(:)));
T_xyz = cat(2,x,y,z);
[y,x,z] = ind2sub(size(AutoBranch),find(AutoBranch(:)));

BranchMatrix = cat(2,x,y,z);
TF = false(length(x),1);

for n = 1:length(x)
    p = padarray([x(n) y(n) z(n)],...
        [size(T_xyz,1)-1 0],'symmetric','pre');
    LEN =  sqrt( sum( (p - T_xyz).^2 , 2) );
    TF(n) =  min(LEN) <= CheckLen ;
    clear p LEN
end