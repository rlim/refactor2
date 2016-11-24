function Create_Predictors(u,d, ana)
participants = get_participants(ana);
snr = sqrt(get_total_scans(participants(1)));
P = cell(size(participants, 1), 1);
U = cell(size(participants, 1), 1);
V = cell(size(participants, 1), 1);
sp = 1;
for i = 1:size(participants, 1)
	gg = get_gg(participants(i));
	ep = sp+size(gg,1)-1;
	P_subj = snr*gg*u(sp:ep, 1:end);
	P{i,1} = P_subj;
	U_subj = get_full_g(participants(i))*P_subj;
	U{i,1} = U_subj;
	V_subj = get_subject_B(participants(i))' * u(sp:ep, 1:end)./snr;
	V{i, 1} = V_subj;
	sp = sp+size(gg, 1);
end
if ~exist([pwd filesep 'G'], 'dir')
	mkdir([pwd filesep 'G']);
end
d = sqrtm(d);
save([pwd filesep 'G' filesep 'Extract_G'], 'P', 'U', 'V', 'd');

end
function G = get_full_g(participant)
	subj_g = get_G(participant);
	G = [];
	for i =1:size(subj_g,1)
		G = [G;subj_g(i,1)];
	end
end