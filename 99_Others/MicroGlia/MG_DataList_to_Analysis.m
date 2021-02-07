SaveDir = '/mnt/NAS/Share4/Tsukada_Ryota/MGlist2ana';
MG = MG_Functions;
NumNumel = 2; 
for n = 1:length(List)
    Path = TS_ConvertOurNAS(List(n).FULLPATH);
    for t = 1:length(List(n).TIME)
        PP = List(n).TIME(t).Path;
        for loc = 1:length(List(n).TIME(t).Location)
            ImPath = List(n).TIME(t).Location(loc).ImagePath;
            roiPath = List(n).TIME(t).Location(loc).roiPath;
            impath = [Path filesep PP filesep ImPath];
            roipath = [Path filesep PP filesep roiPath];
            matObj = matfile(impath);
            w = whos(matObj);            
            for x = 1:length(w)
                if length(w(x).size)==5
                    load(impath,w(x).name)
                    eval(['Image = ' w(x).name ';'])
                    Image = Image(:,:,:,:,2);
                    eval(['clear ' w(x).name ';'])
                else
                    load(impath,w(x).name); %% Reso
                end
            end
            load(roipath); %% ROIdata
            N = TS_num2strNUMEL(List(n).Day(t),NumNumel);
            Prom = [List(n).Name '_Day' N];
            LocChar = num2str(List(n).TIME(t).Location(loc).LocNumber);
            MG.MG2FormAnalysis(Image,Reso,ROIdata,SaveDir,Prom,LocChar)
            clear Image Reso ROIdata Prom Loc x w matObj roipath impath ImPath roiPath
%             for x = 1:length(w)
%                 if length(w(x).size)==5
%                     disp(['n' num2str(n) 't' num2str(t) 'loc' num2str(loc)])
%                 else
%                     if ~strcmpi(w(x).name,'Reso')
%                         disp('UPS!!')
%                     end
%                 end
%             end                    
%             disp(impath)
        end
    end
end