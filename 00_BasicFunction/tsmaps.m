classdef tsmaps
    properties
        num = 256;
        Gray = [.5 .5 .5]
    end    
    methods
        function map = kjet(obj)
            map = kjet(obj.num);
        end
        function map = Grey_jet(obj)
            m = jet(obj.num-1);
            map = cat(1,obj.Gray,m);
        end
        function map = GlobalMap1(obj)
            c = [0   0   0;
                 0   0   1;
                 1   0.5 0;
                 0   1   0;
                 1   1   1];
           map = rgbmap2indgray(...
               interp2(c,1:3,...
               linspace(1,size(c,1),obj.num)'),...
               linspace(0,1,obj.num));
        end
        function map = kbogw(obj)
            c = [0   0   0;
                 0   0   1;
                 1   .3  0;
                 0   1   0;
                 .5   1   .5
                 ];
           map = rgbmap2indgray(...
               interp2(c,1:3,...
               linspace(1,size(c,1),obj.num)'),...
               linspace(0,1,obj.num).^1.5);
        end
        function map = kbgrw(obj)
            c = [0   0   0;
                 0   0   1;
                 0   1   0;
                 1   0   0;
                 1   1   1];
           map = rgbmap2indgray(...
               interp2(c,1:3,...
               linspace(1,size(c,1),obj.num)'),...
               linspace(0,1,obj.num).^1.5);
        end
        function map = krgbw(obj)
            c = [0   0   0;
                 1   0   0;
                 0   1   0;
                 0   0   1;
                 1   1   1];
           map = rgbmap2indgray(...
               interp2(c,1:3,...
               linspace(1,size(c,1),obj.num)'),...
               linspace(0,1,obj.num));
        end
        function map = kbgryw(obj)
            c = [0   0   0;
                 0   0   1;
                 0   1   0;
                 1   .1  .1;
                 1   1   0; 
                 1   1   1];
           map = rgbmap2indgray(...
               interp2(c,1:3,...
               linspace(1,size(c,1),obj.num)'),...
               linspace(0,1,obj.num));
        end
        function map = kbgroyw(obj)
            c = [0   0   0;
                 0   0   1;
                 0   1   0;
                 1   0   0;
                 1   .4  0;
                 1   1   0; 
                 1   .6   .6];
           map = rgbmap2indgray(...
               interp2(c,1:3,...
               linspace(1,size(c,1),obj.num)'),...
               linspace(0,1,obj.num));
        end
        function map = kbrgw(obj)
            c = [0   0   0;
                 0   0   1;
                 1   0   0;
                 0   1   0;
                 1   1   1
                 ];
           map = rgbmap2indgray(...
               interp2(c,1:3,...
               linspace(1,size(c,1),obj.num)'),...
               linspace(0,1,obj.num));
        end
        function map = kgbryw(obj)
            c = [0   0   0;
                 0   1   0;
                 0   0   1;
                 1   .1  .1;
                 1   1   0; 
                 1   1   1];
           map = rgbmap2indgray(...
               interp2(c,1:3,...
               linspace(1,size(c,1),obj.num)'),...
               linspace(0,1,obj.num));
        end
        function map = Length(obj)
            c = [0   0   1; 
                 1   0   1;                                  
                 1   .5   0;
                 1   1    0;
                 0   1   0;                 
                 ];
           map = interp2(c,1:3,...
               linspace(1,size(c,1),obj.num-1)');
           map = obj.rgbmap2value(map,.5);
           map = cat(1,obj.Gray,map);
        end
        function map = Diameter(obj)
            map = GetColorChannels(obj.num-1);
            map = obj.rgbmap2value(map,.5);
            map = cat(1,obj.Gray,map);
        end
        function map = SNR(obj)
            map = hsv(obj.num-1);
            map = obj.rgbmap2value(map,.6);
            map = cat(1,obj.Gray,map);
        end
        
        function map = kjetw(obj)
            map = kjetw(obj.num);
        end
        function map = kflipjetgray(obj)
            map = [0 0 0;
                flip(jet(obj.num-2),1);
                .5 .5 .5];
        end
        function map = rgbmap2value(~,RGB,r)
            HSV = rgb2hsv(RGB);            
            HSV(:,3) = linspace(0.3,1,size(RGB,1));
            if r == 1
            else
                HSV(:,3) = HSV(:,3).^r;
            end
            map = hsv2rgb(HSV);
        end
        function map = class_map(~)
            map = [...
                    0 0 0;
                    0 0 .8;
                    0 .8 0;
                    .7 .7 .7;
                    .9 .5 0 ;
                    .8 0 0];
        end
    end
end