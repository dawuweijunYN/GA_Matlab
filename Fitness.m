function [ fitness01,cumulation_fitness ] = Fitness( population,fun_fitness,index_min_max )
%计算正则化适应度及适应度的累积分
%--------------------------------------------------------
%	输入变量
%	population:需要计算适应度的种群
%   fun_fitness：适应度计算函数
%	index_min_max：用来判断最大化或最小化目标函数的变量，1 for max；-1 for min。
%--------------------------------------------------------
%	输出变量
%	fitness01：正则化的种群适应度
%	cumulation_fitness：归一化适应度累积分布
%--------------------------------------------------------
	fitness = fun_fitness(population);
	fitness0 = min(fitness);
	fitness1 = max(fitness);
	if index_min_max == 1
		fitness01 = fitness-fitness0;
	else
		fitness01 = fitness1-fitness;
	end
	cumulation_fitness = cumsum(fitness01)/sum(fitness01);
end

