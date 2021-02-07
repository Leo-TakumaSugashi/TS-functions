function [chase_data] = HS_chase_seg_v4(SEG,input_ID,limit)
%%
% input: SEG,input_ID,limit
%  SEG: Output of TS_AutoSegment_loop
%  input_ID: start branch or end points' position(X,Y,Z)
%  limit: number of connections of segments 
%
% output: continued segments
% like end to branch segments 
% 
% If you want completed segments, you should use HS_chase_seg_v4.
% like end to branch segments
% 
%%

%% input data ì¬   
    input_data.segID = nan;
    input_data.PointXYZ = [nan,nan,nan];
    input_data.upperstream_branch = [nan,nan,nan];
    input_data.downstream_branch = input_ID;
%%

% stock_data ƒf[ƒ^”õ’~
% chase_data output
chase_data=[];
chase_data(1).chase = input_data;
complete_data = [];
num_branch = 0;
while num_branch < limit
    num_branch
num_branch = num_branch + 1; 
stock_data=[];
for vert_ind = 1:size(chase_data,2)
downbranch = chase_data(vert_ind).chase(num_branch).downstream_branch;
upperbranch = chase_data(vert_ind).chase(num_branch).upperstream_branch;

count =0;

for n = 1:size(SEG.Pointdata,2)
if size(SEG.Pointdata(n).Branch,1) == 2 %branch-branch 
 if  isequal(SEG.Pointdata(n).Branch(1,:),downbranch) ==1 && isequal(SEG.Pointdata(n).Branch(2,:),upperbranch)==0 
  stock_data(end+1).chase = chase_data(vert_ind).chase;
  stock_data(end).chase(end+1).segID = n;
  stock_data(end).chase(end).PointXYZ = SEG.Pointdata(n).PointXYZ;
  stock_data(end).chase(end).downstream_branch = SEG.Pointdata(n).Branch(2,:); 
  stock_data(end).chase(end).upperstream_branch = SEG.Pointdata(n).Branch(1,:);
    for check = 1:size(stock_data(end).chase,2)-1
      if stock_data(end).chase(check).segID == n
     stock_data(end).chase(end).downstream_branch = [999,999,999];   
      end  
    end
 elseif  isequal(SEG.Pointdata(n).Branch(2,:),downbranch) ==1 && isequal(SEG.Pointdata(n).Branch(1,:),upperbranch)==0 
  stock_data(end+1).chase = chase_data(vert_ind).chase;
  stock_data(end).chase(end+1).segID = n;
  stock_data(end).chase(end).PointXYZ = SEG.Pointdata(n).PointXYZ;
  stock_data(end).chase(end).downstream_branch = SEG.Pointdata(n).Branch(1,:); 
  stock_data(end).chase(end).upperstream_branch = SEG.Pointdata(n).Branch(2,:); 
    for check = 1:size(stock_data(end).chase,2)-1
      if stock_data(end).chase(check).segID == n
     stock_data(end).chase(end).downstream_branch = [999,999,999];   
      end  
    end 
 end
 
end 
 
end%n

end%vert
chase_data = stock_data;
end
end





