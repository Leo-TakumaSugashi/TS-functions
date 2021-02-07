function Output = TS_classdef2structure(H)
%     Output = TS_classdef2structure(H)
% Output = [];
% Field = fieldnames(H);
% for n =  1: size(Field,1)
%     eval(['Output.' Field{n} '=H.' Field{n} ';'])
% end
Output = [];
Field = fieldnames(H);
for n =  1: size(Field,1)
    eval(['Output.' Field{n} '=H.' Field{n} ';'])
end