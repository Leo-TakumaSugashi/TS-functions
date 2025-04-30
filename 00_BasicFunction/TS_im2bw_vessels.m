function bw = TS_im2bw_vessels(Image,Reso,type)
% help ...
%     edit 2017 4 30 ,
%     フォトカウント画像の血管二値化用

if islogical(Image)
    bw = Image;
    return
end
if ndims(Image)~=3
    error('input dimmension is NOT Correct')
end
siz = size(Image);
switch lower(type)
    case {'photocount','sp8'}
        obj_siz = [3 3 7];
        window_siz = 100;
        fov = (siz(1:2)-1) .*Reso(1:2);
        block_siz = ceil( fov / window_siz);
        
        fImage = TS_GaussianFilt3D_parfor(Image,Reso,obj_siz);
        
        bw = false(size(fImage));
        parfor n = 1:siz(3)
            bw(:,:,n) = TS_im2bw_block(fImage(:,:,n),block_siz);
        end
    case 'sp5'
        
        
        
    otherwise
        error('input type is not correct')
end
