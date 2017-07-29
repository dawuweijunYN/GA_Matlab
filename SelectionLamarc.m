function [ popul_new ] = SelectionLamarc( popul_old,fitness01,eta,permutation)
%拉马克的获得性遗传选择
%--------------------------------------------------------
%	输入变量
%	popul_old:当前待筛选种群
%	fitness01：正则化的种群适应度
%	eta：学习因子
%	permutation：判断是否打乱，0 for NO；1 for YES.
%--------------------------------------------------------
%	输出变量
%	popul_new：通过筛选的新种群
%--------------------------------------------------------
	num_popul = size(popul_old,2);
	[fitness01_max,ind_fit_max] = max(fitness01);
	x_fit_max = popul_old(:,ind_fit_max);
	popul_new = popul_old+eta*((fitness01_max-fitness01)/fitness01_max).*(x_fit_max-popul_old);
	if (permutation == 1)
		temp = randperm(num_popul);
		popul_new = popul_new(:,temp);
	end
end

