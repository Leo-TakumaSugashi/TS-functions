function FULLPATH = TS_GetPath
a= mfilename('fullpath');
p = find(a==filesep);
FULLPATH = a(1:p(end-1));