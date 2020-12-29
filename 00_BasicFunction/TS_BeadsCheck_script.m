n = 3
data(n).Name 
load(data(n).Name)
Reso = 10^6 * abs(data(n).FOV(1:3) ./ (data(n).Size(1:3)-1))
siz = size(data(n).Image)

%% save 
save([data(n).Name '_edit.mat'],'Cropdata','-append')
 
%%
Result = TS_BeadsAnalysis(Cropdata,'fImage',[],1)

%% check threshold
Result = TS_BeadsAnalysis(Cropdata,'fImage',1.1)

%% save figrue
for n = 9-7:9
name = get(n,'Name');
name(name==' ') = '_';
saveas(n,[name '_Fig.fig'])
end

%% depth
xyz = cat(1,Cropdata.centroidXYZ);
xyz = (1756 - ( xyz(:,3) -1 )) * Reso(3);
idx = find(xyz > 610);



%% signal
xyz = cat(1,Result.Signal);
idx = find(xyz < 10);

%% fwhm
xyz = cat(1,Result.FWHM_X);
idx = find(xyz > 1.5);

%% manual
idx = [24 1 15 18 77 273 271]
idx = sort(idx);


%% check
ID = false(size(idx));
for n = 1:length(idx)
figure,
subplot(1,2,1)
imagesc(squeeze(max(Cropdata(idx(n)).fImage,[],3)))

subplot(1,2,2)
imagesc(squeeze(max(Cropdata(idx(n)).fImage,[],2)))
title(num2str(idx(n)))

c = input('T OR F ; ');
if isempty(c), c = true;end
ID(n) = c;
close(gcf)
end
idx = idx(ID);clear ID

%%
Cropdata(idx) = [];clear idx xyz