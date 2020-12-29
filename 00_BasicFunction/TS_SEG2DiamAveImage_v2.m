function DiamImage = TS_SEG2DiamAveImage_v2(SEG)
% This Function is Prototype,,,,
% ���ʂƂ��āA�č\���p��Diameter Image���ł����OK
% �P�Z�O�����g���̕���_���܂ޕ��ς��a�Ƃ��āA
% ���ꂼ��̃Z�O�����g�_�ɑ���B�B
% 
% �g����Z�O�����g�A�g���Ȃ��Z�O�����g���o�Ă���͂��B

Pdata = SEG.Pointdata;
Size = size(SEG.Output);
try
DiamImage = zeros(SEG.Size,'like',single(1));
catch err
    warning(err.message)
    DiamImage = zeros(Size,'like',single(1));
end
C = 0;
for n = 1:length(Pdata)
    D = Pdata(n).AverageDiameter;
    if or(or( isempty(D) , isnan(D)) , D < 2)
        C = C + 1;
        continue
    end
    xyz = Pdata(n).PointXYZ;
    for k = 1:size(xyz,1)
        DiamImage(xyz(k,2),xyz(k,1),xyz(k,3)) = ...
            max([D DiamImage(xyz(k,2),xyz(k,1),xyz(k,3))]); %% Each Branch point...
    end
end
disp(['   Number of Not Count (Segment) = ' num2str(C) '/ ' num2str(n)])    




