function TS_choice_clear

NameList_choice = evalin('base','whos');
String = {NameList_choice.name};
[selt,ok] = listdlg('PromptString','Select a file',...
    'SelectionMode','multiple','ListString',String);

if ok
    for n = 1:length(selt)
        evalin('base',['clear( ''' String{selt(n)} ''')'])
    end
end
