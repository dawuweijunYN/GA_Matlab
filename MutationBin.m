function [ code_new ] = MutationBin( code_old,mu_prob,num_popul,len_code)
%����������µ��Ӵ���Ⱥ�������Ƶ������
%--------------------------------------------------------
%	�������
%	code_old:�ӽ��õ����Ӵ���Ⱥ
%   hy_prob:����ĸ�����ֵ
%	num_popul����Ⱥ�и�������
%	len_code�������Ʊ��볤��
%--------------------------------------------------------
%	�������
%	code_new���������Ӵ���Ⱥ
%--------------------------------------------------------
	prob = rand(1,num_popul);
	[~,index_mutation,~] = find(prob>(1-mu_prob));
	code_new = code_old;
	if ~isempty(index_mutation)
		for ii = 1:1:length(index_mutation)
			posi_mu1 = randi(len_code-1);
			posi_mu2 = len_code+randi(len_code-1);
			if code_old(index_mutation(ii),posi_mu1) == '1'
				code_new(index_mutation(ii),posi_mu1) = '0';
			else
				code_new(index_mutation(ii),posi_mu1) = '1';
			end
			if code_old(index_mutation(ii),posi_mu2) == '1'
				code_new(index_mutation(ii),posi_mu2) = '0';
			else
				code_new(index_mutation(ii),posi_mu2) = '1';
			end
		end
	end
end