function Output_skel = AtSEG_shaving(Segmentdata,Cutlen)
% Output = TS_AutoSegment2nd(Segmentdata,Cutlen)
% Segmentdata:
% �@End point ����Branch or End Point�܂ł̃Z�O�����g�ƒ����̌v�Z����
% Cutlen�F
% �@�J�b�g�������q�Q�̒���
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

%% bwthindata --->����čs���A�Ȃ��Ȃ�����I��
%%�@��������_����2�{�ȏ�endpoint�܂ŐL�тĂ�����̂������
% �@��Ԓ������̂�Cutlen�ȉ��ł��c�������B�B�B
% End2Branch = [];
End2Branch_copy = nan(10000,3);
% Pdata(1).DeleteTF = [];
DeleteTF = nan(1,length(Pdata));
c = 1;
for n = 1:length(Pdata)
    switch Pdata(n).Type
        case {1,5} %{'End to Branch','End to End'}            
            DeleteTF(n) = 1;             
            End2Branch_copy(c,:) = Pdata(n).Branch;
            c = c + 1;
%             End2Branch = cat(1,End2Branch,Pdata(n).Branch);
%             Pdata(n).DeleteTF = true;
        %case 'Branch to Branch'
    end
end
% Branch = cat(1,Pdata.Branch);
End2Branch = End2Branch_copy(1:c-1,:);

End2Branch_NUM = zeros(size(BPmatrix,1),1);
%% Caliculate End 2 Branch point's count....
PadSiz = size(End2Branch,1) - 1;
for n = 1:size(BPmatrix,1)
    p = BPmatrix(n,1:3); % [ X Y Z ]
    p = padarray(p,[PadSiz 0],'symmetric','pre');
    End2Branch_NUM(n) = sum(sum(p==End2Branch,2)==3,1);
end
%clear n PadSiz End2Branch


for n = 1:size(BPmatrix,1)
    NUM = End2Branch_NUM(n);
    if NUM<2
        continue
    else
        bp = BPmatrix(n,1:3);
        LEN = nan(1,10000);
        Ind = nan(1,10000);
        c = 1;
%         LEN = [];
%         Ind = [];
        for n2 = 1:length(Pdata)
            switch Pdata(n2).Type
                case 1 %'End to Branch'
                    if sum(Pdata(n2).Branch == bp)==3
                        Ind(c) = n2;
                        LEN(c) = Pdata(n2).Length;
                        c = c + 1;
%                         Ind = cat(1,Ind,n2);
%                         LEN = cat(1,LEN,Pdata(n2).Length);                        
                    end
            end
        end
        [~,MaxIndex] = nanmax(LEN);
        DeleteTF(Ind(MaxIndex)) = nan;
%         Pdata(Ind(MaxIndex)).DeleteTF = false;
    end
    %clear bp NUM LEN Ind n2 MaxIndex
end

%% Delete
bwthindata = padarray(bwthindata,[1 1 1],false);
for n = 1:length(Pdata)
    switch Pdata(n).Type
        case 5 %'End to End'
            if Cutlen<Pdata(n).Length
                continue
            end
            xyz = Pdata(n).PointXYZ;
            for n2 = 1:size(xyz,1)
                if ~isnan(xyz(n2,1))
                    x = xyz(n2,1) + 1;
                    y = xyz(n2,2) + 1;
                    z = xyz(n2,3) + 1;
                    bwthindata(y,x,z) = false;
                else
                    break
                end
            end
        case 1 %'End to Branch'
            if Cutlen<Pdata(n).Length
                continue
            end            
            if DeleteTF(n) ==1 % Pdata(n).DeleteTF
                xyz = Pdata(n).PointXYZ;
                for n2 = 1:size(xyz,1)
                    if ~isnan(xyz(n2,1))
                        x = xyz(n2,1) + 1;
                        y = xyz(n2,2) + 1;
                        z = xyz(n2,3) + 1;
                        ROI = bwthindata(y-1:y+1,x-1:x+1,z-1:z+1);
                        [~,NUMpre] = TS_bwlabeln3D26(ROI);
                        ROI(2,2,2) = false;
                        [~,NUMaft] = TS_bwlabeln3D26(ROI);
                    %% Check Deletable or Not
                    if NUMpre==NUMaft
                        bwthindata(y,x,z) = false;
                    end
                    else
                        break
                    end
                end
            end            
        case 0 %'Branch to Branch'
    end
end
%% Re Skeletoning by TS_bwmoroph3d
Output_skel = TS_Skeleton3D_oldest(bwthindata(2:end-1,2:end-1,2:end-1));
end

