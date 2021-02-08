function SEG = TS_SEGmargin_MG48(SEG1,SEG2,SEG3,SEG4)

rsiz = [1024 1008 1101+24];
SEG = SEG1;
SEG.       Output = [];
SEG.       AddBP = [];
SEG.      Branch= [];
SEG.  BranchGroup= [];
SEG.          End= [];
% SEG.    Pointdata= [1Å~44233 struct]
SEG.      BPmatrix= [];
SEG.       loopNum= [SEG1.loopNum SEG2.loopNum SEG3.loopNum SEG4.loopNum];
SEG.       cutlen= [SEG1.cutlen SEG2.cutlen SEG3.cutlen SEG4.cutlen];
SEG.     Original= [];





for n = 1:4
eval(['size(SEG' num2str(n) '.Original)'])
end


for k = 1:4
    seg = eval(['SEG' num2str(k) ';']);
    Shift_val = index_shift(k)
    for n = 1:length(seg.Pointdata)
        xyz = seg.Pointdata(n).PointXYZ;
        xyz(:,1) = xyz(:,1) + Shift_val(1);
        xyz(:,2) = xyz(:,2) + Shift_val(2);
        xyz(:,3) = xyz(:,3) + Shift_val(3);
        seg.Pointdata(n).PointXYZ = xyz;
    end
    eval(['SEG' num2str(k) ' = seg; clear seg'])
end

SEG. Pointdata= [SEG1.Pointdata SEG2.Pointdata SEG3.Pointdata SEG4.Pointdata];

end

function A = index_shift(n)
switch n 
    case 1
        A = [453 508 -9];
    case 2
        A = [0 513  -24];
    case 3
        A = [0 8  -20]; 
    case 4
        A = [495 0 -11];
end
end

% 3 4 
% 2 1
% y =
%    713  2
%    208  3
%    200  4
%    708  1
% x =
%    200  2    
%    200  3 
%    695  4
%    653  1
% z =
%    376
%    380
%    389
%    391