classdef Create_Z_test < matlab.unittest.TestCase
	properties
	end
	
	methods(Test)
		function load_parameters(testCase)
			load('Exp.mat');
			load('mask.mat');
			exp = Create_Z(mask, a);
			testCase.verifyEqual(1, 1);
		end
	end
end
	
	