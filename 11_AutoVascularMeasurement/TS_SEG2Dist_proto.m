function Distbw = TS_SEG2Dist_proto(SEG)
% Distbw = TS_SEG2Dist_proto(SEG)

Distbw = single(zeros(size(SEG.Input)));

for n = 1:length(SEG.Pointdata)
    xyz = round(SEG.Pointdata(n).PointXYZ);
    diam = SEG.Pointdata(n).ResultAnalysis;
    diam = cat(1,diam.Diameter);
     copy_diam = diam;
     Ind = find(isnan(diam));
     if isempty(Ind)
         x = 1:length(diam);
         x(Ind) = [];
         diam(Ind) = [];
          vp = interp1(x,diam,Ind,'pchip');
          copy_diam(Ind) = vp;
         diam = copy_diam;
     end
     clear Ind copy_diam x vp
     for k = 1:length(diam)
         Distbw(xyz(k,2),xyz(k,1),xyz(k,3)) = diam(k);
     end
end
         
     
    