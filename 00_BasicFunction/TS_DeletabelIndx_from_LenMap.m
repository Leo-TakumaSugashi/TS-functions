function Delete_Idx = TS_DeletabelIndx_from_LenMap(Len_map,Area)
% see also, TS_EachLengthMap

[Minimum_Distance,Minimum_Dist_Idx] = min(Len_map,[],1);
Ave = mean(Minimum_Distance);
SD = nanstd(Minimum_Distance);

% figure,plot(Minimum_Distance)
% text(1,max(Minimum_Distance),...
%     ['[Ave. SD] = [' num2str(Ave) ' '  num2str(SD) ']']);

% % Minimum Distance and Volume[a.u.]
figure,plot(Minimum_Distance,Area,'*');
    xlabel('Minimum Distance [\mum]')
    ylabel('Volume [a.u.]')
    
% % 
Check_Idx = find(Minimum_Distance < Ave - SD);
Delete_Idx = false(size(Minimum_Dist_Idx));
for n = 1:length(Check_Idx)
    MyVolume = Area(Check_Idx(n));
    ObjVolume = Area(Minimum_Dist_Idx(Check_Idx(n)));
    if MyVolume > ObjVolume
        Delete_Idx(Minimum_Dist_Idx(Check_Idx(n))) = true;
    else
        Delete_Idx(Check_Idx(n)) = true;
    end
end
Delete_Idx = find(Delete_Idx);


% % 
    hold on
    plot(Minimum_Distance(Delete_Idx),...
        Area(Delete_Idx),'o');
    legend('Input Point','Delete Point')
     text(mean(Minimum_Distance),mean(Area),...
     ['Minimum distance [Ave./ SD] = [' num2str(Ave) '/'  num2str(SD) ']']);
