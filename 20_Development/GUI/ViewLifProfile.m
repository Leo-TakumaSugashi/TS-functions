function ViewLifProfile(xmlList)
% ViewLifProfile(xmlList)
% xmlList : output of HKLoadLif_vTS
% spetial Thanks, Hiroshi Kawaguchi PhD.
%
% Edit ver.0.1  :  19th May, 2020
%   by Leo Takuma Sugashi
%   The University of Electro-Comunications.
% 

% rank(double) name(string) attributes(cell(n,2)) parant(double) children(double array)
global X C Data th t Siz
X = xmlList;
C = 0;
Siz = size(xmlList,1);
%     Print2ndColumn(1,'')
    
    f = uifigure('Name','Lieca Image File Profile (xmlList : output of HKLoadLif)',...
        'Position',[1 1 750 420]);
    centerfig(f)
    p= f.Position;
    p(3) = p(3)/3;
    t = uitree(f,'Position',[2 2 p(3)-4, p(4)-4]);
    % Assign Tree callback in response to node selection
    t.SelectionChangedFcn = @nodechange;
    fprintf('\n\n    Please wait.....\n     ')
    TS_WaiteProgress(C);
    CreateTree(1,t); %% loop creater!!
    
    th = uitable(f,'Position',[p(3)+2,2, p(3)*2-4, p(4)-4],...
        'ColumnName',{'Attributes','Value'},...
        'ColumnEditable',[false false]);
    drawnow
    fprintf('\n                               Done \n\n')
    
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
    function ind = GetRankInd(r)
        x = cell2mat(X(:,1));
        ind = find(x==r);
    end
    function Print2ndColumn(ind,prestr)
        C = C + 1;
        fprintf([prestr '+-'])
        prestr = ['| ' prestr];
        for n=1:length(ind)
            fprintf([X{ind(n),2} '\n'])
            ch = X{ind(n),5};
            if isempty(ch),continue,end
            for nn =1:length(ch)
                Print2ndColumn(ch(nn),prestr)
            end
        end
        %fprintf('\n')
    end

    function p = CreateTree(ind,ph)
        if X{ind,1}==4 && strcmp(X{ind,2},'Element')
            celldata = X{ind,3};
            for i = 1:size(celldata,1)
                if strcmp(celldata{i,1},'Name')
                    Text = celldata{i,2};
                    break
                end
            end
            Text = [X{ind,2} ' ( ' Text ' )'];
        else
            Text = X{ind,2};
        end
            
        p = uitreenode(ph,'Text',Text,...
            'NodeData',X{ind,3},...
            'UserData',X{ind,1});
        ch = X{ind,5};
        for nn =1:length(ch)
            CreateTree(ch(nn),p);
        end
        if X{ind,1}<5
            expand(ph)
            drawnow
        end
        C = C+1;
        TS_WaiteProgress(C/Siz)
        
    end
end

