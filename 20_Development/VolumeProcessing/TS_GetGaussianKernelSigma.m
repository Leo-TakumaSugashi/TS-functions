function sigma_array = TS_GetGaussianKernelSigma(Reso, ObjSize)
GaussFil_sigma_coef = 1;
sigma_array = [ObjSize(2)/Reso(2)/(2*sqrt(2*log(2)))*GaussFil_sigma_coef ...
    ObjSize(1)/Reso(1)/(2*sqrt(2*log(2)))*GaussFil_sigma_coef ...
    ObjSize(3)/Reso(3)/(2*sqrt(2*log(2)))*GaussFil_sigma_coef];