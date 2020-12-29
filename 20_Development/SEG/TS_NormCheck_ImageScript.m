X = zeros(100,100);
Sf = Segment_Functions;
for n = -49:50
    for k = -49:50
        X(k+50,n+50) = Sf.UnitVector2Theta([1 0 0],[n k 0])*sign(k);
    end
end
figure,imagesc(X*180/pi,'XData',-49:50,'YData',-49:50)