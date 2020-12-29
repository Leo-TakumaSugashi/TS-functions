function output = TS_DepthReposi(vx,vy,Image,varargin)
% 
% See also TS_DepthAdjGUI,
% Input : 
%     vx . output.vx,
%     vy . output.vy,
%     Image : output.Image2
%     Type : defalt is {'nearest '} 'bilinear'
% Output : 
%     output = Resized Image by Depth Interpolation 
siz = zeros(1,5);
for n = 1:5
    siz(n) = size(Image,n);
end

if nargin==4
    Type = varargin{1};
else
    Type = 'nearest';
end

if max(vy) > size(Image,3)
    vy(vy > size(Image,3)) = nan;
end


output = zeros(siz(1),siz(2),length(vx),siz(4),siz(5),'like',Image(1));
[X,Z] = meshgrid(vx,1:siz(2));
[Xp,Zp] = meshgrid(vy,1:siz(2));
switch Type
    case 'nearest'
        for ch = 1:siz(5)
        for T = 1:siz(4)
            for n = 1:length(vx)
                if isnan(vy(n))
                    continue
                else
                    try
                output(:,:,round(vx(n)),T,ch) = ...
                    Image(:,:,round(vy(n)),T,ch);
                    catch
                        keyboard
                    end
                end
            end
        end
        end
    case 'bilinear'
        for ch = 1:siz(5)
        for T = 1:siz(4)
           parfor iy = 1:siz(1)
               V = double(squeeze(Image(iy,:,:,T,ch)));
               im = interp2(X,Z,V,Xp,Zp,Type);
               output(iy,:,:,T,ch) = feval(class(Image),im);
           end
        end
        end
        
        
    otherwise
        error('Input interpolation Type is NOT Correct')
end