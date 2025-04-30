function varargout = TS_DeveloperMemo(UserName)
GUI = Sugashi_GUI_support;
GUI.FontSize = double(15);
fgh = GUI.SetupEditorsMemo('DevelopersMemo',UserName);
fgh.NumberTitle = 'off';
fgh.HandleVisibility = 'off';
if nargout ==1
    varargout{1} = fgh;
end