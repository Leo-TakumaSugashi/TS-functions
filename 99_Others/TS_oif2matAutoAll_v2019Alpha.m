function JM_oif2matAutoAll_v2019Alpha(varargin)
% Original program is HY_oif2matAutoAll_v3
%  edit by sugashi

ChCatMode = true;
if(nargin>0)
    if(strcmp(varargin{1},'ChRev'))
        ChCatMode = false;
    end
end
SereachName = '.oif.files';
CD = cd;
j1 = dir([CD filesep '*' SereachName]);
for n = 1:length(j1)
    j2 = j1(n).name;
    fprintf([j2 '...'])
    l1 = length(j2);
    if(l1>length(SereachName))
        Isrequest = strcmp(j2(end-length(SereachName)+1:end),SereachName);
        j3 = j2(1:end-length(SereachName));
        j3(j3=='-') ='_'; 
        if and(isempty(dir([j3 '.mat'])),(Isrequest))            
            if(ChCatMode)
                eval([j3,' = JM_oif2matAuto_v2019Alpha(j2);']);
            else
                eval([j3,' = JM_oif2matAuto_v2019Alpha(j2,''ChRev'');']);
            end
            save(j3,j3,'-v7.3')
            fprintf('Done.\n')
        else
            fprintf('Exisiting File. Skip.\n')            
        end
        cd(CD)
    end
end



