function varargout = TS_ClockDisp

ck = clock;
ST = {'/';'/';' - ';':';':';' ****'};
A = ['**** '];
for n = 1:6
    A = [A num2str(ck(n)) ST{n}];
end
if nargout == 1
    varargout{1} = A;
elseif nargout == 2
    YYYY = num2str(ck(1));
    mm = num2str(ck(2));
    if length(mm) ==1
        mm = ['0' mm];
    end    
    DD = num2str(ck(3));
    if length(DD) ==1
        DD = ['0' DD];
    end
    hh = num2str(ck(4));
    if length(hh) ==1
        hh = ['0' hh];
    end
    MM = num2str(ck(4));
    if length(MM) ==1
        MM = ['0' MM];
    end
    ss = num2str(round(ck(6)));
    if length(ss) ==1
        ss = ['0' ss];
    end
    B = [YYYY mm DD hh MM ss];
    
    varargout{2} = B;
    
    
    
else
    disp(A)
end