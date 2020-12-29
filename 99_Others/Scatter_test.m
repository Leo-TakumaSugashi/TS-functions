theta = linspace(0,2*pi,181);

figure
for n = linspace(-1,1,11)
    p = HenyeyGreenstein(n,theta);
    p = p ./max(abs(p));
    polarplot(theta,p);
    hold on
end


figure
for n = linspace(-1,1,11)
    p = HenyeyGreenstein(n,theta);
    p = p ./max(abs(p));
    plot(theta,p);
    hold on
end


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
















