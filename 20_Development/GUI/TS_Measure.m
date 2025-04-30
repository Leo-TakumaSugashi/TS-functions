function h = TS_Measure(varargin)
% h = TS_Measure()
% h = TS_Measure(axh)
% h = TS_Measure(axh,Reso)
% 
% edit Sugashi, 2019, 07,13 

narginchk(0,2)
if nargin == 0
     axh = gca;
elseif nargin >=1
    axh = varargin{1};
end

if nargin ==2
    Reso = varargin{2};
else
    Reso = [1 1];
end


h = drawline(axh);
h.UserData.Resolution = Reso;
h.UserData.Units = 'um';
h.Tag = 'TS_Measure';
% Listen to movement to update the line label
addlistener(h,'MovingROI',@updateLabel);
% Listen for clicks on the line
addlistener(h,'ROIClicked',@updateUnits);

% Resolution seting up
c = h.UIContextMenu;
% hROIs = findobj(axh,'Tag','TS_Measure');
% if isempty(hROIs) 
%     ONOFF = 'on';
% else
%     c = get(hROIs(1),'UiContextMenu');
%     
% end
uimenu(c,'Label','Resolution','Callback',@Resolution);
% uimenu(c,'Label','Label ON/OFF','Checked','on','Callback',@LabelONOFF);
end

function LabelONOFF(src,evt)
ONOFF = src.Checked;
hAx = src.Parent;
hROIs = findobj(hAx,'Tag','TS_Measure');
for i = 1:numel(hROIs)
    pos = hROIs(i).Position;
    diffPos = diff(pos);
    mag = hypot(diffPos(1)*Reso(1),diffPos(2)*Reso(2));
    
    if strcmpi(ONOFF,'on')
        set(hROIs(i),'Label',[num2str(mag,'%30.1f') ' ' answer{1}]);
    else
        set(hROIs(i),'Label','');
    end
    
    cmh = get(hROIs(i),'UIContextMenu');
    for n = length(cmh)
        if strcmpi(cmh(n).Label,'Label ON/OFF')
            cmh(n).Checked = ONOFF;
        end
    end
    
end
end

function updateLabel(src,evt)

% Get the current line position
pos = evt.Source.Position;
Reso = src.UserData.Resolution;
% Determine the length of the line
diffPos = diff(pos,[],1);
mag = hypot(diffPos(1)*Reso(1),diffPos(2)*Reso(2));

% Update the label
set(src,'Label',[num2str(mag,'%30.1f') ' ' src.UserData.Units] );

end
function updateUnits(src,evt)

% If user double clicks on label, open input dialog to specify known
% distance to scale all line measurements
if strcmp(evt.SelectionType,'double') && strcmp(evt.SelectedPart,'label')

    % Display dialog box
    answer = inputdlg({'Distance units'},...
        'Specify Units',[1 20],{src.UserData.Units});
    if isempty(answer)
        return
    end    
    % Gather data to be stored with each ROI
    myData.Units = answer{1};
    myData.Resolution = src.UserData.Resolution;
    % Find all line ROIs in the axes and reset the data stored in the
    % UserData property
    hAx = src.Parent;
    hROIs = findobj(hAx,'Tag','TS_Measure');
    set(hROIs,'UserData',myData);
    Reso = src.UserData.Resolution; 
    % For each line ROI, update the label based on the result from the
    % input dialog
    for i = 1:numel(hROIs)
        pos = hROIs(i).Position;
        diffPos = diff(pos);
        mag = hypot(diffPos(1)*Reso(1),diffPos(2)*Reso(2));
        set(hROIs(i),'Label',[num2str(mag,'%30.1f') ' ' answer{1}]);
    end
end

end
function Resolution(~,~)
src = findobj(gca,'Tag','TS_Measure');
src = src(1);
Reso = src.UserData.Resolution;
% Display dialog box
answer = inputdlg({'Input Resolution X';'Specify Resolution Y'},...
    'Specify Resolution X',...
    [1 20],{num2str(Reso(1));num2str(Reso(2))});
if isempty(answer)
    return
end  

myData.Units = src.UserData.Units;
myData.Resolution = [str2double(answer{1}), str2double(answer{2})];
% Find all line ROIs in the axes and reset the data stored in the
% UserData property
hAx = src.Parent;
hROIs = findobj(hAx,'Tag','TS_Measure');
set(hROIs,'UserData',myData);
% For each line ROI, update the label based on the result from the
% input dialog
for i = 1:numel(hROIs)
    pos = hROIs(i).Position;
    diffPos = diff(pos);
    mag = hypot(diffPos(1)*Reso(1),diffPos(2)*Reso(2));
    set(hROIs(i),'Label',[num2str(mag,'%30.1f') ' ' src.UserData.Units]);
end
end
