function [ popul_new ] = Selection( popul_old,fitness01,cumulation_fitness,num_bestkeeper )
%�����ۻ���Ӧ�ȷֲ���ͨ�����̶��㷨����ѡ�����(���Կ��Ǳ��Ų���)
%--------------------------------------------------------
%	�������
%	popul_old:��ǰ��ɸѡ��Ⱥ
%	fitness01�����򻯵���Ⱥ��Ӧ��
%   cumulation_fitness����һ����Ӧ�ȵ��ۻ��ֲ�
%	num_bestkeeper����������
%--------------------------------------------------------
%	�������
%	popul_new��ͨ��ɸѡ������Ⱥ
%--------------------------------------------------------
	num_popul = size(popul_old,2);
	popul_new = zeros(size(popul_old));
	[~,seq_fitness01] = sort(-fitness01);
	popul_new(:,1:num_bestkeeper) = popul_old(:,seq_fitness01(1:num_bestkeeper));
	num_selection = num_popul-num_bestkeeper;
	roulette = rand(1,num_selection);
	num_popul_temp = zeros(1,num_popul);
	temp = num_bestkeeper;
	cumulation_fitness(end) = cumulation_fitness(end)+1;	%���⵱�����ǡ�õ���1ʱ��©�����������Ӵ���������
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