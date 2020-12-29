function Names = TS_xmlNames_(data)

global CC c
CC = cell(1,1);
c = 0;
updatecell(data)
Names = CC;

function updatecell(Struct)
    for n = 1:length(Struct)
        if ~max(strcmpi(Struct(n).Name,CC))
            c = c + 1;
            CC{c} = Struct(n).Name;
            disp(Struct(n).Name)
        end
        for k = 1:length(Struct(n).Children)
             updatecell(Struct(n).Children)
        end
    end
end


end


% HealthData
% #text
% ExportDate
% Me
% Record
% MetadataEntry