function A= TS_LoadLSF_Folder_proto(str)
CD = cd;

cd(str)


%% ProjInfo
fp = fopen('ProjInfo.dat');
ProjInfo = fread(fp,'*char')';
disp(ProjInfo)
fclose(fp);

data = dir('*.lsf');
Image = struct('Image',[]);
wh = waitbar(0,[mfilename ', wait...']);
for n = 1:length(data)
   Image(n).Image = loadslf(data(n).name);
   waitbar(n/length(data),wh)
end
A = cat(4,Image.Image);
close(wh)
cd(CD)
end

function A = loadslf(fname)
 fp = fopen(fname);
    Index = fread(fp);
    Index(1:1024) = [];
    nnum = floor(numel(Index)/(600*480));
    A = reshape(Index(1:600*480*nnum),600,480,1,[]);
    if max(A(:))<2^8
        A = uint8(A);
    elseif max(A(:))<2^16
        A = uint16(A);
    end
    A = permute(A,[2 1 3 4]);
end