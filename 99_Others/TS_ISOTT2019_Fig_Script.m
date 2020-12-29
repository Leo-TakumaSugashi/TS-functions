function varargout =   TS_ISOTT2019_Fig_Script
%% old path ~2019.11.30%
% % if ispc
% %     STR = ['\\192.168.2.120\Share4\00_Sugashi\' ...
% %         '10_Since2016\20_Matlab\12_Matlab_data\2019_ISOTT_Paper' ...
% %         '\Figure_Script.m'''];
% % elseif isunix
% %     STR = ['/mnt/NAS/Share4/00_Sugashi/',...
% %         '10_Since2016/20_Matlab/12_Matlab_data/',...
% %         '2019_ISOTT_Paper/Figure_Script.m'];
% % end
%% New path ~20129.12.1
if ispc
    STR = ['\\192.168.2.120\Share6\00_Sugashi\' ...
        '10_Since2016\20_Matlab\12_Matlab_data\2019_ISOTT_Paper' ...
        '\Figure_Script.m'''];
elseif isunix
    STR = ['/mnt/NAS/Share6/00_Sugashi/',...
        '10_Since2016/20_Matlab/12_Matlab_data/',...
        '2019_ISOTT_Paper/Figure_Script.m'];
end



if nargout == 0
    fprintf(STR)
else
    p = find(STR== filesep);
    STR(p(end):end) = [];
    varargout{1} = STR ;
end
    