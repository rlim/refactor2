classdef Experiment < handle
    
    properties (GetAccess=public, SetAccess=private) %%read only access
        %% experiment info
        name = '';
        participants;
        no_participant;
        cond_names;
        tb_based = 1;
        bins = 0;
        TR = 1;
        displacement = 1.500;
        mean_tr = 0;
        in_scans = 1;
        group_list = [];
		is_FIR = 1;
        
        
        %% scan info
        path_to_segs = '';
        list_spec = '';
        scandir_format;
    end
    methods
        
        %% Constructor
        function exp = Experiment(name)
            if nargin ==1
                exp.name = name;
            else
                error('Experiment must have a name');
            end
        end
        
        %% Setter Methods
        function set_no_bins(obj, bin_no)
            obj.bins = bin_no;
        end
        function set_TR(obj, TR_no)
            obj.TR = TR_no;
        end
        function set_no_participants(obj, no_participants)
            obj.no_participant = no_participants;
        end
        function set_in_scans(obj, scans)
            obj.in_scans = scans;
        end
        function set_group_list(obj, gl)
            obj.group_list = gl;
        end
        function set_path_to_segs(obj, sd)
            obj.path_to_segs = sd;
        end
        function set_list_spec(obj, ls)
            obj.list_spec = ls;
        end
        function set_scandir_format(obj, sf)
            obj.scandir_format = sf;
		end
		function set_cond_names(obj, cn)
			obj.cond_names=cn;
		end
		function set_mean_tr(obj, mt)
			obj.mean_tr = mt;
		end
        
        %% Getter Methods
        function output = get_list_spec(obj)
            output = obj.list_spec;
        end
        function output = get_no_bins(obj)
            output = obj.bins;
        end
        function output = get_TR(obj)
            output = obj.TR;
        end
        function output = get_participants(obj)
            output = obj.participants;
        end
        function output = get_cond_names(obj)
            output = obj.cond_names;
        end
        function output = get_path_to_segs(obj)
            output = obj.path_to_segs;
		end
		function output = get_is_FIR(obj)
			output = obj.is_FIR;
		end
		function output = get_in_scans(obj)
			output = obj.in_scans;
		end
		function output = get_displacement(obj)
			output = obj.displacement;
		end
		function output = get_experiment_name(obj)
			output = obj.name;
		end
        %% Methods
        function add_participant(obj, participant)
            obj.participants = [obj.participants; participant];
        end
		function remove_participants(obj)
			for i = 1:size(obj.participants,1)
				remove_experiment(obj.participants(i));
			end
			obj.participants = [];
		end
        
        
    end
end
