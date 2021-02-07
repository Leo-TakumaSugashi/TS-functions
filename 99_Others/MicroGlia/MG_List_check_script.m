% MG list check 
Fname = UIgetfile([TS_ConvertNAS('/mnt/NAS/SSD/TSmatdata'),'/*.mat']);
mobj = matfile(Fname);
data = load(Fname);
%% main
imgs(1:size(data.ObjListImage,1)) = struct('Image',[],'Size',[],'Resolution',[]);
%%
for n = 32:size(data.ObjListImage,1)
    Fullname = data.cData{n,2};
    if isempty(Fullname)
        continue
    end
    
    p = find(Fullname=='.');
    ex = Fullname(p(end)+1:end);
    switch ex
        case 'lif'
            if n ~=1
                if ~strcmp(Fullname,data.cData{n-1,2})
                    child = HKloadLif_vTS(TS_ConvertNAS(Fullname));
                end
            else
                child = HKloadLif_vTS(TS_ConvertNAS(Fullname));
            end
            for k = 1:length(child)
                if strcmp(child(k).Name,data.cData{n,3})
                    Image = child(k).Image;
                    Reso = child(k).Resolution;
                    break
                end
            end
        case 'oif'
        case 'mat'
    end
    siz = size(Image);
    Image = max(Image,[],3);
    Image = nanmean(Image,4);
    Image = rgbproj(squeeze(Image));
    imgs(n).Image = Image;
    imgs(n).Size = siz;
    imgs(n).Resolution = Reso;
    disp([num2str(n) '/' num2str(size(data.cData,1))])
end
clear Image siz Reso k child n ex p Fullname