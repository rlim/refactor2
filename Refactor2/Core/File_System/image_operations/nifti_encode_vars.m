function n = nifti_encode_vars()
%
%    Most distributions have a number of parameters denoted by p1, p2, and p3, and stored in
%        - intent_p1, intent_p2, intent_p3 if dataset doesn't have 5th dimension
%        - image data array                if dataset does have 5th dimension
%
%       Formulas for and discussions of these distributions can be found in the following books:
%
%        [U] Univariate Discrete Distributions,         	NL Johnson, S Kotz, AW Kemp.
%        [C1] Continuous Univariate Distributions, vol. 1,	NL Johnson, S Kotz, N Balakrishnan.
%        [C2] Continuous Univariate Distributions, vol. 2,	NL Johnson, S Kotz, N Balakrishnan.   
%
%   emulate C #DEFINE      usage: NIFTI = nifti_encode_vars()   hdr.intent_code = NIFTI.INTENT.NONE

  n = struct( ...  
    'XFORM', 		struct( ...  	
	  'UNKNOWN',      	0, ...		% --- Arbitrary coordinates (Method 1). 
	  'SCANNER_ANAT',	1, ...		% --- Scanner-based anatomical coordinates 
	  'ALIGNED_ANAT', 	2, ...		% --- Coordinates aligned to another file's or to anatomical "truth".
	  'TALAIRACH', 		3, ...		% --- Coordinates aligned to Talairach-Tournoux Atlas (0,0,0)=AC  etc. 
	  'MNI_152', 		4), ...		% --- MNI 152 normalized coordinates.
    'INTENT', 		struct( ...              		
	  'NONE', 		0, ...  
	  'CORREL', 		2, ...
	  'TTEST',		3, ... 
	  'FTEST', 		4, ... 
	  'ZSCORE',		5, ... 
	  'CHISQ',		6, ... 
	  'BETA',		7, ... 
	  'BINOM',		8, ... 
	  'GAMMA',		9, ... 
	  'POISSON',		10, ... 
	  'NORMAL',		11, ... 
	  'FTEST_NONC',		12, ... 
	  'CHISQ_NONC',		13, ... 
	  'LOGISTIC',		14, ... 
	  'LAPLACE',		15, ... 
	  'UNIFORM',		16, ... 
	  'TTEST_NONC',		17, ... 
	  'WEIBULL',		18, ... 
	  'CHI',		19, ... 
	  'INVGAUSS',		20, ... 
	  'EXTVAL',		21, ... 
	  'PVAL',		22, ... 
	  'LOGPVAL',		23, ... 
	  'LOG10PVAL',		24, ... 
	  'NIFTI_FIRST_STATCODE',	2, ... 
	  'NIFTI_LAST_STATCODE',	24, ... 
	  'ESTIMATE',		1001, ... 
	  'LABEL',		1002, ... 
	  'NEURONAME',		1003, ... 
	  'GENMATRIX',		1004, ... 
	  'SYMMATRIX',		1005, ... 
	  'DISPVECT',		1006, ...   	% --- specifically for displacements 
	  'VECTOR',		1007, ...    	% --- for any other type of vector
	  'POINTSET',		1008, ... 
	  'TRIANGLE',		1009, ... 
	  'QUATERNION',		1010, ... 
	  'DIMLESS',		1011, ... 
	  'TIME_SERIES',	2001, ... 
	  'NODE_INDEX',		2002, ... 
	  'RGB_VECTOR',		2003, ... 
	  'RGBA_VECTOR',	2004, ... 
	  'SHAPE',		2005 ), ...
     'UNITS', 		struct( ...                       
	  'UNKNOWN',		0, ... 	
	  'METER',		1, ... 
	  'MM',			2, ... 
	  'MICRON',		3, ...
	  'SEC',		8, ... 	
	  'MSEC',		16, ... 
	  'USEC',		24, ... 
	  'HZ',			32, ... 
	  'PPM',		40, ... 
	  'RADS',		48 ), ... 
     'SLICE', 		struct( ...                       
	  'UNKNOWN',		0, ... 
	  'SEQ_INC',		1, ... 
	  'SEQ_DEC',		2, ... 
	  'ALT_INC',		3, ... 
	  'ALT_DEC',		4, ... 
	  'ALT_INC2',		5, ... 
	  'ALT_DEC2',		6), ...   
     'DT', 		struct( ...
	  'NONE',		0, ... 
	  'UNKNOWN',		0, ...	
	  'BINARY',		1, ...		% --- binary (1 bit/voxel) 
	  'UNSIGNED_CHAR',	2, ...		% --- unsigned char (8 bits/voxel) 
	  'SIGNED_SHORT',	4, ...		% --- signed short (16 bits/voxel)
	  'SIGNED_INT',		8, ...		% --- signed int (32 bits/voxel)
	  'FLOAT',		16, ...		% --- float (32 bits/voxel) 
	  'COMPLEX',		32, ...		% --- complex (64 bits/voxel) 
	  'DOUBLE',		64, ...		% --- double (64 bits/voxel) 
	  'RGB',		128, ...	% --- RGB triple (24 bits/voxel) 
	  'ALL',		255, ...	% --- not very useful (?)
	  'UINT8',		2, ... 		% --- another set of names for the same
	  'INT16',		4, ... 
	  'INT32',		8, ... 
	  'FLOAT32',		16, ... 
	  'COMPLEX64',		32, ... 
	  'FLOAT64',		64, ... 
	  'RGB24',		128, ... 
	  'INT8',		256, ... 	% --- signed char (8 bits) 
	  'UINT16',		512, ...	% --- nsigned short (16 bits)
	  'UINT32',		768, ...	% --- unsigned int (32 bits)
	  'INT64',		1024, ...	% --- long long (64 bits) 
	  'UINT64',		1280, ...	% --- unsigned long long (64 bits)
	  'FLOAT128',		1536, ...	% --- long double (128 bits)
	  'COMPLEX128',		1792, ...	% --- double pair (128 bits)
	  'COMPLEX256',		2048, ...	% --- long double pair (256 bits) 
	  'RGBA32',		2304), ...	% --- 4 byte RGBA (32 bits/voxel)
     'TYPE', 		struct( ...		% --- Aliases for the DT variables
	  'UINT8',		2, ... 		% --- another set of names for the same
	  'INT16',		4, ... 
	  'INT32',		8, ... 
	  'FLOAT32',		16, ... 
	  'COMPLEX64',		32, ... 
	  'FLOAT64',		64, ... 
	  'RGB24',		128, ... 
	  'INT8',		256, ... 	% --- signed char (8 bits) 
	  'UINT16',		512, ...	% --- unsigned short (16 bits)
	  'UINT32',		768, ...	% --- unsigned int (32 bits)
	  'INT64',		1024, ...	% --- long long (64 bits) 
	  'UINT64',		1280, ...	% --- unsigned long long (64 bits)
	  'FLOAT128',		1536, ...	% --- long double (128 bits)
	  'COMPLEX128',		1792, ...	% --- double pair (128 bits)
	  'COMPLEX256',		2048, ...	% --- long double pair (256 bits) 
	  'RGBA32',		2304), ...	% --- 4 byte RGBA (32 bits/voxel)
     'ORIENT', 		struct( ...
	  'L2R',		1, ... 		% --- Left to Right 
	  'R2L',		2, ... 		% --- Right to Left
	  'P2A',		3, ... 		% --- Posterior to Anterior
	  'A2P',		4, ... 		% --- Anterior to Posterior
	  'I2S',		5, ... 		% --- Inferior to Superior 
	  'S2I',		6) ...		% --- Superior to Inferior
  );

