theta = linspace(-pi,pi,361);

figure
for n = linspace(-1,1,11)
    p = HenyeyGreenstein(n,theta);
    p = p ./max(abs(p));
    polarplot(theta,p);
    hold on
end

%%
figure
for n = linspace(0,1,11)
    p = HenyeyGreenstein(n,theta);
    p = p - min(p);
    p = p ./max(abs(p));
    plot(theta,p);
    hold on
end


%%
figure
x = rand(1,100000)*pi;
xdata = linspace(0,pi*2,100);
for n = 0.1:0.3:0.7
%     xin = HenyeyGreenstein(n,x);
%     xr = Rand_HenyeyGreenstein(n,xin);
    xr = Rand_HenyeyGreenstein(n,x);
    xr = abs(xr);
    h = hist(xr./max(xr),xdata);
%     [h,xdata] = hist(abs(xr),1000);
%     plot(xdata,h)
    polarplot(xdata,h/max(h))
    hold on
    drawnow
end


%%
figure
bin = 100000;
xdata = linspace(0,pi,100);
for n = 0.1:0.2:0.9
    xr = Rand_HenyeyGreensteinRev(n,bin);
    h = hist(xr,xdata);
%     [h,xdata] = hist(abs(xr),1000);
%     plot(xdata,h)
    polarplot(xdata,h./max(h))
    hold on
    drawnow
end



%%
figure
bin = 100000;
xdata = linspace(0,pi,100);
for n = 0.1:0.2:0.9
    xr = Rand_HenyeyGreenstein(n,bin);
    max(xr)
    h = hist(xr,xdata);
%     [h,xdata] = hist(abs(xr),1000);
%     plot(xdata,h)
    polarplot(xdata,h./max(h))
    hold on
    drawnow
end
%%
mu1 = [1 2];
Sigma1 = [2 0; 0 0.5];
mu2 = [-3 -5];
Sigma2 = [1 0;0 1];
rng(1); % For reproducibility
X = [mvnrnd(mu1,Sigma1,1000); mvnrnd(mu2,Sigma2,1000)];
GMModel = fitgmdist(X,2);
figure
y = [zeros(1000,1);ones(1000,1)];
h = gscatter(X(:,1),X(:,2),y);
hold on
gmPDF = @(x1,x2)reshape(pdf(GMModel,[x1(:) x2(:)]),size(x1));
g = gca;
fcontour(gmPDF,[g.XLim g.YLim])
title('{\bf Scatter Plot and Fitted Gaussian Mixture Contours}')
legend(h,'Model 0','Model1')
hold off


p = HenyeyGreenstein(0.6,theta)';
GMModel = fitgmdist(p,1);
figure,
















