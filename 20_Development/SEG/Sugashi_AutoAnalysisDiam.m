classdef Sugashi_AutoAnalysisDiam
    properties
        Version = '1.0'
        Image(:,:,:,:,:)
        Image3D(:,:,:)
        Resolution(1,3)
        Threshold_Type(1,:) char {mustBeMember(Threshold_Type,{'sp5','sp8'})} = 'sp5'
        SEG
        ROI_Length(1,1) = 70; %% um
    end
    methods
    end
end




