function A = TS_skel2endpoint(bw)

A = false(size(bw));
for n = 1:6
    se = CreateSE(n);
    fbw = imfilter(uint8(bw),se);            
    A = or(A,and(fbw==1,bw));
end
[y,x,z] = ind2sub(size(bw),find(A(:)));
cropbw = padarray(bw,[1 1 1],0);
for n = 1:length(y)
    ROI = cropbw(y(n):y(n)+2,x(n):x(n)+2,z(n):z(n)+2);
    ROI(2,2,2) = false;
    [~,NUM] = TS_bwlabeln3D26(ROI);
%     s = bwconncomp(ROI,26);
%     NUM = s.NumObjects;
    if NUM>1
        A(y(n),x(n),z(n)) = false;
    end
end
end

%% for End point
function se = CreateSE(num)
se = ones(3,3,3);
switch num
    case 1
        se(:,3,:) = 0;% Left Plane
    case 2
        se(:,1,:) = 0;% Right Plane
    case 3
        se(3,:,:) = 0;% Top Plane
    case 4
        se(1,:,:) = 0;% Bottom Plane
    case 5
        se(:,:,3) = 0;% Surface Plane
    case 6
        se(:,:,1) = 0;% Deep Plane
end
end