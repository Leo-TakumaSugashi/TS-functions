function [SEGoutput,NewDiamImage] = TS_SEGandDiam(SEG,DiamImage)
Pdata = SEG.Pointdata;
Pdata(1).Diameter = [];
Pdata(1).AverageDiameter = [];
Reso = SEG.ResolutionXYZ;

AddBranch = SEG.AddBP;
[y,x,z] = ind2sub(size(AddBranch),find(AddBranch(:)));
AddBranch_xyz = cat(2,x,y,z); clear x y z

NewDiamImage = DiamImage;

wh = waitbar(0,'Wait...');
for num = 1:length(Pdata)
    xyz = uint32(Pdata(num).PointXYZ);
    Diam = zeros(size(xyz,1),1);
    Ind = false(size(Diam));
    Branch_Ind = false(size(Diam));
    Branch_xyz = uint32(max(Pdata(num).Branch,1));
    %% 分岐点における径の取得
    BranchDiam = zeros(size(Branch_xyz,1),1);
    for n = 1:size(Branch_xyz,1)
        BranchDiam(n) = DiamImage(...
            Branch_xyz(n,2),...
            Branch_xyz(n,1),...
            Branch_xyz(n,3));
        
        % % for Branch Index
        b_xyz = Branch_xyz(n,:);
        b_x = xyz(:,1) == b_xyz(1);
        b_y = xyz(:,2) == b_xyz(2);
        b_z = xyz(:,3) == b_xyz(3);
        b_ind = and(and(b_x,b_y),b_z);
        Branch_Ind = or(Branch_Ind,b_ind);
    end
    
    %% 分岐点の径の長さの半分（＝＝半径）と比べて、その点が遠ければ有効、
    %% その点が、分岐点の半径内ならば、無効
    for n = 1:size(xyz,1)
        Diam(n) = DiamImage(xyz(n,2),xyz(n,1),xyz(n,3));        
        BranchLen = Branch_xyz ...
            - repmat(xyz(n,1:3),[size(Branch_xyz,1) 1]);
        BranchLen = sqrt(sum(BranchLen.^2,2));
        if (min(BranchDiam/2 < BranchLen))
            Ind(n) = true;
        end
    end

%% Delete NewDiamImage of Branch (Joint) Area
    Branch = double(round(max(Pdata(num).Branch,1)));
    % % However, if Add Branch point, it's not delete.(remaning)
    B2len =max( TS_EachLengthMap2(Branch,AddBranch_xyz,Reso) == 0 , [] ,1);
    Branch(B2len,:) = [];
    
    
    
    xyz = double(round(Pdata(num).PointXYZ));
    DeletablePoint = false(size(xyz,1),1);
    
    for n = 1:size(Branch,1)
        len = TS_EachLengthMap2(Branch(n,:),xyz,Reso);
        dim = DiamImage(Branch(n,2),Branch(n,1),Branch(n,3));
        DeletablePoint = or(DeletablePoint,and(len>0,len<dim/2));
    end
    dp = find(DeletablePoint);
    for n = 1:length(dp)
        try
        NewDiamImage(xyz(dp(n),2),xyz(dp(n),1),xyz(dp(n),3)) = nan;
        catch err
            disp(err.message)
        end
    end
%%
    
    
    Pdata(num).Diameter = Diam;
    Pdata(num).AverageDiameter = nanmean(Diam(Diam>0));
    Pdata(num).NoneBranchDiamInd = Ind;
    Pdata(num).NoneBranchDiamAverageDiameter = nanmean(Diam(and(Ind,Diam>0)));
    Pdata(num).NoneBranchAverageDiameter = nanmean(Diam(and(~Branch_Ind,Diam>0)));
%     plen = cumsum(xyz2plen(xyz,ones(1,3)));
%     fgh = figure;plot(plen,Diam,'x-'),hold on
%     Diam(~Ind) = nan;
%     plot(plen,Diam,'o-')
%     waitfor(fgh)
    waitbar(num/length(Pdata),wh,...
        ['Wait ... ' num2str(num) '/' num2str(length(Pdata))])
end
close(wh)
SEGoutput = SEG;
SEGoutput.Pointdata = Pdata;