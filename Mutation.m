function [ code_new ] = Mutation( code_old,mu_prob,num_popul,round_ga )
%计算变异后的新的子代种群
%--------------------------------------------------------
%	输入变量
%	code_old:杂交得到的子代种群
%   hy_prob:变异的概率阈值
%--------------------------------------------------------
%	输出变量
%	code_new：变异后的子代种群
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