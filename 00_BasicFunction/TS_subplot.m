function axh = TS_subplot(fgh,Num,varargin)
% axh = TS_subplot(fgh,Num,(Margin))
Nx = Num(1);
Ny = Num(2);

Margin = 0.01;
if nargin ==3
    Margin = varargin{1};
end
W = (1 - Margin*(Nx*2) )/Nx;
H = (1 - Margin*(Ny*2+1) )/Ny;

c = 1;
for y = Ny:-1:1
    sy = (2*y)*Margin + (y-1)*H;
    for x = 1:Nx
        sx = (2*x-1)*Margin + (x-1)*W;
        axh(c) = axes(fgh,'Position',[sx sy W H]);
        c = c + 1;        
    end
end


