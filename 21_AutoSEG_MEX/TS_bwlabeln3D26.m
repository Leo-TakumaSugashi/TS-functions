function [L,Num] = TS_bwlabeln3D26(bw)

if max(bw(:)) == false
    L = zeros(size(bw),'like',double(1));
    Num = 0;
else
    [L,Num] = TS_bwlabeln_linux_c(bw);
end

end

function [L,Num] = TS_bwlabeln_linux_c(bw)            
    bw = padarray(bw,[1 1 1],false);
    L = zeros(size(bw),'like',double(1));
    siz = ones(1,3);
    for n = 1:3
        siz(n) =size(bw,n);
    end
    [y,x,z] = ind2sub(siz,find(bw(:),true,'first'));
    Num = double(1);
    while ~isempty(y)
        yxz = cat(2,y,x,z);
        preNum = Num;
        [bw,L,Num] = Labeling(yxz,bw,L,Num);
        if preNum == Num
            Num = Num + 1;
        end
        [y,x,z] = ind2sub(siz,find(bw(:),true,'first'));
    end
    L = L(2:end-1,2:end-1,2:end-1);
    Num = Num-1;
end
function [bw,L,Num] = Labeling(yxz,bw,L,Num)
    y = yxz(1);
    x = yxz(2);
    z = yxz(3);
    ROI_bw = bw(y-1:y+1,x-1:x+1,z-1:z+1);
    ROI_L = L(y-1:y+1,x-1:x+1,z-1:z+1);
    ROI_L(ROI_bw) = Num; 
    L(y-1:y+1,x-1:x+1,z-1:z+1) = ROI_L;
    bw(y,x,z) = false;
    ROI_bw(2,2,2) = false;
    TF1 = max(ROI_bw(:)) == true;
    TF2 = max(ROI_L(:)) == Num;
    TF = or(TF1,TF2);
    if TF
        [y1,x1,z1] = ind2sub([3,3,3],find(ROI_bw(:)));
        if isempty(y1)
            return
        end
        y1 = y + y1 -2;
        x1 = x + x1 -2;
        z1 = z + z1 -2;                
        for k = 1:length(y1)
            [bw,L,Num] = Labeling(cat(2,y1(k),x1(k),z1(k)),bw,L,Num);
        end
    else
        disp(Num)
        Num = Num + 1;              
    end  
end