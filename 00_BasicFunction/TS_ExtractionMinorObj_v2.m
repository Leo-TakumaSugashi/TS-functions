function output = TS_ExtractionMinorObj_v2(im,Reso)
%% 細胞の突起検出用
% output = TS_ExtractionMinorObj(im,Reso)　:ouput -->uint8
tic
% Reso = [.198 .198 1.0];
if ~ismatrix(im)
    error('Input is not matrix')
end
im = single(im);
siz = size(im);
OpenType = 'disk';
ResizeCoef = 3;
% ProcessVsCell = 200;
% SignalTh = 0.01;
SDth = 5;
ModeTh = 255;
%% 突起
Obj_siz = [1 1 1]; %% 突起 um
[rim,NewReso] = TS_resize2d(single(im),Reso(1:2),siz*ResizeCoef); %% double
NewReso = [NewReso Reso(3)];
%% gaussian filter
se = fspecial('gaussian',floor(Obj_siz(1)/NewReso(1)/2)*6+1,...
    Obj_siz(1)/NewReso(1)/(2*sqrt(2*log(2))));
% rim = imfilter(rim,se,'symmetric');
% rim = rim / max(rim(:));
% rim = log(rim+SDth*std(rim(:)));
% rim = rim - min(rim(:));
% rim = rim/max(rim(:));
% rim = log(rim+SDth*std(rim(:)));
% rim = rim - min(rim(:));
% rim = rim/max(rim(:)) * 255;

rim = imfilter(rim,se,'symmetric');
rim = rim  * ModeTh;
rim = rim - mode(double(round(rim(:)))); %% -mode
rim = max(rim,0);
rim = rim/max(rim(:));
rim = log(rim+SDth*std(rim(:))); %% 1
rim = rim - min(rim(:));
rim = rim/max(rim(:)) * ModeTh;
rim = rim - mode(double(round(rim(:)))); %% -mode
rim = max(rim,0);
rim = rim/max(rim(:));
rim = log(rim+SDth*std(rim(:))); %% 2
rim = rim - min(rim(:));
rim = rim/max(rim(:)) * ModeTh;
rim = rim - mode(double(round(rim(:)))); %% -mode
rim = max(rim,0);
rim = rim/max(rim(:));
rim = log(rim+SDth*std(rim(:)));  %% 3
rim = rim - min(rim(:));
rim = rim/max(rim(:));

% [BW,fim,afim,oim,aoim] = ...
%     TS_ExtractionObj2Mask(rim,Obj_siz,NewReso,OpenType);
% figure,imagesc(rim),colormap(gray),axis('image'),colorbar,title('rim')
% figure,imagesc(oim),colormap(gray),axis('image'),colorbar,title('oim')
% figure,imagesc(afim),colormap(gray),axis('image'),colorbar,title('afim')
% figure,imagesc(fim),colormap(gray),axis('image'),colorbar,title('fim')
% figure,imagesc(aoim),colormap(gray),axis('image'),colorbar,title('aoim')

aftim = TS_resize2d(rim,NewReso(1:2),siz);
output = TS_AdjImage(aftim);
return
% rim = imfilter(rim,fspecial('gaussian',7,1.8),'symmetric');
% figure,imagesc(rim),colormap(gray),axis image
% title('Resize x5')
% [BW,fim,afim,oim,aoim] = ...
%     TS_ExtractionObj2Mask(rim,Obj_siz,NewReso,OpenType);

%% Cell
ObjCell_siz = [4 4 1]; %% Cell size
[bw,~,~,~,~] = ...
    TS_ExtractionObj2Mask(aoim,ObjCell_siz,NewReso,OpenType);
NoneCell = aoim - uint8(bw)*255;
AdjNoneCell = TS_AdjImage(NoneCell); %% uint8
% figure,imagesc(AdjNoneCell),colormap(gray),axis('image'),colorbar
% figure,imagesc(fim .*single(bw)),colormap(gray),axis('image'),colorbar
% drawnow
Celhist = single(fim(bw));
Celhist = max(Celhist-median(Celhist),0);
Celhist=  Celhist / max(Celhist) * ProcessVsCell ;
% Celhist = log(Celhist+exp(1)) * ProcessVsCell;
% figure,hist(Celhist,100);
% Celhist = (Celhist/mean(Celhist) * ProcessVsCell ) + single(max(NoneCell(:)));
SignalProcess = sort(AdjNoneCell(AdjNoneCell>0));
SignalProcess = mean(SignalProcess(end-uint32(length(SignalProcess)*SignalTh):end));
% Celhist = (Celhist/max(Celhist) ) + single(SignalProcess);

%% Log Image
% Signal = single(mean(fim(BW)));
% test = log(single(fim)./Signal+1);
test = log(single(fim)./single(SignalProcess)+1);
figure,imagesc(test);
figure,imagesc(fim);


Celhist = Celhist + single(SignalProcess);

% figure,plot(Celhist);
% figure,plot(AdjNoneCell(AdjNoneCell>0))
% output = single(NoneCell);
output = single(AdjNoneCell);
output(bw) = Celhist;
% figure,imagesc(output),colormap(gray),axis('image'),colorbar
% drawnow

% MinCell = single(min(Cell(Cell>0)));
% Cell = single(Cell) + MinCell;

% figure,imagesc(AdjNoneCell),colormap(gray),axis('image'),colorbar
% xAdjNoneCell = AdjNoneCell;
% AdjNoneCell(bw) = aoim(bw); %% Return Objecto of Cell

% figure,imagesc(frim),colormap(gray),axis('image'),colorbar
% figure,imagesc(oim),colormap(gray),axis('image'),colorbar
% figure,imagesc(aoim),colormap(gray),axis('image'),colorbar
% [aftim,NNReso] = TS_resize2d(AdjNoneCell,NewReso(1:2),siz);
[aftim,NNReso] = TS_resize2d(output,NewReso(1:2),siz);
output = TS_AdjImage(aftim);

% figure,imagesc(aftim),colormap(gray),axis('image'),colorbar
% NNReso = [NNReso NewReso(3)]; %% NNReso == Reso
toc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
return
% [aftim,NNReso] = TS_resize2d(aoim,NewReso(1:2),siz);
% NNReso = [NNReso NewReso(3)]; %% NNReso == Reso
% 
% aftim8 = uint8(aftim);
% clear bw frim adifrim oim aoim atfim
% %% Cell
% ObjCell_siz = [4 4 1]; %% Cell size
% [bw,frim,adjfrim,oim,aoim] = ...
%     TS_ExtractionObj2Mask(aftim8,ObjCell_siz,NNReso,OpenType);
% figure,imagesc(bw),colormap(gray),axis('image'),colorbar
% figure,imagesc(frim),colormap(gray),axis('image'),colorbar
% figure,imagesc(oim),colormap(gray),axis('image'),colorbar
% figure,imagesc(aoim),colormap(gray),axis('image'),colorbar
% figure,imagesc(aftim8),colormap(gray),axis('image'),colorbar
% NoneCell = aftim8 - uint8(bw)*255;
% % NoneCell = aftim8 - aoim;
% AdjNoneCell = TS_AdjImage(NoneCell);
% figure,imagesc(AdjNoneCell),colormap(gray),axis('image'),colorbar
% xAdjNoneCell = AdjNoneCell;
% xAdjNoneCell(bw) = aftim8(bw);
% figure,imagesc(xAdjNoneCell),colormap(gray),axis('image'),colorbar