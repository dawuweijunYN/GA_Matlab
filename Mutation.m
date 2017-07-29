function [ code_new ] = Mutation( code_old,mu_prob,num_popul,round_ga )
%����������µ��Ӵ���Ⱥ
%--------------------------------------------------------
%	�������
%	code_old:�ӽ��õ����Ӵ���Ⱥ
%   hy_prob:����ĸ�����ֵ
%--------------------------------------------------------
%	�������
%	code_new���������Ӵ���Ⱥ
%--------------------------------------------------------
	prob = rand(1,num_popul);
	[~,index_mutation,~] = find(prob>(1-mu_prob));
	step_mutation = 0.1*0.95^(round_ga/20);
	code_new = code_old;
	if ~isempty(index_mutation)
		for ii = 1:1:length(index_mutation)
			if	rand-0.5>=0
				deri_mutation = 1;
			else
				deri_mutation = -1;
			end
			code_new(:,index_mutation(ii)) = code_old(:,index_mutation(ii))*(1+deri_mutation*step_mutation);
		end
	end
end