function TS_WaiteProgress_v2(p,varargin)
% TS_WaitProgress_v2(P,B)
%    P : progress
%    B : brefor 1 step
% 
% example....
% Max = 10000;
% for n = 0:Max
%     TS_WaiteProgress_v2(n/Max,(n-1)/Max)
%     pause(0.002)
% end
        


STR = [num2str(p*100,'%.1f') '%%'];
if length(STR) == 4
    STR = ['   ' STR];
elseif length(STR) == 5
    STR = ['  ' STR];
else
    STR = [' ' STR];
end

if nargin ==2 
    b = varargin{1};
else
    b = nan;
end

FloorP = floor(p*20);
FloorB = floor(b*20);
if b <= 0
    GO = true;    
else
    if FloorP == FloorB
        GO = false;
    else
        GO = true;
    end
end
if ~GO
    if round(1000*p) == round(1000*b)
        return
    end
    fprintf(['\b\b\b\b\b\b',STR])
    return
end

if floor(p*1e5)>=1e5
    PROGRESSBAR = '--->>>>>\r\t[####################]';
elseif FloorP>19
    PROGRESSBAR = '[################### ]';
elseif FloorP>18
    PROGRESSBAR = '[##################  ]';
elseif FloorP>17
    PROGRESSBAR = '[#################   ]';
elseif FloorP>16
    PROGRESSBAR = '[################    ]';
elseif FloorP>15
    PROGRESSBAR = '[###############     ]';
elseif FloorP>14
    PROGRESSBAR = '[##############      ]';
elseif FloorP>13
    PROGRESSBAR = '[############        ]';
elseif FloorP>12
    PROGRESSBAR = '[###########         ]';
elseif FloorP>11
    PROGRESSBAR = '[##########          ]';
elseif FloorP>9
    PROGRESSBAR = '[#########           ]';
elseif FloorP>8
    PROGRESSBAR = '[########            ]';
elseif FloorP>7
    PROGRESSBAR = '[#######             ]';
elseif FloorP>6
    PROGRESSBAR = '[######              ]';
elseif FloorP>5
    PROGRESSBAR = '[#####               ]';
elseif FloorP>4
    PROGRESSBAR = '[####                ]';
elseif FloorP>3
    PROGRESSBAR = '[###                 ]';
elseif FloorP>2
    PROGRESSBAR = '[##                  ]';
elseif FloorP>1
    PROGRESSBAR = '[#                   ]';
else
    PROGRESSBAR = '[                    ]';
end
if p ~= 0
    fprintf('\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b')
    drawnow
else
    fprintf('Progress : ')
end
fprintf([PROGRESSBAR STR])
if p == 1
    fprintf(' DONE.\n')
end


