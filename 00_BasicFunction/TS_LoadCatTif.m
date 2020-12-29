function TS_LoadCatTif(DIR,SaveTO)

Nowdir = cd;



cd(DIR)
Cdir = dir(DIR);
%% Check Tif
Tifdir = dir('*tif');
if ~isempty(Tifdir)
    for n = 1:length(Tifdir)
        im = imread(Tifdir(n).name);
        if ndims(im)==3
            im = rgb2gray(im);
        end
        Image(:,:,n) = im;
        clear im
    end
    if max(Image(:))<2^8
        Image = uint8(Image);
    elseif max(Image(:))<2^16
        Image = uint16(Image);
    end
    cd(SaveTO)
    Name = [DIR '_' Tifdir(n).name '_' num2str(round(rand(1)*1000))];
    ind = Name=='\';Name(ind) = '_';
    ind = Name==':';Name(ind) = '_';
    ind = Name=='.';Name(ind) = '_';
    ind = Name==' ';Name(ind) = '_';
    save(Name,'Image')
    cd(Nowdir)
    clear Image
end





%% フォルダーの参照と繰り返し
for n = 3:length(Cdir)
    if Cdir(n).isdir
        Nowcd = cd;
        Name = [DIR '\' Cdir(n).name];
        disp(Name)
        cd(Name)
        TS_LoadCatTif(Name,SaveTO)
        cd(Nowcd)
    end
end

cd(Nowdir)