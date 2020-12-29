function TS_immake(dirname,name)
% TS_immake(name)
% ディレクトリnameと
% その内部のフォルダー（直下階層すべて）のFunc.roop
%    Edition 2016 Aug. 28th by Sugashi

DIR = dir(dirname);

%% フォルダー内に何もなかったら返す
if length(DIR)<3
    return
end
%% main func.

checkname = dir(['*' name '*.mat']);
if ~isempty(checkname)
for n = 1 :length(checkname)
    disp(['   ' checkname(n).name ])
    load(checkname(n).name)
    try
    NImage = TS_Normalized_AxisZ_proto(data.fImage);
    writeName = checkname(n).name;
    Ind = find(writeName == '.');
    writeName(Ind:end) = [];
    disp(['  ' writeName '_XY.tif'])
    imwrite(max(NImage,[],3),gray(256),[writeName '_XY.tif'],'tif')
    xz = squeeze(max(NImage,[],1));
    im = imrotate(imresize(squeeze(xz),[size(NImage,2) round(size(NImage,3)*11.2201)]),90);
    imwrite(im,gray(256),[writeName '_XZ.tif'],'tif')
    clear data NImage im Ind writeName xz
    catch err
        disp(err)
    end
end
end


%% フォルダーの参照とTS_immakeの繰り返し
for n = 3:length(DIR)
    if DIR(n).isdir
        Nowcd = cd;
        Name = [dirname '\' DIR(n).name];
        disp(Name)
        cd(Name)
        TS_immake(Name,name)
        cd(Nowcd)
    end
end
