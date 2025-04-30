function im = JM_oif2matAuto_v2019Alpha(foldername,varargin)
% foldername = '~~~~~~~~.oif.files'; charŒ^
% If ROI class Image (ex. C001T025-ROIXX.tif), 
%  will be skip with warning

ChCatMode = true;
if(nargin>1)
    if(strcmp(varargin{1},'ChRev'))% im = HY_oif2matAuto_v3(foldername,'ChRev') ‚É‚·‚ê‚Îch1‚Æch2‚Ì‡”Ô‚ª•Ï‚í‚éiFV1200‚Å‚Ích1‚ª—ÎF‚Ì‚½‚ßj
        ChCatMode = false;
    end
end

if(length(foldername)>length('.oif.files'))
    A = strcmp(foldername(end-length('.oif.files')+1:end),'.oif.files');
    if(A~=true)
        foldername = [foldername,'.oif.files'];
    end
else 
    foldername = [foldername,'.oif.files'];
end

if(isdir(foldername))
    cd(foldername)
    List1 = dir;
    c1 = 1;
    for n1 = 1:length(List1)
        name1 = List1(n1).name;
        SearchWord1 = '.tif';
        if(length(name1)>length(SearchWord1))
            if(strcmp(name1(end-length('.tif')+1:end),'.tif'))
                TifList(c1).name = name1;
                c1 = c1+1;
            end
        end
    end
    
    Cmax = [];
    Zmax = [];
    Tmax = [];
    for n2 = 1:length(TifList)
        name2 = TifList(n2).name;
        Cpos = regexp(name2,'C');
        Zpos = regexp(name2,'Z');
        Tpos = regexp(name2,'T');
        Endpos = regexp(name2,'.tif');
        
        pos1 = [sum(Cpos),sum(Zpos),sum(Tpos),sum(Endpos)];
        posel = pos1>0;
        pos2 = pos1./posel;
        
        Cnumleng = abs(Cpos-min(pos2(2:end)))-1;
        Znumleng = abs(Zpos-min(pos2(3:end)))-1;
        Tnumleng = abs(Tpos-Endpos)-1;
        
        C1 = str2num(name2(Cpos+1:Cpos+Cnumleng));
        Z1 = str2num(name2(Zpos+1:Zpos+Znumleng));
        T1 = str2num(name2(Tpos+1:Tpos+Tnumleng));
        
        Cmax = max([Cmax,C1]);
        Zmax = max([Zmax,Z1]);
        Tmax = max([Tmax,T1]);
    end
    Pattern = imcomplement(isempty(Cmax)).*1 + imcomplement(isempty(Zmax)).*2 + imcomplement(isempty(Tmax)).*4;
    
    im = [];
    switch Pattern
        case 1 %s_C~~~.tif
            if(ChCatMode)
                for cn = 1:Cmax
                    CatTifname = ['s_C',HY_charnum1(cn,Cnumleng),'.tif'];
                    im1 = imread(CatTifname);
                    im = cat(5,im,im1);
                end
            else
                for cn = Cmax:-1:1
                    CatTifname = ['s_C',HY_charnum1(cn,Cnumleng),'.tif'];
                    im1 = imread(CatTifname);
                    im = cat(5,im,im1);
                end
            end
            
        case 2 %s_Z~~~.tif
            for zn = 1:Zmax
                CatTifname = ['s_Z',HY_charnum1(zn,Znumleng),'.tif'];
                im1 = imread(CatTifname);
                im = cat(3,im,im1);
            end
            
        case 3 %s_C~~~Z~~~.tif
            if(ChCatMode)
                for cn = 1:Cmax
                    imz = [];
                    for zn = 1:Zmax
                        CatTifname = ['s_C',HY_charnum1(cn,Cnumleng),'Z',HY_charnum1(zn,Znumleng),'.tif'];
                        im1 = imread(CatTifname);
                        imz = cat(3,imz,im1);
                    end
                    im = cat(5,im,imz);
                end
            else
                for cn = Cmax:-1:1
                    imz = [];
                    for zn = 1:Zmax
                        CatTifname = ['s_C',HY_charnum1(cn,Cnumleng),'Z',HY_charnum1(zn,Znumleng),'.tif'];
                        im1 = imread(CatTifname);
                        imz = cat(3,imz,im1);
                    end
                    im = cat(5,im,imz);
                end
            end
            
        case 4 %s_T~~~.tif
            for n = 1:Tmax
                CatTifname = ['s_T',HY_charnum1(n,Tnumleng),'.tif'];
                im1 = imread(CatTifname);
                im = cat(4,im,im1);
            end
            
        case 5 %s_C~~~T~~~.tif
            try
            if(ChCatMode)
                for cn = 1:Cmax
                    imt = [];                    
                    for tn = 1:Tmax
                        CatTifname = ['s_C',HY_charnum1(cn,Cnumleng),'T',HY_charnum1(tn,Tnumleng),'.tif'];                        
                        im1 = imread(CatTifname);
                        imt = cat(4,imt,im1);
                    end
                    im = cat(5,im,imt);
                end
            else
                for cn = Cmax:-1:1
                    imt = [];
                    for tn = 1:Tmax
                        CatTifname = ['s_C',HY_charnum1(cn,Cnumleng),'T',HY_charnum1(tn,Tnumleng),'.tif'];
                        im1 = imread(CatTifname);
                        imt = cat(4,imt,im1);
                    end
                    im = cat(5,im,imt);
                end
            end

            catch err
                warning(err.message)
                Finding_SPname = dir('*.tif');
                tn = 1;
                im1 = imread(Finding_SPname(tn).name);
                imt = zeros([size(im1),1,length(Finding_SPname)],'like',im1(1));
                imt(:,:,1,1) = im1;
                for tn = 2:length(Finding_SPname)
                    if ~isempty(find(Finding_SPname(tn).name == '-'))
                        warning([Finding_SPname(tn).name ' is skip....'])
                        continue
                    end
                    im1 = imread(Finding_SPname(tn).name);
                    imt(:,:,1,tn) = im1;
                end
                siz = size(imt);
                im = reshape(imt,siz(1),siz(2),siz(3),[],Cmax);
                if ~ChCatMode
                    im = flip(im,5);
                end
            end
        case 6 %s_Z~~~T~~~.tif
            for zn = 1:Zmax
                imt = [];
                for tn = 1:Tmax
                    CatTifname = ['s_Z',HY_charnum1(zn,Znumleng),'T',HY_charnum1(tn,Tnumleng),'.tif'];
                    im1 = imread(CatTifname);
                    imt = cat(4,imt,im1);
                end
                im = cat(3,im,imt);
            end
            
        case 7 %s_C~~~Z~~~T~~~.tif
            if(ChCatMode)
                for cn = 1:Cmax
                    imzt = [];
                    for zn = 1:Zmax
                        imt = [];
                        for tn = 1:Tmax
                            CatTifname = ['s_C',HY_charnum1(cn,Cnumleng),'Z',HY_charnum1(zn,Znumleng),'T',HY_charnum1(tn,Tnumleng),'.tif'];
                            im1 = imread(CatTifname);
                            imt = cat(4,imt,im1);
                        end
                        imzt = cat(3,imzt,imt);
                    end
                    im = cat(5,im,imzt);
                end
            else
                for cn = Cmax:-1:1
                    imzt = [];
                    for zn = 1:Zmax
                        imt = [];
                        for tn = 1:Tmax
                            CatTifname = ['s_C',HY_charnum1(cn,Cnumleng),'Z',HY_charnum1(zn,Znumleng),'T',HY_charnum1(tn,Tnumleng),'.tif'];
                            im1 = imread(CatTifname);
                            imt = cat(4,imt,im1);
                        end
                        imzt = cat(3,imzt,imt);
                    end
                    im = cat(5,im,imzt);
                end
            end
            
        otherwise
            error('Can''t find XY~~~ mode')
    end
    cd ..
    
end
end


