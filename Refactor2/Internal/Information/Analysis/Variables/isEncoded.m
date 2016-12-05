function encoded = isEncoded( subject, condition )
  global Zheader scan_information

  x = []; 
  for ii = 1:Zheader.num_runs
    if iscellstr( scan_information.SubjDir(subject, ii ) )      
      x = [x Zheader.conditions.subject(subject).Run(ii).conditions]; 
    end;
  end;
  x = unique(x);

  encoded = any(x == condition );

