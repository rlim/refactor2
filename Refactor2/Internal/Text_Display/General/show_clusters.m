function show_clusters( posneg, cl_info, log_fid, fid, tf_display )
% posneg is text 'positive' or 'negative' for display
% cl_info is the cluster.pos|neg list
% log_fid is the fid of the open text logging file
% fid is the fid of the open cluster list full text output file
% tf_display is the name of the full list file
global scan_information
  
  print_header();          
									% all MNI values printed to disk
  peak_max_display = 3;		% maximum number of peak for cluster printed to screen
  this_peak_displayed = 0;

  if isempty(cl_info)
    print_and_log( log_fid, ['No ' posneg ' loadings above threshold \n']);
    if ( fid ), fprintf( fid,['No ' posneg ' loadings above threshold \n']); end;

  else
      
      if ispc() dirchar = '\'; else dirchar = '/'; end;
      ph = which( 'cpca' );             	% -- base path of GUI application
      ph = strrep( ph, 'cpca.m', ['utils' dirchar 'image_operations' dirchar 'talairach.mat'] );
      if exist(ph, 'file')
          tal = load( ph, 'label' );
      else
          tal.label = [];
      end;
      
      formatter = output_definition( 'CLUSTER_FORMAT' );
      region_format = output_definition ('CLUSTER_REGION');%format for non-peak clusters
    for ii = 1:size(cl_info,1) 

      this_peak_displayed = this_peak_displayed + 1;
      if ( this_peak_displayed < peak_max_display )

      fprintf( 1, formatter,  ...
            cl_info(ii).voxels, cl_info(ii).mm3, ...
            cl_info(ii).peak.mni(1), cl_info(ii).peak.mni(2), cl_info(ii).peak.mni(3), ...
            cl_info(ii).peak.value ); 

      end; 

      if ( fid )
         fprintf( fid, formatter, ...
            cl_info(ii).voxels, cl_info(ii).mm3, ...
            cl_info(ii).peak.mni(1), cl_info(ii).peak.mni(2), cl_info(ii).peak.mni(3), ...
            cl_info(ii).peak.value ); 
      end  % -- print cluster list to file ---
      
          if ( size(cl_info(ii).region, 1) > 1 )
            for jj = 1:size(cl_info(ii).region, 1)
              if ( fid )
                if ( ~all(cl_info(ii).peak.mni == cl_info(ii).region(jj).mni ) )
                  str = '';
                  if ~isempty( tal.label ) && ~isempty(scan_information.mask.tal_index ) 
                    x = seek_mask_region_index(  cl_info(ii).region(jj).mni );
                    if x
                      str = char( tal.label( x ) );
                      str = strrep( str, 'Left', 'Left ' ); 
                    end;
                  end;
                  fprintf( fid, region_format, ...
                  cl_info(ii).region(jj).mni(1), cl_info(ii).region(jj).mni(2), cl_info(ii).region(jj).mni(3), ...
                  cl_info(ii).region(jj).value ); 
                  fprintf( fid,  '  %s\n', str ); 
                end  % -- cluster region not peak value ---
              end  % -- print cluster list to file ---

            end;
          end;
    end

    print_and_log( log_fid, ' -- Complete MNI list contained in %s\n\n', tf_display);
  end
      
  function print_header()      
        
    str = ['\nLocal maximum for ' posneg ' part...\n' ];
    print_and_log( log_fid, str );
    fprintf( 1,  output_definition( 'CLUSTER_HEADER' ) );

    if fid
      fprintf( fid, str );
      fprintf( fid,  output_definition( 'CLUSTER_HEADER' ) );
    end
      
  end

end


