classdef MeasureDiameter_Functions
    properties
        Image(:,:,:,:,:)
        Reso(1,3)
        ThresholdType(1,:) char {mustBeMember(ThresholdType,{'sp5','sp8','fwhm'})} ='fwhm'
        SEG
        %% Options
        ID = '>0'; %% must Be ">0",'all',or numeric
        Progressbar ='on'; %% on or off
        SNRLim = 2; %%[dB]
        SNRUnit = 'dB'; %% if unit is [a.u.], will be calicualte
        SNRLim_dB = []; %% program usage.
        LineLength = 70;
        NoiseType(1,:) char {mustBeMember(NoiseType,{'Eachpoint','Slice','Numeric'})} = 'Eachpoint'; 
        NoiseArea = 100; % um, diameter
        Noise = [];  %% program usage.    
        MeasureType(1,:) char {mustBeMember(MeasureType,...
            {'LineRot','NormLine','Elliptic','Hybrid','Speed','All'})} = 'LineRot'
        ForceParfor(1,:) char {mustBeMember(ForceParfor,{'on','off'})} = 'on'; %% on or off
    end
    methods
    end
end