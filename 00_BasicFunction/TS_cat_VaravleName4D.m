function A = TS_cat_VaravleName4D(loadname,valname,varargin)
%  A = TS_cat_VaravleName4D(loadname,valname,varargin)
% ���c�N�p4�����f�[�^��Cat�֐�
% �Ⴆ�΁C
% �@Traial�@�P
%  �@�h���@�@�WHz
%   ���ԕ�����20�̃f�[�^������D�D�D�D
%   ���ꂼ��
%   valname_8??�ƂȂ��Ă���̂ŁC
%   �S�ēǂݍ���

Maxnum = 20;
if nargin==3
    Maxnum = varargin{1};
end

load(loadname)

n = 1;
data = eval([valname num2str(n)]);
siz = size(data);
siz(4) = Maxnum;
data = zeros(siz,'like',data(1));
for n = 1:Maxnum
    data(:,:,:,n) = eval([valname num2str(n)]);    
end
A = data;
return