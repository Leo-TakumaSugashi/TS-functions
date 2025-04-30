function Image = TS_LoadMRD_v2(str,varargin)

fp = fopen(str);
Ind = fread(fp);
if max(Ind(:)) < 2^8
    Ind = uint8(Ind);
end

% Ind2  = Ind(242:2:end);
Ind2 = Ind(246:2:end);

cx = 152*113:152*113:length(Ind2);
    cx(end) = [];
Ind2([cx+1 cx+2]) = [];

cut_end = floor(length(Ind2) / (152*113));
Ind2(cut_end*(152*113)+1:end) = [];
Image = reshape(Ind2,152,113,[]);
TS_3dslider(flip(Image,3))



% cx(end) = [];
% Ind3 = Ind2;
% Ind3([cx cx+1]) = [];
% 
% Image = reshape(Ind3,760,568,[]);

Image = permute(Image,[2 1 4 3]);
Image = flip(Image,1);