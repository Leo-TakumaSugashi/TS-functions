function Output_skel = AtSEG_shaving(Segmentdata,Cutlen)
% Output = TS_AutoSegment2nd(Segmentdata,Cutlen)
% Segmentdata:
% 　End point からBranch or End Pointまでのセグメントと長さの計算結果
% Cutlen：
% 　カットしたいヒゲの長さ
% % 
tic
%  Input: [120x120x250 logical]
%            Branch: [120x120x250 logical]
%               End: [120x120x250 logical]
%         Pointdata: [1x437 struct]
%     ResolutionXYZ: [1.7878 1.7878 1.7878]

%% Input
% Reso = Segmentdata.ResolutionXYZ; %% Resolution [X Y Z]
bwthindata = Segmentdata.Input;
% BPcentroid = Segmentdata.Branch;
% [bpy,bpx,bpz] = ind2sub(size(BP),find(BP(:)));
% EndP = Segmentdata.End;
Pdata = Segmentdata.Pointdata;
if isempty(Pdata) 
    Output_skel = bwthindata;
    return
end
BPmatrix = Segmentdata.BPmatrix;
% OriginalBW = bwthindata;

%% bwthindata --->削って行き、なくなったら終了
%%　同じ分岐点から2本以上endpointまで伸びているものがあれば
% 　一番長いものはCutlen以下でも残したい。。。
End2Branch = [];
Pdata(1).DeleteTF = [];
for n = 1:length(Pdata)
    switch Pdata(n).Type
        case {'End to Branch','End to End'}
            End2Branch = cat(1,End2Branch,Pdata(n).Branch);
            Pdata(n).DeleteTF = true;
        case 'Branch to Branch'
    end
end
% Branch = cat(1,Pdata.Branch);

End2Branch_NUM = zeros(size(BPmatrix,1),1);
%% Caliculate End 2 Branch point's count....
PadSiz = size(End2Branch,1) - 1;
for n = 1:size(BPmatrix,1)
    p = BPmatrix(n,1:3); % [ X Y Z ]
    p = padarray(p,[PadSiz 0],'symmetric','pre');
    End2Branch_NUM(n) = sum(sum(p==End2Branch,2)==3,1);
end
clear n PadSiz End2Branch


for n = 1:size(BPmatrix,1)
    NUM = End2Branch_NUM(n);
    if NUM<2
        continue
    else
        bp = BPmatrix(n,1:3);
        LEN = [];
        Ind = [];
        for n2 = 1:length(Pdata)
            switch Pdata(n2).Type
                case 'End to Branch'
                    if sum(Pdata(n2).Branch == bp)==3
                        Ind = cat(1,Ind,n2);
                        LEN = cat(1,LEN,Pdata(n2).Length);                        
                    end
            end
        end
        [~,MaxIndex] = max(LEN);
        Pdata(Ind(MaxIndex)).DeleteTF = false;
    end
    clear bp NUM LEN Ind n2 MaxIndex
end

%% Delete
bwthindata = padarray(bwthindata,[1 1 1],false);
for n = 1:length(Pdata)
    switch Pdata(n).Type
        case 'End to End'
            if Cutlen<Pdata(n).Length
                continue
            end
            xyz = Pdata(n).PointXYZ + 1;
            bwthindata(xyz(:,2),xyz(:,1),xyz(:,3)) = false;
            clear xyz
        case 'End to Branch'
            if Cutlen<Pdata(n).Length
                continue
            end            
            if Pdata(n).DeleteTF
                xyz = Pdata(n).PointXYZ;
                for n2 = 1:size(xyz,1)
                    x = xyz(n2,1) + 1;
                    y = xyz(n2,2) + 1;
                    z = xyz(n2,3) + 1;
                    ROI = bwthindata(y-1:y+1,x-1:x+1,z-1:z+1);
                    [~,NUMpre] = bwlabeln(ROI,26);
%                     s = bwconncomp(ROI,26);
%                     NUMpre = s.NumObjects;
                    ROI(2,2,2) = false;
                    [~,NUMaft] = bwlabeln(ROI,26);
%                     s = bwconncomp(ROI,26);
%                     NUMaft = s.NumObjects;
                    %% Check Deletable or Not
                    if NUMpre==NUMaft
                        bwthindata(y,x,z) = false;
                    end
                    clear x y z ROI s NUMpre NUMaft
                end
                clear xyz
            end            
        case 'Branch to Branch'
    end
end

%% Re Skeletoning by TS_bwmoroph3d
Output_skel = TS_Skeleton3D_oldest(bwthindata(2:end-1,2:end-1,2:end-1));
end
