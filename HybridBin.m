function [ code_new] = HybridBin( code_old,hy_prob,num_popul,len_code )
%�����ӽ�����Ӵ���Ⱥ
%--------------------------------------------------------
%	�������
%	code_old:�״���Ⱥ
%   hy_prob:�ӽ��ĸ�����ֵ
%	len_code�������Ʊ��볤��
%--------------------------------------------------------
%	�������
%	code_new���ӽ�����Ӵ���Ⱥ
%--------------------------------------------------------
	prob = rand(1,num_popul);
	[~,index_cross,~] = find(prob>(1-hy_prob));
	code_new = code_old;
	if ~isempty(index_cross)	%����Ҫ�ӽ������ĸ�������Ϊ0ʱ���򲻽����ӽ�
		prob_cross = prob(index_cross);
		data_cross = [index_cross;prob_cross];
		data_cross_sort = sortrows(data_cross',2)';		%�ӽ���ƥ��
		data_cross_sort1 = data_cross_sort(1,:);
		data_cross_sort1 = [data_cross_sort1,data_cross_sort1(1)];
		for ii = 1:1:length(data_cross_sort1)-1
			r_s_1 = randi(len_code-1);	%�ӽ�����ʼλ��
			r_e_1 = r_s_1+randi(len_code-r_s_1);	%�ӽ�����ֹλ��
			r_s_2 = len_code+randi(len_code-1);
			r_e_2 = len_code+r_s_1+randi(len_code-r_s_1);
			code_new(data_cross_sort1(ii),r_s_1:r_e_1) = code_old(data_cross_sort1(ii+1),r_s_1:r_e_1);	%��һ��Ⱦɫ����ӽ�
			code_new(data_cross_sort1(ii+1),r_s_1:r_e_1) = code_old(data_cross_sort1(ii),r_s_1:r_e_1);
			code_new(data_cross_sort1(ii),r_s_2:r_e_2) = code_old(data_cross_sort1(ii+1),r_s_2:r_e_2);	%�ڶ���Ⱦɫ����ӽ�
			code_new(data_cross_sort1(ii+1),r_s_2:r_e_2) = code_old(data_cross_sort1(ii),r_s_2:r_e_2);
		end
	end
end

