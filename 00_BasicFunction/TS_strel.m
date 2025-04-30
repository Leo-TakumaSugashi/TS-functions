function [okse,Zkernelsize] = TS_strel(ObjSize,Reso,type,varargin)
% se = TS_strel(ObjSize,Reso,type)
% 
% Reso(1) = mean(Reso(1:2)); % unit ,um/pix.
% ObjSize(1) = mean(ObjSize(1:2)); %% unit um
% switch type
%     case 'disk'
%         okse = strel('disk',round(ObjSize(1)/Reso(1)/2 ),0);
%     case 'ball'
%         okse = strel('ball',round(ObjSize(1)/Reso(1)/2),...
%             floor(ObjSize(3)/Reso(3)/2 ),0 );
%     case 'cylinder'
%         pre_R = round(ObjSize(1)/Reso(1)/2);
%         pre_se = false(pre_R * 2 + 1);
%         pre_se(pre_R+1,pre_R+1) = true;
%         pre_se = bwdist(pre_se) <= pre_R;
%         okse = repmat(pre_se,1,1,round(ObjSize(3)/Reso(3)/2)*2+1);
%     otherwise
%         error('This type is Not Correct')
% end
% 
% edit loging,
%  edit type ball,,, 2017 05 20
%   if nargin  == 4, input is 'logical',
%       cheange strel type to logical data
%
%   Add, Zkernelsize for GPU Processing... Sugashi, by 2019,07,08

Reso(1) = mean(Reso(1:2));
ObjSize(1) = mean(ObjSize(1:2));
Zkernelsize = 1;
switch type
    case 'disk'
        okse = strel('disk',round(ObjSize(1)/Reso(1)/2 ),0);
    case 'ball'
        okse = strel('ball',round(ObjSize(1)/Reso(1)/2),...
            round(ObjSize(3)/Reso(3)/2 ),0 );
        Zkernelsize = round(ObjSize(3)/Reso(3)/2 ) * 2 + 1;
        if nargin == 4
            if strcmpi(varargin{1},'logical')
                siz = round(ObjSize ./ Reso );
                siz = siz + double(floor(siz/2) == ceil(siz/2));
                c = ceil(siz / 2);
                okse = false(siz);
                okse(c(2),c(1),c(3)) = true;
                okse = TS_bwdist_Reso(okse,Reso);
                okse = okse <= ObjSize(1)/2;
            end
            Zkernelsize = size(okse,3);
        end
    case 'cylinder'
        pre_R = round(ObjSize(1)/Reso(1)/2);
        pre_se = false(pre_R * 2 + 1);
        pre_se(pre_R+1,pre_R+1) = true;
        pre_se = bwdist(pre_se) <= pre_R;
        okse = repmat(pre_se,1,1,round(ObjSize(3)/Reso(3)/2)*2+1);
        Zkernelsize = size(okse,3);
    otherwise
        error('This type is Not Correct')
end
