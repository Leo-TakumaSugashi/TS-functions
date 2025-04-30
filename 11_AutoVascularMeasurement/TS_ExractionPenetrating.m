function output = TS_ExractionPenetrating(Image,Reso)

%% Defolt Coefficient
PenetObjDiamSiz = 10;
PenetObjLen = 50;



if ndims(Image) ~= 3
    error('Input is Not 3 - Dim.')
end
