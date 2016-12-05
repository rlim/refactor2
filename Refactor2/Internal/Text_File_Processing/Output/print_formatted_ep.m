function print_formatted_ep( ep, component_no, fid, log_fid )

    if log_fid print_and_log( 0, ...
           '\nminimum: %.2f\tmaximum: %.2f\n  abs threshold: %.2f\n   voxels above: %d\npositive voxels: %d\nnegative voxels: %d\n\n', ...
             ep(component_no).minv, ep.maxv, ...
             ep(component_no).percentiles( constant_define( 'PREFERENCES', 'threshold.default' ) ).threshold, ...
             ep(component_no).percentiles( constant_define( 'PREFERENCES', 'threshold.default' ) ).voxels, ...
             ep(component_no).percentiles( constant_define( 'PREFERENCES', 'threshold.default' ) ).pos_voxels, ...
             ep(component_no).percentiles( constant_define( 'PREFERENCES', 'threshold.default' ) ).neg_voxels );
    end;

    if (fid)  
          fprintf( fid, '\n---------------------------------------------------------\nComponent %d\n---------------------------------------------------------\n', component_no);
          fprintf(fid, ...
           '\nminimum: %.2f\tmaximum: %.2f\n  abs threshold: %.2f\n   voxels above: %d\npositive voxels: %d\nnegative voxels: %d\n\n', ...
             ep.minv, ep.maxv, ...
             ep(component_no).percentiles( constant_define( 'PREFERENCES', 'threshold.default' ) ).threshold, ...
             ep(component_no).percentiles( constant_define( 'PREFERENCES', 'threshold.default' ) ).voxels, ...
             ep(component_no).percentiles( constant_define( 'PREFERENCES', 'threshold.default' ) ).pos_voxels, ...
             ep(component_no).percentiles( constant_define( 'PREFERENCES', 'threshold.default' ) ).neg_voxels );
    end;
