function SSS = TS_emergencyprogram_Others2Cap(SEG)

Pdata = SEG.Pointdata;
for n = 1:length(Pdata)
    if Pdata(n).ID <0
        continue
    end
    Type = Pdata(n).Class;
    if strcmpi(Type,'others')
        Pdata(n).Class = 'Cap.';
    end
end
SEG.Pointdata = Pdata;
SSS = SEG;