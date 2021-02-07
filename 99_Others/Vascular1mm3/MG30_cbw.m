save('MG30_cbw.mat','Reso')
%%
for n = 2:4
    load('MG30_AllImage_MeasuredSEG',['Image' num2str(n)])
    eval(['Image = Image' num2str(n) ';'])
    eval(['clear Image' num2str(n)])
    [cbw,NewReso] = TS_2PMImage2BW_v0(Image,Reso);
    eval(['cbw' num2str(n) '=cbw; clear cbw'])
    eval(['NewReso' num2str(n) '=NewReso; clear NewReso'])
    save('MG30_cbw.mat',['cbw' num2str(n)],['NewReso' num2str(n)],'-append')
    n
end