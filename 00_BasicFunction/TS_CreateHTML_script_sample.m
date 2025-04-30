% Script : TS_CreateHTML_script_sample.m


%% initialize
if false
    Parent = '/mnt/NAS/Share2/Capillaliy_Of_fingertip/kusaka/grayIm/';
else
    Parent = uigetdir;
end

FindDir = dir(Parent );
if ~isempty(FindDir)
    error('Input Dir.. is exsiting')
else
    mkdir(Parent);
end
SaveDir =  ['/mnt/NAS/Share2/Capillaliy_Of_fingertip/'...
    'SpatialPhysicalQuantityJ_20191106/Deconv_TrakingParticle'];

%%
    saveas(fgh,[SaveDir3 filesep 'LeftCurveRight_' N '.jpg'])
%% Output Raw data to html
SEGviewTIFF = dir([SaveDir3 filesep 'LeftCurveRight*.jpg']);
STR = ['<!DOCTYPE HTML> \n'...
    '<HTML>\n',...
    '<head>\n',...
	'    <title> Raw data output : "Kymograph for 42 casies"...</title>\n',...
	'	     <meta http-equiv="Content-Type" content="text/html; charset=utf-8">\n',...
    '</head>\n',...
    '<body>\n\n',...
    '	<p><font size="+5">  Raw data output : "Kymograph for 42 casies"... </font></p>\n'];
STR = [STR '    <font size="+4">\n'];
for n = 1:length(SEGviewTIFF)
    N = num2str(n);
    if length(N)==1
        N = ['0' N];
    end
    Name = SEGviewTIFF(n).name;
    STR = [STR ,...
        '    <br><p><b>' Name '</b>\n',...
        '    <img src="./' Name '" width="800"></img><br></p>\n'];
    
    
    kymTIFF = dir([SaveDir3 filesep 'Mat_' N '*.jpg']); 
    ID = nan(1,length(kymTIFF));
    for k = 1:length(ID)
        p1 = find(kymTIFF(k).name=='_');
        p2 = find(kymTIFF(k).name=='.');
        ID(k) = eval(kymTIFF(k).name(p1(end)+1:p2-1));
    end
    
    ID =TS_GetSameValueSort(ID);
    for k= 1:length(ID)
        f = dir([SaveDir3 filesep 'Mat_' N '*Left*' num2str(ID(k)) '.jpg']);
        if ~isempty(f)
            Name = f(1).name;
            STR = [STR ,...
                '    <br><p>' Name '\n',...
                '        <img src="./' Name '" width="800"></img></p><br>\n'];
        end
        f = dir([SaveDir3 filesep 'Mat_' N '*Curve*' num2str(ID(k)) '.jpg']);
        if ~isempty(f)
            Name = f(1).name;
            STR = [STR ,...
                '    <br><p>' Name '\n',...                
                '        <img src="./' Name '" width="800"></img></p><br>\n'];            
        end
        f = dir([SaveDir3 filesep 'Mat_' N '*Right*' num2str(ID(k)) '.jpg']);
        if ~isempty(f)
            Name = f(1).name;
            STR = [STR ,...
                '    <br><p>' Name '\n',...
                '        <img src="./' Name '" width="800"></img></p><br>\n'];            
        end
    end    
end
STR = [STR '    </font>\n\n<body>\n\n</HTML>'];
fprintf(STR)
%% Write 
fid = fopen([SaveDir3 filesep 'RawDataHTML.html'],'w');
fprintf(fid,STR);
fclose(fid)














