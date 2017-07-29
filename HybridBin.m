function [ code_new] = HybridBin( code_old,hy_prob,num_popul,len_code )
%计算杂交后的子代种群
%--------------------------------------------------------
%	输入变量
%	code_old:亲代种群
%   hy_prob:杂交的概率阈值
%	len_code：二进制编码长度
%--------------------------------------------------------
%	输出变量
%	code_new：杂交后的子代种群
%--------------------------------------------------------
	prob = rand(1,num_popul);
	[~,index_cross,~] = find(prob>(1-hy_prob));
	code_new = code_old;
	if ~isempty(index_cross)	%当需要杂交操作的个体数量为0时，则不进行杂交
		prob_cross = prob(index_cross);
		data_cross = [index_cross;prob_cross];
		data_cross_sort = sortrows(data_cross',2)';		%杂交的匹配
		data_cross_sort1 = data_cross_sort(1,:);
		data_cross_sort1 = [data_cross_sort1,data_cross_sort1(1)];
		for ii = 1:1:length(data_cross_sort1)-1
			r_s_1 = randi(len_code-1);	%杂交的起始位置
			r_e_1 = r_s_1+randi(len_code-r_s_1);	%杂交的终止位置
			r_s_2 = len_code+randi(len_code-1);
			r_e_2 = len_code+r_s_1+randi(len_code-r_s_1);
			code_new(data_cross_sort1(ii),r_s_1:r_e_1) = code_old(data_cross_sort1(ii+1),r_s_1:r_e_1);	%第一条染色体的杂交
			code_new(data_cross_sort1(ii+1),r_s_1:r_e_1) = code_old(data_cross_sort1(ii),r_s_1:r_e_1);
			code_new(data_cross_sort1(ii),r_s_2:r_e_2) = code_old(data_cross_sort1(ii+1),r_s_2:r_e_2);	%第二条染色体的杂交
			code_new(data_cross_sort1(ii+1),r_s_2:r_e_2) = code_old(data_cross_sort1(ii),r_s_2:r_e_2);
		end
	end
end

