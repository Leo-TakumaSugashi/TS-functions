function s = TS_Label2Centroid(L)
NUM = max(L(:));
s = zeros(NUM,3);
c = zeros(1,3);

for n = 1:NUM
    bw = double(L==n);
    xdata = squeeze(sum( sum(bw,3) , 1) );
    c(1) = vectGra(xdata);
    ydata = squeeze(sum( sum(bw,3) , 2) );
    c(2) = vectGra(ydata);
    zdata = squeeze(sum( sum(bw,2) , 1) );
    c(3) = vectGra(zdata);
    s(n,:) = c;    
end

    function x = vectGra(h)
        num = 1:length(h);
        m = zeros(1,length(h),'like',double(1));
        for k = 1:length(h)
            m(k) = num(k) * h(k);
        end
        x = sum(m)/sum(h);
    end

end