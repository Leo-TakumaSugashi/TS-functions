function I_0=ILT(mua,mus,g,r,N) 
%Hello!...

%N:   order of approximation 
%mua: absorption coefficient
%mus: scattering coefficient
%g :  anisotropic factor
%r:   distance to the isotropic source
%**************************************************************************

c = 2.99792458/1.4*1e11;                      %speed of light
D_k = 1/(3*(mus+mua*1));                      %diffusion coefficient  
R_s = 50;                                     %radius of the sphere
l=0:N;
sigma(l+1) = (1-g.^l).*mus./(1-g);            %Henyey-Greenstein function
sigma(1) = 0;
k_end = 400;                                  %number of dircrete wave numbers
t_end = 120*1e-11;                            %time in seconds
dt = 0.5*1e-12;
n_end = round(t_end/dt);                      %number time values

eig_k=zeros(N+1,k_end);
Res=zeros(N+1,k_end);

for k=1:k_end
    ek = k*pi/R_s;
    A = diag(1i*ek*(1:N)./sqrt((1:2:2*N-1).*(3:2:2*N+1)),+1) + diag(sigma(1:N+1)) + diag(1i*ek*(1:N)./sqrt((1:2:2*N-1).*(3:2:2*N+1)),-1);
    [V,D] = eig(A);                             %eigenvalue decomposition
    b = V\eye(N+1,1);                           %first column vector of the inverse matrix to U
    eig_k(1:N+1,k) = diag(D);
    Res(1:N+1,k) = k.*sin(r*ek)*V(1,1:N+1).*transpose(b(1:N+1));        %Eq. 25 of the manusript
   
end

t =zeros(1,n_end);
I_0 =zeros(1,n_end);
G_DE=zeros(1,n_end);

for u = 1:n_end
    t(u) = -0.25e-12 + u*dt;
    e_Matrix = exp(-eig_k*c*t(u));
    I_help = Res.*e_Matrix;
    I_0(u) = 1e-9*c/(2*r*R_s^2)*real(sum(I_help(:))).*exp(-mua*c*t(u)).* ...
        heaviside(t(u)-r/c+1*dt);   
    G_DE(u) = 1e-9*c*(1-(r./c./t(u)).^2).^0.125./(4*pi*c.*t(u)/3./mus).^ ...
        1.5.*exp(-(mua+mus).*c.*t(u)).*exp(mus.*c.*t(u).* ...
        (1-(r./c./t(u)).^2).^0.75).*sqrt(1+2.026./...
        (mus.*c.*t(u).*(1-(r./c./t(u)).^2).^0.75)).*heaviside(t(u)-r/c-1*dt);
end
% catch err
%     keyboard
% end
semilogy(1e9*t,I_0*1e-3,'r');
end

% function output = Heaviside(g,theta)
% output = 1/4*pi * (1-g^2)./((1+g^2-2*g*cos(theta).^3./2));
% end