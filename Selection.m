function [ popul_new ] = Selection( popul_old,fitness01,cumulation_fitness,num_bestkeeper )
%根据累积适应度分布，通过轮盘赌算法进行选择过程(可以考虑保优操作)
%--------------------------------------------------------
%	输入变量
%	popul_old:当前待筛选种群
%	fitness01：正则化的种群适应度
%   cumulation_fitness：归一化适应度的累积分布
%	num_bestkeeper：保优数量
%--------------------------------------------------------
%	输出变量
%	popul_new：通过筛选的新种群
%--------------------------------------------------------
	num_popul = size(popul_old,2);
	popul_new = zeros(size(popul_old));
	[~,seq_fitness01] = sort(-fitness01);
	popul_new(:,1:num_bestkeeper) = popul_old(:,seq_fitness01(1:num_bestkeeper));
	num_selection = num_popul-num_bestkeeper;
	roulette = rand(1,num_selection);
	num_popul_temp = zeros(1,num_popul);
	temp = num_bestkeeper;
	cumulation_fitness(end) = cumulation_fitness(end)+1;	%避免当随机数恰好等于1时，漏记数量导致子代数量减少
	cumulation_fitness = [0,cumulation_fitness];
	for ii = 1:1:num_popul
		[~,~,roulette_selection] = find(roulette>=cumulation_fitness(ii)&roulette<cumulation_fitness(ii+1));
		num_popul_temp(ii) = length(roulette_selection);
		if num_popul_temp(ii) == 0
			continue;
		else
			for jj = temp+1:1:temp+num_popul_temp(ii)
				popul_new(:,jj) = popul_old(:,ii);
			end
		end
	temp = temp+num_popul_temp(ii);
	
end