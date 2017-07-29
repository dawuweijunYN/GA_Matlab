function [ code_new ] = MutationBin( code_old,mu_prob,num_popul,len_code)
%计算变异后的新的子代种群，二进制单点变异
%--------------------------------------------------------
%	输入变量
%	code_old:杂交得到的子代种群
%   hy_prob:变异的概率阈值
%	num_popul：种群中个体数量
%	len_code：二进制编码长度
%--------------------------------------------------------
%	输出变量
%	code_new：变异后的子代种群
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