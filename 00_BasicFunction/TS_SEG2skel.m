function skel = TS_SEG2skel(SEG)
skel = SEG.Input; 
warning('skel = SEG.Input;???')
return
skel = false(size(SEG.Input));
Pdata = SEG.Pointdata;
for n = 1:length(Pdata)
    xyz = Pdata(n).PointXYZ;
    for k = 1:size(xyz,1)
        skel(xyz(k,2),xyz(k,1),xyz(k,3)) = true;
    end
    clear xyz
end
