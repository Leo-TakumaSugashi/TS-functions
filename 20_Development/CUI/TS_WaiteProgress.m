function TS_WaiteProgress(p)
STR = [num2str(p*100,'%.1f') '%%'];
if length(STR) == 4
    STR = ['   ' STR];
elseif length(STR) == 5
    STR = ['  ' STR];
else
    STR = [' ' STR];
end
if floor(p*1e5)>=1e5
    PROGRESSBAR = '[####################]';
elseif floor(p*20)>19
    PROGRESSBAR = '[################### ]';
elseif floor(p*20)>18
    PROGRESSBAR = '[##################  ]';
elseif floor(p*20)>17
    PROGRESSBAR = '[#################   ]';
elseif floor(p*20)>16
    PROGRESSBAR = '[################    ]';
elseif floor(p*20)>15
    PROGRESSBAR = '[###############     ]';
elseif floor(p*20)>14
    PROGRESSBAR = '[##############      ]';
elseif floor(p*20)>13
    PROGRESSBAR = '[############        ]';
elseif floor(p*20)>12
    PROGRESSBAR = '[###########         ]';
elseif floor(p*20)>11
    PROGRESSBAR = '[##########          ]';
elseif floor(p*20)>9
    PROGRESSBAR = '[#########           ]';
elseif floor(p*20)>8
    PROGRESSBAR = '[########            ]';
elseif floor(p*20)>7
    PROGRESSBAR = '[#######             ]';
elseif floor(p*20)>6
    PROGRESSBAR = '[######              ]';
elseif floor(p*20)>5
    PROGRESSBAR = '[#####               ]';
elseif floor(p*20)>4
    PROGRESSBAR = '[####                ]';
elseif floor(p*20)>3
    PROGRESSBAR = '[###                 ]';
elseif floor(p*20)>2
    PROGRESSBAR = '[##                  ]';
elseif floor(p*20)>1
    PROGRESSBAR = '[#                   ]';
else
    PROGRESSBAR = '[                    ]';
end
if p ~= 0
    fprintf('\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b')
end
fprintf([PROGRESSBAR STR])
if p == 1
    fprintf('\n')
end