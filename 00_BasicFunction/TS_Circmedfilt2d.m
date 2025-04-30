function output = TS_Circmedfilt2d(Image,Rad)


%% size Image
siz = size(Image);
Class = class(Image);
if ndims(Image) > 2
    output = zeros([siz(1) siz(2) prod(siz(3:end))],'like',feval(Class,1));
    Image = reshape(Image,siz(1),siz(2),[]);
    pcj = gcp('nocreate');
    if isempty(pcj)
        for n = 1:size(Image,3)            
            output(:,:,n) = TS_Circmedfilt2d(Image(:,:,n),Rad);
            TS_WaiteProgress((n-1)/size(Image,3));
        end
        TS_WaiteProgress(1)
    else
        fprintf('  Parfor...  ')
        parfor n = 1:size(Image,3)
            output(:,:,n) = TS_Circmedfilt2d(Image(:,:,n),Rad);
        end
        fprintf('\n ....   Done.\n')
    end
    output = reshape(output,siz);
    return
end


%% Main
se = false(Rad*2+1);
se(Rad+1,Rad+1) = true;
se = bwdist(se) <= Rad;

%% term of bound end
Image = padarray(Image,[Rad+1 Rad+1],'symmetric');
Image(Rad+1,:) = [];
Image(end-Rad,:) = [];
Image(:,Rad+1) = [];
Image(:,end-Rad) = [];

[y,x] = ind2sub(size(se),find(se(:)));
output = zeros([siz(1:2) length(y) siz(3:end)],'like',feval(Class,1));

%% parfor add 
for n = 1:length(y)
    output(:,:,n) = Image(y(n):y(n)+siz(1)-1,x(n):x(n)+siz(2)-1);
end
output = squeeze(median(output,3));


