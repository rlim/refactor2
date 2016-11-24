function Z = load_subject_run_Z( SubjectNo, RunNo, ftag, ex_dir );
global  Zheader scan_information

  if nargin < 2
    RunNo = 1;
  end;
  if nargin < 3
    ftag = '';
  end;
  if nargin < 4
    ex_dir = [];
  end;

  Z = zeros( sum(Zheader.timeseries.subject(SubjectNo).run(RunNo,1)), Zheader.total_columns);
  
  if isempty( ex_dir )
    Normalized_Z_Dir = Z_Directory();
  else
    Normalized_Z_Dir = ex_dir;
  end
  
  ZName = [ Normalized_Z_Dir 'Z' filesep 'Z' num2str(SubjectNo) ftag '.mat'];

  if ~isempty( ftag )
    n = matfile_vars( [Normalized_Z_Dir 'Z' filesep], ['Z' num2str(SubjectNo) ftag '.mat'], 'Z_R1_C1*' );
    if isempty(n)
      ZName = [ Normalized_Z_Dir 'Z' filesep 'Z' num2str(SubjectNo) '.mat'];
    end;
  end;

  if iscellstr( scan_information.SubjDir(SubjectNo, RunNo ) )

    end_col = 0;
    for column = 1:Zheader.partitions.count

      start_col = end_col + 1;
      end_col = start_col + Zheader.partitions.columns(column) - 1;
      eval ( [ 'load( ZName, ''Z_R' num2str(RunNo) '_C' num2str(column) ftag ''');'] );
%      eval ( [ 'end_col = start_col + size(Z_R' num2str(RunNo) '_C' num2str(column) ftag ',2) - 1;' ] );

      try 
        eval ( [ 'Z(:,start_col:end_col) = Z_R' num2str(RunNo) '_C' num2str(column) ftag ';' ] );
      catch e
          x = 1;
      end;

      clear Z_R*;
    end; 
  end; 

end


