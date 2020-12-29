function A = TS_Shaving1st(bwthindata)
%% A = TS_Shaving1st(bwthindata)
disp('***** Analysis Pre Processing. *****')
[BPcentroid,~,BPgroup,EndP] = TS_bwmorph3d(bwthindata,'branchpoint','none');
% BPgroup = or(BPcentroid,BPgroup);
%% Add Shaving minimum pixels length(nearest of 26)
DilateEndP = imfilter(uint8(EndP),ones(3,3,3));
Dilate_DelP= or(DilateEndP==2,and(imfilter(uint8(bwthindata),ones(3,3,3))==1,EndP));
% DeletePoint = or(DilateEndP,...
%     and(imdilate(BPgroup,ones(3,3,3)),EndP));
DeletePoint = or(Dilate_DelP,...
    and(imdilate(BPcentroid,ones(3,3,3)),EndP));


disp(['   ***** Shaving of  Minimum length ..'  num2str(sum(DeletePoint(:))) ...
        ' / ' num2str(sum(bwthindata(:))) ' = ' ...
        num2str(sum(DeletePoint(:))/sum(bwthindata(:))) ' *****'])
bwthindata(DeletePoint) = false;
A = bwthindata;