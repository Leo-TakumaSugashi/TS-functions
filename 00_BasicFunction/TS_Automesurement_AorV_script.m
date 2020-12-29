

load('K73D00S03Loc1_ResizData.mat', 'RmfImage')
load('K73D00S03Loc1_PenetoData.mat', 'Penetdata'


TS_3dslider(cat(5,TS_Image2uint8(RmfImage),uint8(Penetdata.Reconstruct)*255))


%% Resized Surface ind. 
RSind = 531; % * this index needs including Penetrating Vessels.

%%@Žè•ª‚¯
[L,NUM] = bwlabeln(Penetdata.Reconstruct);

SLIND = L(:,:,RSind:end);
[h,x] = hist(SLIND(SLIND>0),1:NUM);
SLIND = x(h>0); clear h x 

%% choice A or V ,,,,
Label = struct('label',[],'A_or_V',[])
for n = 1:length(SLIND)
    choice_bw = L == SLIND(n);
    fgh = TS_3dslider(...
        cat(5,TS_Image2uint8(RmfImage),uint8(choice_bw)*255));
    inputstr = input('Aartery or Vein ; ');
    close(fgh)
    Label(n).label = SLIND(n);
    Label(n).A_or_V = inputstr;  
    
end

%% 
PA = false(size(RmfImage));
PV = PA;
NN = PA;
for n = 1:length(Label)
    ln = Label(n).label;
    if strcmpi(Label(n).A_or_V,'Artery')
        PA = or(PA,L == ln);
    elseif strcmpi(Label(n).A_or_V,'Vein')
        PV = or(PV,L == ln);
    else
        NN = or(NN,L == ln);
    end
end

%%
load('NewSEGandDiamImage.mat', 'NewDiamImage', 'PDiamImage')
Diam = max(cat(4,NewDiamImage,PDiamImage),[],4);
 R = TS_Diam2ReconstBW(Diam,1);

 [A1,A2] = TS_ErosionImage(or(PA,PV),R);

save 20170609_Temp.mat  -v7.3

%%
Da = TS_Label2choice(A2,A2(PA));
Dv = TS_Label2choice(A2,A2(PV));


TS_3dslider(A1 .* Da)
colormap(TS_Colormap('artery'))
getappdata(gcf,'data')
max(ans(:))
caxis([0 ????])


TS_3dslider(A1 .* Dv)
colormap(TS_Colormap('vein'))
getappdata(gcf,'data')
max(ans(:))
caxis([0 ???])

Mov = Mov_A;
for n = 1:length(Mov)
    Mov(n).cdata = max(cat(4,Mov_A(n).cdata,Mov_V(n).cdata),[],4);
end



