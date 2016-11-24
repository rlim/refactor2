function retrieve_subject_ZH_run( Hheader, SubjectNo, RunNo);
global  Zheader scan_information

  if nargin < 3
    ftag = '';
  end;

  Z = [];
  H = load_H_matrix( Hheader, SubjectNo );

  for FrequencyNo=1:max(scan_information.frequencies, 1)

    ftag = frequency_tag(FrequencyNo) ;
          
    %------------------------------------------------
    % load in the normalized Z/E segment
    %------------------------------------------------

    Zf = load_subject_run_Z( SubjectNo, RunNo, ftag );
    Z = [Z Zf];

  end;	% --- each frequency range

  assignin( 'caller', 'ZH', Z * H );

