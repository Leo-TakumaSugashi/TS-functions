function A= TS_LoadLSF_proto(str)


fp = fopen(str);
Index = fread(fp);
Index(1:1024) = [];
A = reshape(Index,600,480,1,[]);
if max(A(:))<2^8
    A = uint8(A);
elseif max(A(:))<2^16
    A = uint16(A);
end
A = permute(A,[2 1 3 4]);

%% 560x600??
