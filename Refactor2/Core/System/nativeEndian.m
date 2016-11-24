function endian = isBigendian()
% -----------------------------------------------
% borrowed from SPM spm_platform( 'bigend' )
% will determine if running system is big endian or not
% returning 0 or 1
% -----------------------------------------------

  ends = [{'ieee-le'} {'ieee-be'} ];

  PDefs = {	'PCWIN',	'win',	1;...
		'PCWIN64',	'win',  1;...
		'MAC',		'unx',	2;...
		'MACI',		'unx',	1;...
		'SUN4',		'unx',	2;...
		'SOL2',		'unx',	2;...
		'HP700',	'unx',	2;...
		'SGI',		'unx',	2;...
		'SGI64',	'unx',	2;...
		'IBM_RS',	'unx',	2;...
		'ALPHA',	'unx',	1;...
		'AXP_VMSIEEE',	'vms',	1;...
		'LNX86',	'unx',	1;...
		'GLNX86',	'unx',  1;...
		'GLNXA64',      'unx',  1 };

  PDefs = cell2struct(PDefs,{'computer','filesys','endian'},2);
  comp = computer;

  ci = find(strcmp({PDefs.computer},comp));
  if isempty(ci), error([comp,' not supported architecture']), end;


  endian = char( ends( PDefs(ci).endian ) );


