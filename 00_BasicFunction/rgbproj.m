function A = rgbproj(Image,varargin)
% This function is for N channels data.
% see also ..
%   GetColorChannels, Makemap, gammafilter
% 
%             Map = cat(1,data.Color);
%             Gamma = cat(1,data.Gamma);
%             CLim = cat(1,data.CLim);
% Example, 1
%     D = load('mri');
%     D = double(squeeze(D.D));
%     D = uint8(D / max(D(:)) * 255);
%     ch = [1 5 9 10 15 27];
%     rgb = rgbproj(D(:,:,ch));
%     figure,imagesc(rgb),axis image,
%     caxis([1 size(D,3)])
%     colormap(GetColorChannels(length(ch)))
%     colorbar
% 
% Example, 2
%      D = load('mri');
%      D = double(squeeze(D.D(:,:,:,[1 5 27])));
%      D = uint8(D / max(D(:)) * 255);
%      cdata.CLim = cat(1,[0 100], [0 255] ,[0 255]);
%      cdata.Color = GetColorChannels(size(D,3));
%      cdata.Gamma = [1 2 0.2]';
%      rgb = rgbproj(D,cdata);
%      figure,imagesc(rgb),axis image

%% Editor's Log
%  2017 4 16 ,by Takuma SUGASHI
%      edit inputtype
%      add gammafilter, channel's map
% % % if ismatrix(squeeze(Image))
% % %     A = Image;
% % %     return
% % % end
% if nargin==2
%     if strcmpi(varargin{1},'auto')
%         A = rgbproj_old(Image,'auto');
%         return
%     end
% end

narginchk(1,2)
Image = squeeze(Image);
[Image,Info] = inputcheck_rgbproj(Image,varargin{:});
siz = size(Image);

if and(length(siz)<3,~Info.ProcessingTF)
    A = Image;
    return
end

num = size(Image,3);



A = zeros(siz(1),siz(2),3,num,'like',uint8(1));
Map = Info.map;
Gamma = double(Info.Gamma );
CLim = sort(double(Info.CLim) ,2);
TF = Info.ProcessingTF ;
if ~TF %% 'auto' or 'Normalized'
    for n = 1:num
        im = single(squeeze(Image(:,:,n)));
        if max(im(:))==0
            continue
        end
        A(:,:,:,n) = ind2rgb8(im,Makemap(Map(n,:)));
    end
else
    for n = 1:num
        im = double(squeeze(Image(:,:,n)));
        im = max((im - CLim(n,1)),0);
        im = min(im ./ (CLim(n,2) - CLim(n,1)),1);
        
        if Gamma(n) ~= 1
            im = im .^Gamma(n);
        end        
        A(:,:,:,n) = ind2rgb8(uint8(im*255),Makemap(Map(n,:)));
    end    
end

A = squeeze(max(A,[],4));
    

function [Image,Info] = inputcheck_rgbproj(Image,varargin)
siz = size(Image);
num = size(Image,3);
if ndims(Image)>3
    error([mfilename ' : Input Dimenssion is NOT Correct.!!'])
end

Map = GetColorChannels(num); %% default
Gamma = ones(num,1); %% default

ProcessingTF = true;
if nargin==2    
    if max(strcmpi(varargin{1},{'auto','Normalize'}))
        A = zeros(siz,'like',uint8(1));
        for n = 1:num
            im = single(Image(:,:,n));
            if min(im(:)) == max(im(:))
                im(:) = 0;
            else
                im = im - min(im(:));
                im = im./max(im(:));
            end
            im = uint8(im * 255);                
            A(:,:,n) = im;
        end
        Image = A;
        ProcessingTF = false;
        CLim = repmat([0 255],[num 1]);
    elseif isstruct(varargin{1})
        try
            data = varargin{1};
            Map = cat(1,data.Color);
                if 1 == size(Map,1),Map = repmat(Map,[num 1]);end
            Gamma = cat(1,data.Gamma);
                if 1 == length(Gamma), Gamma = repmat(Gamma,[num 1]);end
            CLim = cat(1,data.CLim);
                if 1 == size(CLim,1), CLim = repmat(CLim,[num 1]);end
        catch err
            disp(err)
        end
    else
        error([mfilename ' : Input methode is NOT correct'])
    end
else
    CLim = zeros(num,2);
    for n = 1:num
        im = Image(:,:,n);
        CLim(n,:) = [min(im(:)) max(im(:))];
    end
    check_eq = eq(CLim(:,1),CLim(:,2));
    CLim(check_eq,2) = 255;
    CLim(check_eq,1) = 0;
end
Info.map = Map;
Info.Gamma = Gamma;
Info.CLim = CLim;
Info.ProcessingTF = ProcessingTF ;


















