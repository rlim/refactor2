function endian = isBigendian()
% -----------------------------------------------
% borrowed from SPM spm_platform( 'bigend' )
% will determine if running system is big endian or not
% returning 0 or 1
% -----------------------------------------------

  PDefs = {	'PCWIN',	'win',	0;...
		'PCWIN64',	'win',  0;...
		'MAC',		'unx',	1;...
		'MACI',		'unx',	0;...
		'MACI64',	'unx',	0;...
		'SUN4',		'unx',	1;...
		'SOL2',		'unx',	1;...
		'HP700',	'unx',	1;...
		'SGI',		'unx',	1;...
		'SGI64',	'unx',	1;...
		'IBM_RS',	'unx',	1;...
		'ALPHA',	'unx',	0;...
		'AXP_VMSG',	'vms',	Inf;...
		'AXP_VMSIEEE',	'vms',	0;...
		'LNX86',	'unx',	0;...
		'GLNX86',	'unx',  0;...
		'GLNXA64',      'unx',  0;...
		'VAX_VMSG',	'vms',	Inf;...
		'VAX_VMSD',	'vms',	Inf	};

  PDefs = cell2struct(PDefs,{'computer','filesys','endian'},2);
  comp = computer;

  ci = find(strcmp({PDefs.computer},comp));
  if isempty(ci), error([comp,' not supported architecture']), end;

  endian = PDefs(ci).endian;

