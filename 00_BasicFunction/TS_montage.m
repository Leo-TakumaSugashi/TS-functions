function X = TS_montage(Image,H,Gap,GapColor,varargin)

if size(Image,4) < H
    error('fuck')
end
V = ceil(size(Image,4)/H);
if nargin == 4
    cdata.CLim = repmat([0 255],[size(Image,3),1]);
    cdata.Color = GetColorChannels(size(Image,3));
    cdata.Gamma = ones([size(Image,3),1]);
else
    cdata = varargin;
end
X = [];
c = 1;
lastTF = false;
GapColor = uint8(permute(GapColor,[1 3 2])*255);
for n = 1:V
    x = [];
    for k = 1:H
        im = Image(:,:,:,c);
        im = rgbproj(im,cdata);
        v_gap = repmat(GapColor,[size(im,1) Gap]);
        x = cat(2,x,v_gap,im);
        c = c + 1;
        if c > size(Image,4)
            lastTF = true;
            break
        end
    end
    h_gap = repmat(GapColor,[Gap size(x,2)]);
    if lastTF
        if size(X,2)~=size(x,2)
            r = padarray(x(:,:,1),[0 size(X,2)-size(x,2)],GapColor(1),'post');
            g = padarray(x(:,:,2),[0 size(X,2)-size(x,2)],GapColor(2),'post');
            b = padarray(x(:,:,3),[0 size(X,2)-size(x,2)],GapColor(3),'post');
            x = cat(3,r,g,b);            
            h_gap = repmat(GapColor,[Gap size(X,2)]);
        end        
    end
    X = cat(1,X,h_gap,x);
end
h_gap = repmat(GapColor,[Gap size(X,2)]);
X = cat(1,X,h_gap);
v_gap = repmat(GapColor,[size(X,1) Gap]);
X = cat(2,X,v_gap);



    