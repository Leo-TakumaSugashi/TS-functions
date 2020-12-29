clear all
now = cd;
cd(now)
cd ..
load('Glist.mat')
prompt2 = 'output tyoe? [Completed/Continued]';
type = input(prompt2,'s');
if isempty(type)
    type = 'Completed';
end

prompt = 'Diverge Limit? ';
limit = input(prompt);

prompt = 'individual? ';
individual = input(prompt);

for w = individual:individual
% cd(now)
% 
%   mkdir(Glist{w,1})
% 
% GCaMP = '\\TS-QVHL1D2\Share1\GROUP\blood vessel or flow\takeda\GCaMP';
% Gdir = [GCaMP,'\',Glist{w,1}];


Gdir = ['E:\MATLAB\MasamotoLab\GCaMP\',Glist{w,1}];
 cd([Gdir,'\skel_len\ArteryVein']);
load('AV.mat');

 cd([Gdir,'\skel_len'])
  load('Dim_Base_v2.mat')
  cd([now,'\',Glist{w,1},'\t_8Hz'])  
 load('T_SEG')
  cd([now,'\',Glist{w,1}])
  
 MaskA = Mask_Storage_A;
 MaskV = Mask_Storage_V;
%% Artery 

base_skel_artery = logical(base_skel_v2 .* MaskA); 
base_skel_artery_branch = logical(SEG.Branch .* MaskA);
figure,pointview(base_skel_artery)
hold on
output = [];
ID_ind =[];

[x_ind,y_ind,z_ind] = ind2sub([256,256,128],find(base_skel_artery_branch));
ID_ind = horzcat(y_ind,x_ind,z_ind);


if type == 'Completed'
for n = 1:size(ID_ind,1)
pointview(ID_ind(n,:))
    input_ID = ID_ind(n,:);
    output(n).chase_data = HS_chase_seg_v3(SEG,input_ID,limit);
end
elseif type == 'Continued'
for n = 1:size(ID_ind,1)
pointview(ID_ind(n,:))
    input_ID = ID_ind(n,:);
    output(n).chase_data = HS_chase_seg_v4(SEG,input_ID,limit);
end
else
msg = 'Error output type.';
error(msg)
end

%��Ԗڂɓ��Ö�����_��ʂ锻��
delete_ind = [];
comp_data = struct('chase_data',[]);
for n = 1:size(output,2)
    chase_data = [];
    delete_ind(n).ind = zeros(length(output(n).chase_data),1);
    for m = 1:length(output(n).chase_data)
     for l = 1:size(ID_ind,1)
        if output(n).chase_data(m).chase(2).downstream_branch == ID_ind(l,:)
         delete_ind(n).ind(m,1) =1;
        end
     end
     if delete_ind(n).ind(m) == 0
         chase_data = vertcat(chase_data,output(n).chase_data(m));
     end
    end
    comp_data(n).chase_data = chase_data;
end
%%�Z�߂�
comp_skel =[];
for n = 1:size(comp_data,2) 
for i = 1:size(comp_data(n).chase_data,1)
    comp_skel(n).chase_data(i).skel = zeros([256 256 128]);
    for m = 1:size(comp_data(n).chase_data(i).chase,2)
    position = comp_data(n).chase_data(i).chase(m).PointXYZ;
    for l = 1:size(position,1)
    if isnan(position(l,1))==0 
    comp_skel(n).chase_data(i).skel(position(l,2),position(l,1),position(l,3)) = 1;
    end
    end
    end
end
end

artery_skel = comp_data; 
artery_ind = ID_ind;

if limit < 10
    eval(strcat('save av_',num2str(limit),type,'.mat artery_skel artery_ind'))
else
    eval(strcat('save av_',type,'.mat artery_skel artery_ind'))
end
% %% make movie from MATLAB plot
% Frate = 20;
% for n = 1:size(comp_data,2)
% close all
% clear Frame 
% for i = 1:size(comp_data(n).chase_data,1)
%     % First, make figure
%     base_plot = logical(single(base_skel_v2) - single(logical(comp_skel(n).chase_data(i).skel)));
%     figure(1);
%        if i ~= 1 
%     delete(p1)
%        end
%     p1 = pointview(base_plot);
%     p1.MarkerEdgeColor = [0.8 0.8 0.8];
%     p1.MarkerSize = 4;
%     alpha 0.5
%    if i ~= 1 
%     delete(p)
%    end
%     p = pointview(logical(comp_skel(n).chase_data(i).skel));
%     p.MarkerEdgeColor = [1 0.1 0.1];
%     p.MarkerSize = 5;
% 
%     % Put current figure into Frame
%     Frame(i) = getframe(1);
% end
% 
% % write to video
% v = VideoWriter(strcat('artery_',Glist{w,1},'_',num2str(n),'.avi'));
% v.FrameRate = Frate; % Framerate
% exist Frame;
% if ans ~= 0
% open(v);
% writeVideo(v,Frame);
% close(v);
% end
% end

%% Vein
base_skel_vein = logical(base_skel_v2 .* MaskV); 
base_skel_vein_branch = logical(SEG.Branch .* MaskV);
figure,pointview(base_skel_vein)
hold on
output = [];
ID_ind =[];

[x_ind,y_ind,z_ind] = ind2sub([256,256,128],find(base_skel_vein_branch));
ID_ind = horzcat(y_ind,x_ind,z_ind);



%%�ۑ�
%�Z�O�����g�̏d��
%�O�����č\��
%���������珇�ɐF�t��
%��{�ɂȂ�������t,cv.rc,diameter���z
%base_skel_v2���D�F�Ńv���b�g�@hold on �ō��p=Markercolor
%�㗬���珇�ԂɐF�����Ńv���b�g
%����Ɠ����Ɉ�{�ł�t,cv,rc,diamap����� ��ID����������������Ă���
%ID�����Ԃ邩�ǂ����݂����@������ID�A�E�Ɂ{�P���邳��Ɂ�ԍ����L�^
%���Ԃ�͈͂͂ǂꂭ�炢���@��̂ł킩��(��̐����������[�g�Ŏg�p����Ă��邩�킩��)
%�㗬�����t�]���錌�ǂ͂ǂꂭ�炢����̂��@�㗬�̓_�Ɖ����_�����ꂼ�ꃊ�X�g�A�b�v(���̂Ƃ��́�ԍ���)
%�����ɑ��݂�����̂�
%�ЂƂ̕���_

%���ꂪ�I�������j���[�����l�b�g���[�N���l����B
%��ԋ߂��_�o�זE�̋���
%�����Ɖ��肵�āA���̒��_��t,cv.rc,diameter���z
%�t���b�V������_�o�זE�͈��̋������ɂ��邩
%



if type == 'Completed'
for n = 1:size(ID_ind,1)
pointview(ID_ind(n,:))
    input_ID = ID_ind(n,:);
    output(n).chase_data = HS_chase_seg_v3(SEG,input_ID,limit);
end
elseif type == 'Continued'
for n = 1:size(ID_ind,1)
pointview(ID_ind(n,:))
    input_ID = ID_ind(n,:);
    output(n).chase_data = HS_chase_seg_v4(SEG,input_ID,limit);
end
end

%��Ԗڂɓ��Ö�����_��ʂ锻��
delete_ind = [];
comp_data = struct('chase_data',[]);
for n = 1:size(output,2)
    chase_data = [];
    delete_ind(n).ind = zeros(length(output(n).chase_data),1);
    for m = 1:length(output(n).chase_data)
     for l = 1:size(ID_ind,1)
        if output(n).chase_data(m).chase(2).downstream_branch == ID_ind(l,:)
         delete_ind(n).ind(m,1) =1;
        end
     end
     if delete_ind(n).ind(m) == 0
         chase_data = vertcat(chase_data,output(n).chase_data(m));
     end
    end
    comp_data(n).chase_data = chase_data;
end
%%�Z�߂�
comp_skel =[];
for n = 1:size(comp_data,2) 
for i = 1:size(comp_data(n).chase_data,1)
    comp_skel(n).chase_data(i).skel = zeros([256 256 128]);
    for m = 1:size(comp_data(n).chase_data(i).chase,2)
    position = comp_data(n).chase_data(i).chase(m).PointXYZ;
    for l = 1:size(position,1)
    if isnan(position(l,1))==0 
    comp_skel(n).chase_data(i).skel(position(l,2),position(l,1),position(l,3)) = 1;
    end
    end
    end
end
end


vein_skel = comp_data; 
vein_ind = ID_ind;


if limit < 10
    eval(strcat('save av_',num2str(limit),type,'.mat vein_skel vein_ind -append'))
else
     eval(strcat('save av_',type,'.mat vein_skel vein_ind -append'))
end

% %% make movie from MATLAB plot
% Frate = 20;
% exist Frame;
% if ans ~= 0
% open(v);
% writeVideo(v,Frame);
% close(v);
% end
% 
% for n = 1:size(comp_data,2)
% close all
% clear Frame
% for i = 1:size(comp_data(n).chase_data,1)
%     % First, make figure
%     base_plot = logical(single(base_skel_v2) - single(logical(comp_skel(n).chase_data(i).skel)));
%     figure(1);
%     
%     if i ~= 1
%         delete(p1)
%     end
%     p1 = pointview(base_plot);
%     p1.MarkerEdgeColor = [0.8 0.8 0.8];
%     p1.MarkerSize = 4;
%     alpha 0.5
%    if i ~= 1 
%     delete(p)
%    end
%     p = pointview(logical(comp_skel(n).chase_data(i).skel));
%     p.MarkerEdgeColor = [1 0.1 0.1];
%     p.MarkerSize = 5;
% 
%     % Put current figure into Frame
%     Frame(i) = getframe(1);
% end
% % write to video
% v = VideoWriter(strcat('vein_',Glist{w,1},'_',num2str(n),'.avi'));
% v.FrameRate = Frate; % Framerate
% 
% end
close all
clearvars -except w Gdir Glist now limit type
end%w
cd(now)