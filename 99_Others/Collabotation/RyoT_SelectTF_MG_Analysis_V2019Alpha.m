function RyoT_SelectTF_MG_Analysis_V2019Alpha(data,Type)

try
switch Type
    case 'soma'
        S = cat(1,data.Result.Soma_SectionalArea);
        [~,Index] =sort(S);
        Name = data.NewDir;
        clear data
    case 'process'
        error('not now .by sugashi')
    otherwise
end


D = uigetdir(pwd);

TifImage = dir([D '/*tif']);
Image = struct('im',[]);
for n = 1:length(TifImage)
    im = imread([D filesep TifImage(n).name]);
    Image(n).im = im;
end
DimFiveImage = cat(4,Image.im);
DimFiveImage = DimFiveImage(:,:,:,Index);
DimFiveImage = permute(DimFiveImage,[1 2 5 4 3]);
DimFive(DimFiveImage,[1 1 1],Name)
catch err
    keyboard
end


