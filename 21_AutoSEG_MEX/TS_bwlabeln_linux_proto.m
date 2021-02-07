classdef TS_bwlabeln_linux_proto
    properties
        BW 
        Label
        NUM= uint32(1)
        yxz(1,3)
    end
    methods
        function [L,Num] = TS_bwlabeln_linux_c(obj,bw)            
            bw = padarray(bw,[1 1 1],false);
            obj.BW = bw;
            L = zeros(size(bw),'like',uint32(1));
            obj.Label = L;
            siz = ones(1,3);
            for n = 1:3
                siz(n) =size(bw,n);
            end
            [y,x,z] = ind2sub(siz,find(bw(:),true,'first'));
            while ~isempty(y)
                preNum = obj.NUM;
                obj.yxz = [y,x,z];
                obj = obj.Labeling();
                L = obj.Label;
                bw = obj.BW;
                if preNum == obj.NUM
                    obj.NUM = obj.NUM + 1;
                end
                [y,x,z] = ind2sub(siz,find(bw(:),true,'first'));
            end
            L = L(2:end-1,2:end-1,2:end-1);
            Num = obj.NUM-1;
        end
        function obj = Labeling(obj)
            y = obj.yxz(1);
            x = obj.yxz(2);
            z = obj.yxz(3);
            bw = obj.BW;
            L = obj.Label;
            Num = obj.NUM;
            ROI_bw = bw(y-1:y+1,x-1:x+1,z-1:z+1);
            ROI_L = L(y-1:y+1,x-1:x+1,z-1:z+1);
            ROI_L(ROI_bw) = Num; 
            L(y-1:y+1,x-1:x+1,z-1:z+1) = ROI_L;
%             disp(L(2:end-1,2:end-1,2));
%             pause(1)
            bw(y,x,z) = false;
            obj.Label = L;
            obj.BW = bw;
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
                    obj.yxz = [y1(k),x1(k),z1(k)];
                    obj = obj.Labeling();
                end
            else
                disp(Num)
                Num = Num + 1;
                obj.NUM = Num;                
            end        
        end
    end
end