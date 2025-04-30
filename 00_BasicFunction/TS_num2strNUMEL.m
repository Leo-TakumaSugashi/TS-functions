function N = TS_num2strNUMEL(Number,NUMEL)
% N = TS_num2strNUMEL(Number,NUMEL)
% N = num2str(Number,'%d');
% while length(N) <NUMEL
%     N = ['0' N];
% end
% 
% example, 
%   TS_num2strNUMEL(10,2)
%   TS_num2strNUMEL(1,2)
%   TS_num2strNUMEL(91,3)
%   TS_num2strNUMEL(100,3)
%   TS_num2strNUMEL(pi,3)
%   
if ~isscalar(Number) && ~isscalar(NUMEL)
    error('Input must BE scalar')
end

if ( Number - floor(Number)) == 0
    N = num2str(Number,'%d');
    while length(N) <NUMEL
        N = ['0' N];
    end
else
    FloNum = NUMEL - length(num2str(floor(Number),'%d'));
    N = num2str(Number,['%.' num2str(FloNum) 'f']);
end