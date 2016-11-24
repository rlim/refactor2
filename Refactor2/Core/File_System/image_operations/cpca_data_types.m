function dtypes = cpca_data_types()
% ------------------------------------
% --- original analyze 7.5 data type codes
% ---
% --- codes > 128 are nifti codes
% --- analyze 7.5 has no binary code

  fields = {'nifti', 'analyse', 'bits', 'code', 'conversion'};
	%														converted code
    % nifti    			analyse 		bits   	code	( 0 means no conversion )
  specs = [ ...
    [{'UNKNOWN'} 		{'UNKNOWN'}	 	 0	   0 		 0 ]; ...
    [{'BINARY'} 		{''}		 	 1	   1		 1 ]; ...
    [{'UCHAR'} 			{'UINT8'}	 	 8	   2		 2 ]; ...
    [{'SIGNED_SHORT'} 	{'INT16'}  		 16	   4 		 4 ]; ...
    [{'SIGNED_INT'}   	{'INT32'}		 32	   8		 8 ]; ...
    [{'FLOAT'}   		{'FLOAT32'}		 32	  16 		16 ]; ...
    [{'COMPLEX'}  		{'COMPLEX64'}	 64	  32 		 0 ]; ...
    [{'DOUBLE'}  		{'FLOAT64'}		 64	  64 		64 ]; ...
    [{'RGB'}  			{'RGB24'}		 24	 128 		 0 ]; ...
    [{'INT8'}  			{''}			  8	 256 		 2 ]; ...
    [{'UINT16'}  		{''}			 16	 512 		 0 ]; ...
    [{'UINT32'}  		{''}			 32	 768 		 0 ]; ...
    [{'INT64'}  		{''}			 64	1024 		 0 ]; ...
    [{'UINT64'}  		{''}			 64	1280 		 0 ]; ...
    [{'FLOAT128'} 		{''}			128	1536 		 0 ]; ...
    [{'COMPLEX128'}		{''}			128	1792 		 0 ]; ...
    [{'COMPLEX256'}  	{''}			256	2048 		 0 ]; ...
    [{'RGBA32'}  		{''}			 32	2304 		 0 ] ];
 
  dtypes = cell2struct( specs, fields, 2 );

 measurement = [ ...
  [ 0 				{'?'}			{'Measurement invalid'}]; ...
  [ 1 				{'M'}                   {'Meters'}]; ...
  [ 2 				{'mm'}                  {'Millimeters'} ]; ...
  [ 3 				{'um'}			{'micrometers'} ]; ...
  [ 8 				{'seconds'}		{'seconds'} ]; ...
  [16 				{'ms'}   		{'milliSeconds'} ]; ...
  [24 				{'um'}			{'microseconds'} ]; ...
  [32				{'Hz'}		 	{'hertz'} ]; ...
  [40				{'ppm'}		 	{'parts per million'} ]; ...
  [48 				{'rad'}			{'radians'} ]];
