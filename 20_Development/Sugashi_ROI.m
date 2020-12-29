classdef Sugashi_ROI
    properties
        Label(1,:) char
        Number(1,1) uint32
        handle
        exitTF
        Type % class
        Position
        PlaneDim
        axis1
        axis2
        axis3
        aixs4
        Color
    end 
    methods
        function D  = GetOlderROIdataclass(obj)
             D.handle= [];
             D.Lineobh= [];
             D.existTF= 1;
             D.class= 'impoint';
             D.Position= [78.2465 27.8239];
             D.Plane= 'xy';
             D.Depth= 1;
             D.Time= 1;
             D.Color= [0.6000 0.3000 1];
        end
    end
end
