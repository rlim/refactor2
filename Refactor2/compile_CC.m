function [u,d,v] = compile_CC(analysis)
participants = get_participants(analysis);


%  primary row/column positions
p_start = 1; p_end = 0;
%  secondary row/column positions
sr_start = 1; sc_start = 1;
CC = 0;
for i =1:size(participants,1)
	B = get_subject_B(participants(i));
	BB = B*B';
	p_end = p_end + size(BB, 1);
	CC(p_start:p_end, p_start:p_end) = BB;
	prev_col = size(BB,2);
	prev_row = size(BB,1);
	
	for j=i+1:size(participants,1)
		SecB = get_subject_B(participants(j));
		Primary_By_Secondary = B*SecB';
		Secondary_By_Primary = SecB*B';
	    sc_start = sc_start + prev_col;
        sc_end = sc_start + size(Primary_By_Secondary, 2) -1;
        CC(p_start:p_end, sc_start:sc_end) = Primary_By_Secondary;
	    sr_start = sr_start + prev_row;
        sr_end = sr_start+size(Secondary_By_Primary,1)-1;    
		CC(sr_start:sr_end, p_start:p_end) = Secondary_By_Primary;
		prev_col = size(Primary_By_Secondary, 2);
		prev_row = size(Secondary_By_Primary, 1);
	end
    p_start = p_end + 1;
    sc_start = p_start;
    sr_start = p_start;
end
save('CC.mat', 'CC');
[u,d,v] = svds(CC, 20);

end