function TS_addpath(name)
% TS_addpath(name)
% �f�B���N�g��name��
% ���̓����̃t�H���_�[�i�����K�w���ׂāj��addpath
%    Edition 2016 July 20th by Sugashi

DIR = dir(name);
addpath(name)
%% �t�H���_�[���ɉ����Ȃ�������Ԃ�
if length(DIR)<3
    return
end

%% �t�H���_�[�̎Q�Ƃ�addpath�̌J��Ԃ�
for n = 3:length(DIR)
    if DIR(n).isdir
        Nowcd = cd;
        Name = [name '\' DIR(n).name];
        addpath(Name)
        disp(Name)
        cd(Name)
        TS_addpath(Name)
        cd(Nowcd)
    end
end

