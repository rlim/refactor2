classdef Analysis < handle
	properties 
		participants;
		experiment_names;
		regress_G=0;
		regress_GA=0;
		regress_GAA=0;
	end
	methods 
		function obj = Analysis(experiments) 
			if (nargin == 1 && ~isempty(experiments))
				obj.experiment_names = experiments;
			else 
				error('Analysis must have at least one experiment');
			end
		end
		
		function add_participants(obj, participants) %participants are a cell grouping
				obj.participants = [obj.participants;participants];
		end
		%% setters 
		function set_regress_G(obj, bool)
			obj.regress_G = bool;
		end
		function set_regress_GA(obj, bool)
			obj.regress_GA = bool;
		end
		function set_regress_GAA(obj, bool)
			obj.regress_GAA = bool;
		end
		
		%% getters 
		function output = get_participants(obj)
			output = obj.participants;
		end
		function output = get_experiment_names(obj)
			output =obj.experiment_names;
		end
		function output = get_regress_G(obj)
			output = obj.regress_G;
		end
	end
end
	