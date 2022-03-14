classdef Inductor < CircuitComponents
    properties
        Inductance {mustBeNumeric} = 1
        Units char {mustBeMember(Units,{'kH','H','mH','uH'})} = 'H'
    end
    properties (Access = private)
        mult = 1;
    end
    methods
        function comp = cell(obj)
            comp = cell([1 3]);
            comp{1} = 'I';
            comp{2} = obj.Inductance;
            comp{3} = obj.Units;
        end
        function r = Impedance(obj,f) %Will always be given in ohm
            w = 2*pi*f;
            r = obj.mult*obj.Inductance*1i*w;
        end
        function obj = SetUnits(obj,unit)
            obj.Units = unit;
            obj.mult = multiplier(unit);
        end
        function obj = Inductor(val,unit)
            if nargin == 1
                obj.Inductance = val;
            elseif nargin == 2
                obj.Inductance = val;
                obj.Units = unit;
                obj.mult = multiplier(unit);
            end
        end
    end
end
function m = multiplier(u)
    switch u
        case 'kH'
            m = 1e3;
        case 'H'
            m = 1;
        case 'mH'
            m = 1e-3;
        case 'uH'
            m = 1e-6;
    end
end