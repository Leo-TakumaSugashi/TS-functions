function Set_SegEditor_Dark(H)

H.ControllerA.BackgroundColor = [0 0 0];
H.ControllerA.ForegroundColor = [1 1 1];


H.ControllerB.BackgroundColor = [0 0 0];
H.ControllerB.ForegroundColor = [1 1 1];
H.ProjectionH.BackgroundColor = [0 0 0];
H.ProjectionH.ForegroundColor = [1 1 1];
ch = get(H.ProjectionH,'Children');
for n = 1:length(ch)
    if strcmpi('text',get(ch(n),'style'))
        set(ch(n),'BackgroundColor',[0 0 0])
        set(ch(n),'ForegroundColor',[1 1 1])
    else
        set(ch(n),'BackgroundColor',[.2 .2 .2])
        set(ch(n),'ForegroundColor',[1 1 1])
    end
end
H.Slider(1).BackgroundColor = [0 0 0];
H.Slider(2).BackgroundColor = [0 0 0];
for n = 1:length(H.SliderText)
    H.SliderText(n).BackgroundColor = [0 0 0];
    H.SliderText(n).ForegroundColor = [1 1 1];
end
H.SliceViewerChannelsPanel.BackgroundColor = [0 0 0];
H.SliceViewerChannelsPanel.ForegroundColor = [1 1 1];
ch = get(H.SliceViewerChannelsPanel,'Children');
for n = 1:length(ch)
    if strcmpi('pushbutton',get(ch(n),'style'))
        continue
    end
    set(ch(n),'BackgroundColor',[0 0 0])
    set(ch(n),'ForegroundColor',[1 1 1])
end
set(get(H.Axes,'Parent'),'backgroundcolor',[0 0 0])
set(get(H.Axes,'Parent'),'Foregroundcolor',[1 1 1])


H.ControllerC.BackgroundColor = [0 0 0];
H.ControllerC.ForegroundColor = [1 1 1];
H.View3_BasePanel.BackgroundColor = [0 0 0];
H.View3_BasePanel.ForegroundColor = [1 1 1];
ch = get(H.View3_BasePanel,'Children');
for n = 1:length(ch)
    if strcmpi('pushbutton',get(ch(n),'style'))
        set(ch(n),'BackgroundColor',[.2 .2 .2])
    else
        set(ch(n),'BackgroundColor',[0 0 0])
    end
    set(ch(n),'ForegroundColor',[1 1 1])
    if strcmpi('togglebutton',get(ch(n),'style'))
        set(ch(n),'ForegroundColor',[0 0 0])
    end
end

H.Rendering.BackgroundColor = [0 0 0];
H.Rendering.ForegroundColor = [1 1 1];
ch = get(H.Rendering,'Children');
for n = 1:length(ch)
    if strcmpi('pushbutton',get(ch(n),'style'))
        set(ch(n),'BackgroundColor',[.2 .2 .2])
    else
        set(ch(n),'BackgroundColor',[0 0 0])
    end
    set(ch(n),'ForegroundColor',[1 1 1])
end
H.BranchEditPanel.BackgroundColor = [0 0 0];
H.BranchEditPanel.ForegroundColor = [1 1 1];
ch = get(H.BranchEditPanel,'Children');
for n = 1:length(ch)
    if strcmpi('pushbutton',get(ch(n),'style'))
        set(ch(n),'BackgroundColor',[.2 .2 .2])
    else
        set(ch(n),'BackgroundColor',[0 0 0])
    end
    set(ch(n),'ForegroundColor',[1 1 1])
end
H.BranchEdit_Radius_Edit.Enable = 'on';
H.BranchEdit_Step_Edit.Enable = 'on';
H.BranchEdit_Radius_Edit.BackgroundColor = [.2 .2 .2];
H.BranchEdit_Step_Edit.BackgroundColor = [.2 .2 .2];
H.BranchEdit_Radius_Edit.ForegroundColor = [1 1 1 ];
H.BranchEdit_Step_Edit.ForegroundColor = [1 1 1];

H.View3DPanel.BackgroundColor = [0 0 0];
H.View3DPanel.ForegroundColor = [1 1 1];


% Fname = fieldnames(H);
% for N = 1:length(Fname)
%     if strcmp('ChannelsEditPush',Fname(N))
%         continue
%     end
%     handles = H.(Fname{N});
%     for n = 1:length(handles)
%         try
%             switch get(handles(n),'style')
%                 case 'text'
%                     set(handles(n),'BackgroundColor',[0 0 0])
%                     set(handles(n),'ForegroundColor',[1 1 1])
%                 case 'pushubutton'
%                     set(handles(n),'BackgroundColor',[.2 .2 .2])
%                     set(handles(n),'ForegroundColor',[1 1 1])
%                 otherwise
%                     disp(handles(n))
%                     set(handles(n),'BackgroundColor',[0 0 0])
%                     set(handles(n),'ForegroundColor',[1 1 1])
%             end
%         catch err
%             try
%             set(handles(n),'BackgroundColor',[.2 .2 .2])
%             set(handles(n),'ForegroundColor',[1 1 1])
%             catch e
%                 keyboard
%             end
%         end
%     end
%     
% end





