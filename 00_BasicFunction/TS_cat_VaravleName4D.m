function A = TS_cat_VaravleName4D(loadname,valname,varargin)
%  A = TS_cat_VaravleName4D(loadname,valname,varargin)
% 武田君用4次元データのCat関数
% 例えば，
% 　Traial　１
%  　刺激　　８Hz
%   時間方向に20のデータがある．．．．
%   それぞれ
%   valname_8??となっているので，
%   全て読み込む

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