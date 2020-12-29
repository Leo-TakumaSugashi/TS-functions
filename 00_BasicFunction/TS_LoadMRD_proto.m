function Image = TS_LoadMRD_proto(str,varargin)

fp = fopen(str);
Ind = fread(fp);
if max(Ind(:)) < 2^8
    Ind = uint8(Ind);
end

Ind2  = Ind(242:2:end);
cx = 760*568:760*568:length(Ind2);
cx(end) = [];
Ind3 = Ind2;
Ind3([cx cx+1]) = [];

Image = reshape(Ind3,760,568,[]);

Image = permute(Image,[2 1 4 3]);