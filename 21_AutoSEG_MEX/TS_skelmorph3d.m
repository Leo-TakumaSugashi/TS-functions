function [A,BP,oldestBP,EndP] = TS_skelmorph3d(bw)
%% View Check
if ~islogical(bw)
    error('Input is not logical')
end

%% Main func.        
EndP = TS_skel2endpoint(bw);
se1 = ones(3,3,3);
BPf1 = imfilter(uint8(bw),se1).*uint8(bw);
oldestBP = BPf1>3;
BP = false(size(BPf1));
while max(BPf1(:))>3
    BP = or(BP,BPf1 == max(BPf1(:)));
    % %nearest 26 point ---> false
    bw(imdilate(BP,se1)) = false; 
    BPf1 = imfilter(uint8(bw),ones(3,3,3)).*uint8(bw);
end        
% LBP = uint32(bwlabeln(BP,26));
LBP = TS_bwlabeln3D26(BP);
% s = regionprops3(LBP,'Centroid');
s = TS_Label2Centroid(LBP);
outputBP = false(size(BP));
% % Nearest to Centroid Point
for n = 1:size(s,1)
    [y,x,z] = ind2sub(size(BP),find(LBP(:)==n));    
    if length(y)==1
        outputBP(y,x,z) = true;
        continue
    else
%         p = s(n).Centroid;
        p = s(n,:);
        p = padarray(p,[length(y)-1 0],'symmetric','pre');
        if size(p,2) == 2 %% if input is 2D
            p = padarray(p,[0 1],1,'post');
        end
        xyz = cat(2,x,y,z);
        length_xyz = sqrt(sum((xyz - p).^2,2));
        [~,Ind] = min(length_xyz);
        outputBP(y(Ind(1)),x(Ind(1)),z(Ind(1))) = true;        
    end    
end        
A = outputBP;
end
