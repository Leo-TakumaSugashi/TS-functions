function A = TS_CatDepth(im1,im2,sl1,sl2,type)
%% 1mm3 �쐬�p�@Func�A
% Input 1,2�́@�[���Ƃ��̎��ɕ\�ʂɋ߂��f�[�^�A
% Input 3,4�͏d�Ȃ�̃X���C�X
% Input 5�́@type


sh = TS_SliceReposition(im1(:,:,sl1),im2(:,:,sl2));
[im1,~] = TS_Shift2pad_vEachSlice(im1,im1,repmat(sh,[size(im1,3) 1]));
[~,im2] = TS_Shift2pad_vEachSlice(im2,im2,repmat(sh,[size(im2,3) 1]));

 
switch lower(type)
    case {'cat','normal'}
       
        A = cat(3,...
            im1(:,:,1:sl1,:,:),...
            im2(:,:,sl2+1:end,:,:));
    case 'mean'
        Margin = cat(7,...
            im1(:,:,sl1,:,:),...
            im2(:,:,sl2,:,:));
        Margin = nanmean(Margin,7);
        Margin = feval(class(im1),Margin);
        A = cat(3,...
            im1(:,:,1:sl1-1,:,:),...
            Margin,...
            im2(:,:,sl2+1:end,:,:));
    otherwise
        error('input type is no order')
end