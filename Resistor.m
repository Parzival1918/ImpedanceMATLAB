classdef Resistor < CircuitComponents
    properties
        Resistance {mustBeNumeric} = 1
        Units char {mustBeMember(Units,{'kohm','ohm','mohm','uohm'})} = 'ohm'
    end
    properties (Access = private)
        mult = 1;
    end
    methods
        function comp = cell(obj)
            comp = cell([1 3]);
            comp{1} = 'R';
            comp{2} = obj.Resistance;
            comp{3} = obj.Units;
        end
        function z = Impedance(obj,~) %Will always be given in ohm
            z = obj.Resistance*obj.mult; 
        end
        function obj = SetUnits(obj,unit)
            obj.Units = unit;
            obj.mult = multiplier(unit);
        end
        function obj = Resistor(val,unit)
            if nargin == 1
                obj.Resistance = val;
            elseif nargin == 2
                obj.Resistance = val;
                obj.Units = unit;
                obj.mult = multiplier(unit);
            end
        end
    end
end

function m = multiplier(u)
    switch u
        case 'kohm'
            m = 1e3;
        case 'ohm'
            m = 1;
        case 'mohm'
            m = 1e-3;
        case 'uohm'
            m = 1e-6;
    end
end