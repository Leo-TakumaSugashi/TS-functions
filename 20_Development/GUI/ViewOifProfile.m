function ViewOifProfile(Info)
% ViewOifProfile(Info)
% Info : output of TSloadOif
%
% Edit ver.0.1  :  20th May, 2020
%   by Leo Takuma Sugashi
%   The University of Electro-Comunications.
% 


global X C Data th t
X = Info;
C = 0;
%     Print2ndColumn(1,'')
    f = uifigure('Name','Lieca Image File Profile (xmlList : output of HKLoadLif)',...
        'Position',[1 1 750 420]);
    centerfig(f)
    p= f.Position;
    p(3) = p(3)/3;
    t = uitree(f,'Position',[2 2 p(3)-4, p(4)-4]);
    % Assign Tree callback in response to node selection
    t.SelectionChangedFcn = @nodechange;
    fprintf('\n\n    Please wait.....\n\n')
    CreateTree(t); %% loop creater!!
    
    th = uitable(f,'Position',[p(3)+2,2, p(3)*2-4, p(4)-4],...
        'ColumnName',{'Attributes','Value'},...
        'ColumnEditable',[false false]);
    drawnow
    fprintf('                     Done \n\n')
    
    function nodechange(src,event)
        node = event.SelectedNodes;
        if node.UserData>=4 % && contains(node.Text,'Element')
            Data = [];
            GetChildrenData(node)
        else
            Data = cat(1,{['==== ' node.Text ],''},node.NodeData);
        end
        PaTF = false(size(Data,1),1);
        cTF = ~PaTF;
        for i = 1:size(Data,1)
            PaTF(i) = contains(Data{i,1},'====');
            if ~PaTF(i)
                Data{i,1} = [Data{i,1} '   : '];
            else
                Data{i,1} = Data{i,1}(5:end);
            end
        end
        
        set(th,'Data',Data);
        if isempty(Data) || size(Data,1)==1
            return
        end
        pcell = [PaTF,~cTF];
        ccell = [~PaTF,~cTF];
        lcell = [~cTF,cTF];
        pStyle = uistyle;
        pStyle.FontWeight = 'Bold';
        pStyle.FontAngle = 'italic';
        pStyle.HorizontalAlignment = 'center';
        cStyle = uistyle;
        cStyle.FontWeight = 'normal';
        cStyle.FontAngle = 'normal';
        cStyle.HorizontalAlignment = 'right';
        lStyle = uistyle;
        lStyle.HorizontalAlignment = 'left';
        [rw,col] = find(pcell);
        addStyle(th,pStyle,'cell',[rw,col])
        [rw,col] = find(ccell);
        addStyle(th,cStyle,'cell',[rw,col])
        [rw,col] = find(lcell);
        addStyle(th,lStyle,'cell',[rw,col])
    end
    function GetChildrenData(node)
        NameCell = cell(1,2);
        NameCell{1,1} = ['==== ' node.Text];
        NameCell{1,2} = '';
        Data = cat(1,Data,NameCell,node.NodeData);
        ch = node.Children;
        for n = 1:length(ch)
            GetChildrenData(ch(n))
        end
    end
    function p = CreateTree(ph)
        for ind = 1:size(X,1)
            Text = X{ind,1};
            p = uitreenode(ph,'Text',Text,...
                'NodeData',X{ind,2},...
                'UserData',1);
            drawnow
        end
    end
end

