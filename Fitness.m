function [ fitness01,cumulation_fitness ] = Fitness( population,fun_fitness,index_min_max )
%����������Ӧ�ȼ���Ӧ�ȵ��ۻ���
%--------------------------------------------------------
%	�������
%	population:��Ҫ������Ӧ�ȵ���Ⱥ
%   fun_fitness����Ӧ�ȼ��㺯��
%	index_min_max�������ж���󻯻���С��Ŀ�꺯���ı�����1 for max��-1 for min��
%--------------------------------------------------------
%	�������
%	fitness01�����򻯵���Ⱥ��Ӧ��
%	cumulation_fitness����һ����Ӧ���ۻ��ֲ�
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

