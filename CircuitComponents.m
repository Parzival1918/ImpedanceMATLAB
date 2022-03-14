classdef CircuitComponents
    methods
        function zTot = SumImpedances(type,f,varargin)
            arguments
                type {mustBeMember(type,{'series','parallel'})} 
                f double
            end
            arguments (Repeating)
                varargin
            end

            if type == "series"
                zTot = 0;
                for element = 1:length(varargin)
                    if ismember(class(varargin{element}),['Resistor','Capacitor','Inductor'])
                        zTot = zTot + varargin{element}.Impedance(f);
                    else
                        zTot = zTot + varargin{element};
                    end        
                end
            elseif type == "parallel"
                zTot = 0;
                for element = 1:length(varargin)
                    if element == 1
                        if ismember(class(varargin{element}),['Resistor','Capacitor','Inductor'])
                            zTot = ((varargin{element}.Impedance(f))^-1)^-1;
                        else
                            zTot = ((varargin{element})^-1)^-1;
                        end
                    else
                        if ismember(class(varargin{element}),['Resistor','Capacitor','Inductor'])
                            zTot = ((zTot)^-1 + (varargin{element}.Impedance(f))^-1)^-1;
                        else
                            zTot = ((zTot)^-1 + (varargin{element})^-1)^-1;
                        end
                    end
                end
            end
        end
    end
end