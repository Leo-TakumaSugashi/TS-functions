function [data,info] = TSLoadMat(FullPath)
matObj = matfile(FullPath);
info = whos(matObj);
data(1:length(info)) = struct('Name',[],'Image',[],'Size',[]);
for n = 1:length(info)
    data(n).Name = info(n).name;    
    data(n).Image = matObj.(info(n).name);
    data(n).Size = info(n).size;
end
end