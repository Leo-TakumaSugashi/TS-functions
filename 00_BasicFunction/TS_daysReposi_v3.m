function data = TS_daysReposi_v3(Reso,varargin)
% data = TS_daysReposi_proto(Reso(XYZ),Image1,Image2,...)
% 5次元対応
% 比較対象はImage(:,:,:､1,1)。。。つまり、最初のIndexに血管をぶち込んでおくと便利

 narginchk(3,10)
 if and(isstruct(varargin{1}),ischar(varargin{2}))     
     dataset = varargin{1};
     FieldName = varargin{2};
     data(1:length(dataset)) = struct('Image',[]);     
     for n = 1:length(dataset)
         eval(['data(n).Image = dataset(' num2str(n) ').' FieldName ';'])
     end
     clear dataset
 else
     data(nargin-1) = struct('Image',[],'shift_matrix',[]);
     for n = 1:nargin-1
         data(n).Image = varargin{n};
     end
 end
clear varargin
A = data(1).Image;
lenData = length(data);
for num = 2:lenData
    disp(['Now ..data1 and data' num2str(num)])
    B = data(num).Image;
    %% Main Func. 
    [A,B,overrap] = TS_3dReposiPre_v2(A,B,Reso,'crop');
    
    
%     [outA,outB,shift_matrix] = TS_3dReposi_proto(A,B,Reso,'crop');    
%     for n = 1:size(outA,3)
%     [IM1,IM2] = TS_Shift2padreposi(outA(:,:,n,:,:),...
%         outB(:,:,n,:,:),...
%         shift_matrix(n,:),'crop');
%     outA(:,:,n,:,:)= IM1;
%     outB(:,:,n,:,:) = IM2;
%     end
%     clear IM1 IM2
    [Image,Flex,Shift_z,FlexRatio] = TS_AdjFlexibility(A,B,Reso);
    shift_matrix = zeros(size(A,3),2);
    for n = 1:size(A,3)
        sh = TS_SliceReposition(A(:,:,n,1,1),Image(:,:,n,1,1));
        [~,IM2] = TS_Shift2padreposi(A(:,:,n,:,:),...
            Image(:,:,n,:,:),sh,'crop');
        Image(:,:,n,:,:) = IM2;
        shift_matrix(n,:) = sh;
    end   
    
    size(Image)
    data(num).Image = Image;
    data(num).shift_matrix = shift_matrix;
    data(num).Flex = Flex;
    data(num).Surface_Shift = Shift_z;
    data(num).FlexRatio = FlexRatio;
end
end






