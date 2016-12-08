classdef Participant < handle
	%PARTICIPANT Summary of this class goes here
	%   Detailed explanation goes here
	
	properties(GetAccess=public, SetAccess=private)
		%% participant info
		id = '';
		subject_no;
		experiment;
		num_runs = 0;
		conditions_list;
		%% scan info
		run_dir;
		num_scans = 0;
		num_columns = 0;
		
		%% Z info
		path_to_Z_raw = '';
		path_to_Z_std = '';
		tsum_w_trends = 0;
		tsum = 0;
		SSE;
		%% G info
		path_to_G_raw = '';
		path_to_G_norm = '';
		path_to_G_summary = '';
		rank_G = 0;
		
		%% G_regress_info
		path_to_GZ = '';
		GC_stand_dev = 0;
	end
	properties(Constant)
		CommonData = SharedData;
	end
	methods
		%% constructor
		function par = Participant(id, experiment, subj_no)
			if nargin == 3
				par.id = id;
				par.experiment = experiment;
				par.subject_no = subj_no;
				add_participant(experiment, par);
				par.CommonData.ID_List = unique([par.CommonData.ID_List; {par.id}]);
			else
				error('Participant must have an ID, experiment and subject number');
			end
		end
		
		%% setters

		function set_path_to_G_raw(par, String)
			par.path_to_G_raw = String;
		end
		function set_path_G_norm(par, str) 
			par.path_to_G_norm = str;
		end
		function set_rank_G(par, r)
			par.rank_G = r;
		end
		function set_run_dirs(par, rd)
			par.run_dir = strvcat(par.run_dir,rd); %#ok<DSTRVCT>
			set_num_runs(par);
		end
		function set_num_runs(par)
			par.num_runs = size(par.run_dir,1);
		end
		function set_num_scans(par, ns)
			par.num_scans = ns;
			par.CommonData.total_scans = par.CommonData.total_scans +ns;
		end
		function set_num_columns(par, nc)
			par.num_columns = nc;
		end
		function set_path_to_Z_raw(par, pZ)
			par.path_to_Z_raw = pZ;
		end
		function set_path_to_Z_std(par, psZ)
			par.path_to_Z_std = psZ;
		end
		function set_tsum_w_trends(par, twt)
			par.tsum_w_trends = par.tsum_w_trends + twt;
			par.CommonData.tsum_w_trends =  par.CommonData.tsum_w_trends + twt;
		end
		function inc_tsum_trends(par, tt)
			par.CommonData.tsum_trends = par.CommonData.tsum_trends +tt;
		end
		function inc_tsum(par, t)
			par.tsum = par.tsum+t;
			par.CommonData.tsum = par.CommonData.tsum+t;
		end
		function set_SSE(par, sse)
			par.SSE = sse;
		end
		function set_conditions_list(par, cl)
			for i = 1:par.num_runs
				par.conditions_list = [par.conditions_list;{cl}];
			end
		end
		function set_conditions_list_per_run(par, cl, run)
			par.conditions_list{run} = cl;
			
		end
		function set_path_to_G_summary(par, gs)
			par.path_to_G_summary = gs;
		end
		
		function set_GC_stand_dev(par, gcsd)
			par.GC_stand_dev = [par.GC_stand_dev;gcsd];
		end
		function set_path_to_GZ(par, gz)
			
			par.path_to_GZ = gz;
		end
		function set_common_data(par, cd) 
			par.CommonData.ID_List = cd.ID_List;
			par.CommonData.tsum_w_trends = cd.tsum_w_trends;
			par.CommonData.tsum_trends = cd.tsum_trends;
			par.CommonData.tsum = cd.tsum;
			par.CommonData.total_scans = cd.total_scans;
			
		end
		%% getters
		function output = getExperiment(par)
			output = par.experiment;
		end
		function output = get_num_runs(par)
			output = par.num_runs;
		end
		function output = get_run_dir(par)
			output = par.run_dir;
		end
		function output = getID(par)
			output = par.id;
		end
		function output = get_ID_list(par)
			output = par.CommonData.ID_List;
		end
		function output = get_num_scans(par)
			output = par.num_scans;
		end
		function output = get_num_columns(par)
			output = par.num_columns;
		end
		function output = get_path_to_Z_raw(par)
			output = par.path_to_Z_raw;
		end
		function output = get_full_path_to_segs(par, run_no)
			output = [get_path_to_segs(par.experiment) filesep par.run_dir(run_no, :)];
		end
		function output = get_common_data(par)
			output = par.CommonData;
		end
		function output = get_conditions_list(par)
			output = par.conditions_list;
		end
		function output = get_run_id(par, run_no) 
			split = strsplit(par.run_dir(run_no, :),filesep);
			output = split{end};
		end
		function output = get_run_list(par)
			output = cell(par.num_runs, 1);
			for i = 1:par.num_runs
				output{i} = get_run_id(par, i);
			end
			
		end
		function output = get_cond_id(par, run_no, cond)
			condition_run = par.conditions_list{run_no};
			output =  condition_run{cond};
		end
		
		function output = get_path_to_G_raw(obj)
			output = obj.path_to_G_raw;
		end
		function output = get_Z(obj)
			if(~isempty(obj.path_to_Z_std))
				output = obj.path_to_Z_std;
			elseif(~isempty(obj.path_to_Z_raw))
				output = obj.path_to_Z_raw;
			else 
				disp('No Z recorded');
				output = '';
			end
		end
		function output = get_G(obj)
			if(~isempty(obj.path_to_G_norm))
				output = obj.path_to_G_norm;
			elseif(~isempty(obj.path_to_G_raw))
				output = obj.path_to_G_raw;
			else
				disp('No G recorded');
				output = '';
			end
		end
		function output = get_gg(par)
			gg = load(par.path_to_G_summary, 'gg');
			output = gg.gg;
		end
		
		function remove_experiment(par)
			par.experiment = [];
		end
		function output = get_path_to_GZ(par)
			output = par.path_to_GZ;
		end
		
		function output = get_subject_B(par)
			load(par.path_to_GZ, 'B');
			output = zeros(size(B{1,1}));
			for i = 1:size(B,1)
				output = output + B{i, 1};
			end
		end
		function output = get_total_scans(par)
			output = par.CommonData.total_scans;
		end
		
	end
end


