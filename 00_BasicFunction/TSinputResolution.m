function TSinputResolution(fgh)

Reso = getappdata(fgh);
% Reso = rand(1,4);
dlgfh = figure('NumberTitle','off','IntegerHandle','off','Name','Resolution ?',...
    'position',[560 520 400 150],'Menubar','none','Toolbar','none');
uith(1) = uicontrol('position',[60 80 70 30],'String','Xaxis');
uith(2) = uicontrol('position',[130 80 70 30],'String','Yaxis');
uith(3) = uicontrol('position',[200 80 70 30],'String','Zaxis');
uith(4) = uicontrol('position',[270 80 70 30],'String','Taxis');
set(uith,'Style','text','backGroundColor',get(dlgfh,'color'))
uith(1) = uicontrol('position',[60 50 70 30],'String',num2str(Reso(1)));
uith(2) = uicontrol('position',[130 50 70 30],'String',num2str(Reso(2)));
uith(3) = uicontrol('position',[200 50 70 30],'String',num2str(Reso(3)));
uith(4) = uicontrol('position',[270 50 70 30],'String',num2str(Reso(4)));
set(uith,'Style','Edit')
setappdata(dlgfh,'data',uith)
setappdata(dlgfh,'fgh',fgh)
uicontrol('position',[230 10 70 30],'String','Apply','Callback',@Callback_InputReso)
uicontrol('position',[305 10 70 30],'String','Cancel','Callback','closereq')

    function Callback_InputReso(~,~)
    fgh  = getappdata(gcf,'fgh');
    uith = getappdata(gcf,'data');
    Reso = zeros(1,4);
    for i = 1:4
        Reso(i) = str2double(get(uith(i),'String'));
    end
    setappdata(fgh,'Resolution',Reso)
    closereq
    end

end