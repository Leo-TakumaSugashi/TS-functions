function BW = TS_microglia_extraction_proto(GImage,Reso)
% BW = TS_microglia_extraction_proto(GImage,Reso)
% GImage ; Glia Image,,
% Reso  * Resolution 
% BW : output


siz = size(GImage);

% % opening
[RImage,NewReso] = TS_EqualReso3d_parfor(GImage,Reso,1);
    % % making kernel
se = TS_strel([4 4 4],NewReso,'ball');
og = imopen(RImage,se);
og = TS_imresize3d(og,siz);

% % Binarization
bw = og > mode(round(og(:)));

% % Histgram of Volume [a.u.] because Not Equral Resolution
% % finding bw area opne threshold
NUM_Soma_percent = 200^3 / 100; %% 200 um^3 ‚É–ñ‚P‚O‚O•C‚¢‚é‚±‚Æ‚ð‰ß’ö
Bin = 256;
s = regionprops(bwlabeln(bw),'Centroid','Area');
Area = cat(1,s.Area);
[h,x] = hist(Area,Bin);
figure,bar(x,h,'hist')
xlabel('Voluem [a.u.]')
ylabel('Frequecy [count]')
hold on
cum_sum = flip(cumsum(flip(h)));
plot(x,cum_sum)
FOV = (siz(1:3)-1) .* Reso(1:3);
Volume = prod(FOV);
fp = cum_sum > (Volume / NUM_Soma_percent);
fp = find(fp);
fp = fp(end) + 1;

Threshold = x(fp);

% % Area open (Size, Volume Filter)
bw_areaopen = bwareaopen(bw,round(Threshold));

% % Centroid
L = bwlabeln(bw_areaopen);
s = regionprops(L,'Centroid','Area');
xyz = cat(1,s.Centroid);
Area = cat(1,s.Area);

% % Length MAP
Len_map = TS_EachLengthMap(xyz,Reso);

% % finding Deletabel Indxe form Minimum Distance and Area
 Delete_Idx = TS_DeletabelIndx_from_LenMap(Len_map,Area);
 
%% Extraction
for n = 1:length(Delete_Idx)
    L(L==Delete_Idx(n)) = 0;
end
BW = L > 0;

