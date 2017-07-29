function [ popul_new ] = SelectionLamarc( popul_old,fitness01,eta,permutation)
%����˵Ļ�����Ŵ�ѡ��
%--------------------------------------------------------
%	�������
%	popul_old:��ǰ��ɸѡ��Ⱥ
%	fitness01�����򻯵���Ⱥ��Ӧ��
%	eta��ѧϰ����
%	permutation���ж��Ƿ���ң�0 for NO��1 for YES.
%--------------------------------------------------------
%	�������
%	popul_new��ͨ��ɸѡ������Ⱥ
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

