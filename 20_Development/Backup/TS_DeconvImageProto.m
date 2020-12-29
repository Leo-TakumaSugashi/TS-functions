function V = TS_DeconvImageProto(Image,Reso,varargin)

narginchk(3,4)
Type{1} = 'none';
Type{2} = 'none';
V = zeros(size(Image,1),size(Image,2),size(Image,3),size(Image,4),2,...
    'like',single(1));
if nargin >=3
    Type{1} = varargin{1};
    V(:,:,:,:,1) = single(Image(:,:,:,:,1));
end
if nargin >=4
    Type{2} = varargin{2};
    V(:,:,:,:,2) = single(Image(:,:,:,:,2));
end

for n = 1:2    
switch lower(Type{n})
    case {'v','vess','vascular'}
        fV = TS_2PM_VascularFilter_v2019a(V(:,:,:,:,n),Reso);
        fV = fV.fImage;
        vK = TS_GaussianKernel(Reso,[4 4 10]);        
        V(:,:,:,:,n) = TS_Deconv3D_GPU(single(fV),single(vK),5);        
    case {'mg','microglia'}
        fV = TS_MexicanHatFilt(V(:,:,:,:,n),Reso);
%         fV = TS_GaussianFilt3D_GPU(fV,Reso,[1 1 5]);
%         vK = TS_GaussianKernel(Reso,[1 1 10]);
%         V(:,:,:,:,n) = TS_Deconv3D_GPU(single(fV),single(vK));
        V(:,:,:,:,n) = TS_GammaFilt( single(TS_AdjImage(fV)) , .5);
    otherwise
        V(:,:,:,:,n) = Image(:,:,:,:,n);
end
end

