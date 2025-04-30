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
        function map = Favorit(obj,varargin)
            if nargin ==2
                obj.num = varargin{1};
            end
            c = [0 0 0 ;
                 0.1 0.3 1;
                 0   1   1;
                 0   1   0;
                 0.8 1   0;
                 1   1   0;
                 1   0.3  0];
%            map = obj.Interp_mapnum(c);
           map = rgbmap2indgray(...
               interp2(c,1:3,...
               linspace(1,size(c,1),obj.num)'),...
               linspace(0,0.9,obj.num));
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
        function map = Interp_mapnum(obj,c)
            [X,Y] = meshgrid(1:3,linspace(1,size(c,1),obj.num));
            map = interp2(c,X,Y);
        end
        function map = class_map(~)
            map = [...
                    0.4 0.4 0.4; % others
                    0 .85 0; %Parent
                    1 .0 1; % Vein
                    .0 .9 1; % SV
                    .1 .2 .9; % PV
                    .8 .8 .8; % Cap.
                    1 .4 0 ; % PA
                    1 1 0; % SA
                    1 .15 0];% Art.
        end
        function varargout = AddClassColorbar(~,varargin)
            if nargin ==2
                axh = varargin{1};
            else
                axh = gca;
            end
%             Posi = [0.9 0.1 0.02 0.5]; % Vertical
            Posi = [.4 .15 .5 .02]; % Horizontal

            coh = colorbar(axh,'SouthOutside');
            coh.Position = Posi;
            
            L = cell(9,1);
            L{1} = 'others';
            L{2} = 'Parent';
            L{3} = 'Vein';
            L{4} = 'Surface Vein';
            L{5} = 'Penetrating Vein';
            L{6} = 'Capillary';
            L{7} = 'Penetrating Artery';
            L{8} = 'Surface Artery';
            L{9} = 'Artery';
            coh.TickLabels = L;
            coh.TickDirection = 'out';
            coh.FontSize = 12;
            coh.FontWeight = 'bold';
            coh.Ruler.TickLabelRotation = -40;
            coh.Ticks = -5:3;

            coh.Label.FontName = 'Arial';
            caxis(axh,[-5.5 3.5])

            if nargout ==1
                varargout{1} = coh;
            end
        end
        function map = class_map_old(~)
            map = [...
                    0 0 0;
                    0 0 .8;
                    0 .8 0;
                    .7 .7 .7;
                    .9 .5 0 ;
                    .8 0 0];
        end
        function Set_DistanceMap_fromAV(obj,axh,Lim)
            % Set_DistanceMap_fromAV(axes_handle, Color_Lim)
            %    axes_handle : axes handle or figure handle
            %    Color_Lim   : color limit , [Min. , Max.]
            %                  Max is number of Art.
            %                  Min is number of Vein.
            Anum = ceil(Lim(2));
            Vnum = abs(floor(Lim(1)));
            [a,v] = obj.DistanceMap_fromAV(Anum,Vnum);

            caxis(axh,[-Vnum-.5, Anum+.5])

            colormap(axh,cat(1,v,a))
        end
        function [Amap,Vmap] = DistanceMap_fromAV(~,Anum,Vnum)
            GUI = Sugashi_GUI_support;
            Map = GUI.create_MAPs(512,1);

            vx = 1:65;
            vy = round([linspace(512,510,17), linspace(512,412,65-17)]);

            ax = 131:-1:66;
            ay = round(linspace(256,512,length(ax)));

            Amap = zeros(length(ax),3);
            Vmap = zeros(length(vx),3);

            for n = 1:length(ax)
                a = Map(ay(n),ax(n),:);
                Amap(n,:) = reshape(a,1,[]);
            end
            for n = 1:length(vx)
                a = Map(vy(n),vx(n),:);
                Vmap(n,:) = reshape(a,1,[]);
            end
            
            Vmap(1:17,:) = interp2(cat(1,[0.9 0.4 1],Vmap(17,:)),...
                1:3,(linspace(1,2,17))');
            

            Amap = interp2(Amap,1:3,(linspace(1,length(ax),Anum))');
            Vmap = interp2(Vmap,1:3,(linspace(1,length(vx),Vnum))');
            Vmap = flip(Vmap,1);
            
            HSV = rgb2hsv(Vmap);
            HSV(:,3) = (cos(linspace(pi*43/100,-pi/3,size(Vmap,1))))';
            Vmap = hsv2rgb(HSV);

            HSV = rgb2hsv(Amap);
            HSV(:,3) = (cos(linspace(pi/24,pi*7/24,size(Amap,1))))';
            Amap = hsv2rgb(HSV);
        end
    end
end
