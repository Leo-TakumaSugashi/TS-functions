classdef Sugashi_basicdata_class
    properties
        Name(1,:) char ='test'
        Image(:,:,:,:,:) {mustBeNumeric}
        Resolution(1,3) {mustBeGreaterThan(Resolution,0)} = ones(1,3)
    end
    methods 
        function test_function(obj)
            disp('This is Basic data stucture for volume Image.')
        end
    end
end
