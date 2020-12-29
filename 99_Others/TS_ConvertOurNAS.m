function A = TS_ConvertOurNAS(DirName)
warning('This Function will be remove in furure. Upgrade ver. is TS_ConvertNAS')
A = TS_ConvertNAS(DirName);
return
% % % % % % A = TS_ConvertOurNAS(DirName)
% % % % % % \\192.168.2.120\...<==> /mnt/NAS/
% % % % % IP = '192.168.2.120';
% % % % % % ParentList = {'Share1','Share2','Share3','Share4','Share5','Share6','SSD'};
% % % % % 
% % % % % InputDirNameIspc = max(DirName =='\');
% % % % % if InputDirNameIspc
% % % % %     if ispc
% % % % %         A = DirName;
% % % % %     elseif and(isunix,~ismac)
% % % % %         p = find(DirName =='\');
% % % % %         if p(3) == 16
% % % % %             if strcmpi(DirName(p(3)+1:p(3)+3),'New')
% % % % %                 A = ['/mnt/NAS/' filesep, DirName(p(3)+4:end)];
% % % % %             else
% % % % %                 A = ['/mnt/NAS' DirName(p(3):end)];
% % % % %             end
% % % % %             A(A=='\') = filesep;
% % % % %         else
% % % % %             warning('Input Dir Name is Not understood')
% % % % %             A = DirName;
% % % % %         end
% % % % %     elseif ismac
% % % % %         p = find(DirName =='\');
% % % % %         if p(3) == 16
% % % % %             if strcmpi(DirName(p(3)+1:p(3)+3),'New')
% % % % %                 A = ['/Users/leo/NAS' filesep, DirName(p(3)+4:end)];
% % % % %             else
% % % % %                 A = ['/Users/leo/NAS' DirName(p(3):end)];
% % % % %             end
% % % % %             A(A=='\') = filesep;
% % % % %         else
% % % % %             warning('Input Dir Name is Not understood')
% % % % %             A = DirName;
% % % % %         end
% % % % %     end
% % % % % else
% % % % %     if and(isunix,~ismac)        
% % % % %         A = DirName;
% % % % %     elseif ismac
% % % % %         A = ['/Users/leo' DirName(5:end)];
% % % % %     elseif ispc
% % % % %         p = find(DirName =='/');
% % % % %         if p(3) == 9
% % % % %             if max(strcmpi(DirName(p(3)+1:p(4)-1),{'Share1','Share2'}))
% % % % %                 A = ['\\' IP '\New' DirName(p(3)+1:end)];
% % % % %             else
% % % % %                 A = ['\\' IP DirName(p(3):end)];
% % % % %             end
% % % % %             A(A=='/') = filesep;
% % % % %         else
% % % % %             warning('Input Dir Name is Not understood')
% % % % %             A = DirName;
% % % % %         end
% % % % %     end
% % % % % end
% % % % % A = ChangeFirstChara(A);
% % % % % A = DeleteShareX(A);
% % % % % end
% % % % % 
% % % % % function FullPath = ChangeFirstChara(s)
% % % % %     UnixTF = and(isunix,~ismac);
% % % % %     L = false(1,length(s));
% % % % %     for n = 1:length(L)
% % % % %         L(n) = or(strcmpi(s(n),'/'),strcmpi(s(n),'\'));
% % % % %     end
% % % % %     p = find(L);    
% % % % % %     p = [0 p];
% % % % %     if ~L(end)
% % % % %         p = [p length(L)+1];
% % % % %     end
% % % % %     S = s;
% % % % %     FullPath = [];
% % % % %     for n = 1:length(p)-1
% % % % %         STR = S(p(n)+1:p(n+1)-1);
% % % % % 
% % % % %         switch lower(STR)
% % % % %             case {'share1','share2','share3','share4','share5','share6',}
% % % % %                 if UnixTF || ismac
% % % % %                     STR(1) = upper(STR(1));
% % % % %                     STR(2:end) = lower(STR(2:end));
% % % % %                 else
% % % % %                     STR = lower(STR);
% % % % %                 end
% % % % %             case {'newshare1','newshare2'}
% % % % %                 if isunix
% % % % %                     STR = STR(4:end);
% % % % %                 end
% % % % %             case {'ssd','m2ssd'}
% % % % %                 if UnixTF || ismac
% % % % %                     STR = upper(STR);
% % % % %                 else
% % % % %                     STR = lower(STR);
% % % % %                 end
% % % % %         end
% % % % %         
% % % % %         %S(p(n)+1:p(n+1)-1) = STR;
% % % % %         if isempty(STR)
% % % % %             continue
% % % % %         end
% % % % %         FullPath = [FullPath filesep STR];
% % % % %     end
% % % % %     if ispc
% % % % %         Fullpath= [filesep FullPath];
% % % % %     end
% % % % % end
% % % % % 
% % % % % function A = DeleteShareX(str)
% % % % % p = find(str==filesep);
% % % % % if p(end)~=length(str)
% % % % %     p = [p length(str)+1];
% % % % % end
% % % % % TF = false(size(str));
% % % % % for k = 1:length(p)-1
% % % % %     checkname = str(p(k)+1:p(k+1)-1);
% % % % %     if strcmpi(checkname,'sharex')
% % % % %         TF(p(k):p(k+1)-1) = true;
% % % % %         break
% % % % %     end
% % % % % end
% % % % % str(TF) = '';
% % % % % A = str;
% % % % % end