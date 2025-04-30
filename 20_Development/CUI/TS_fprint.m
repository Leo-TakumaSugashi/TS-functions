classdef TS_fprint
    properties
       IsDesktop(1,1) {mustBeNumericOrLogical} = usejava("desktop")
       UserData 
    end
    methods
        function obj = set.IsDesktop(obj,val)
            obj.IsDesktop = logical(val);
        end
        
        function red(obj, STR)
            if obj.IsDesktop
                fprintf(STR);
            else
                fprintf( strcat("\033[31m", STR, "\033[0m") ) 
            end
        end
        
        function green(obj, STR)
            if obj.IsDesktop
                fprintf(STR)
            else
                fprintf(strcat("\033[32m", STR, "\033[00m"))
            end
        end

        function yellow(obj, STR)
            if obj.IsDesktop
                fprintf(STR)
            else
                fprintf(strcat("\033[33m", STR, "\033[00m"))
            end
        end
        
        function blue(obj, STR)
            if obj.IsDesktop
                fprintf(STR)
            else
                fprintf(strcat("\033[34m", STR, "\033[00m"))
            end
        end
        function magenta(obj, STR)
            if obj.IsDesktop
                fprintf(STR)
            else
                fprintf(strcat("\033[35m", STR, "\033[00m"))
            end
        end
        function cyan(obj, STR)
            if obj.IsDesktop
                fprintf(STR)
            else
                fprintf(strcat("\033[36m", STR, "\033[0m"))
            end
        end
        function underber(obj)
            if obj.IsDesktop
                fprintf '';
            else
                fprintf "\033[4m";
            end
        end
        function reset(obj)
            if obj.IsDesktop
                fprintf '';
            else
                fprintf "\033[00m";
            end
        end
        
    end
end
