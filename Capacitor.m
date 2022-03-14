classdef Capacitor < CircuitComponents
    properties
        Capacitance {mustBeNumeric} = 1
        Units char {mustBeMember(Units,{'kF','F','mF','uF'})} = 'F'
    end
    properties (Access = private)
        mult = 1;
    end
    methods
        function comp = cell(obj)
            comp = cell([1 3]);
            comp{1} = 'C';
            comp{2} = obj.Capacitance;
            comp{3} = obj.Units;
        end
        function r = Impedance(obj,f) %Will always be given in ohm
            w = 2*pi*f;
            r = (-1i)/(obj.mult*obj.Capacitance*w);
        end
        function obj = SetUnits(obj,unit)
            obj.Units = unit;
            obj.mult = multiplier(unit);
        end
        function obj = Capacitor(val,unit)
            if nargin == 1
                obj.Capacitance = val;
            elseif nargin == 2
                obj.Capacitance = val;
                obj.Units = unit;
                obj.mult = multiplier(unit);
            end
        end
    end
end
function m = multiplier(u)
    switch u
        case 'kF'
            m = 1e3;
        case 'F'
            m = 1;
        case 'mF'
            m = 1e-3;
        case 'uF'
            m = 1e-6;
    end
end