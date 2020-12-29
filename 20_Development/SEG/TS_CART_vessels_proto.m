function TS_CART_vessels_proto(SEG)
%% Create New Class as CARTclass
CARTclass = {...
    'Capillaries',...
    'Arterial Capillaries+1',...
    'Arterial Capillaries+2',...
    'Arterial Capillaries+3',...
    'Venous Capillaries+1',...
    'Venous Capillaries+2',...
    'Venous Capillaries+3',...
    'Penetrating Veessels',...
    'Penetrating Arterial Vessels',...
    'Penetrating Venous Vessels',...
    'Vessels on Surface',...
    'Arterial Vessels on Surface',...
    'Venous Vessels on Surface',...
    'Bold of Deep Vessels',....
    'Fake Vessels',...
    'Unknown CART class'};

Sf = Segment_Functions;
SNRdBLim = 2; %dB 
CapLim = 8; %um
% VesselsDiameterType = 'JustAverage';
VesselsDiameterType = 'ExceptJointArea';
JointAreaR = 5; %um

Pdata = SEG.Pointdata;
Reso = SEG.ResolutionXYZ;

%% SNR limit
for n = 1:length(Pdata)
    S = Pdata(n).Signal;
    N = Pdata(n).Noise;
    D = Pdata(n).Diameter;
    SNR = 10*log10(S./N);
    SNR_TF = SNR < SNRdBLim;
    D(SNR_TF) = nan;
    Pdata(n).Diameter = D;
    switch VesselsDiameterType
        case 'JustAverage'
            AD = nanmean(D);
        case 'ExceptJointArea'
            xyz = Pdata(n).PointXYZ;
        otherwise
            error('Error in Average Caliculator method...')
    end
    clear SNR S N D SNR_TF
end

%% 1st Capillaries check



