function [ code_new] = Hybrid( code_old,hy_prob,num_popul )
%计算杂交后的子代种群
%--------------------------------------------------------
%	输入变量
%	code_old:亲代种群
%   hy_prob:杂交的概率阈值
%--------------------------------------------------------
%	输出变量
%	code_new：杂交后的子代种群
%--------------------------------------------------------
	prob = rand(1,num_popul);
	[~,index_cross,~] = find(prob>(1-hy_prob));
	code_new = code_old;
	if ~isempty(index_cross)
		prob_cross = prob(index_cross);
		data_cross = [index_cross;prob_cross];
		data_cross_sort = sortrows(data_cross',2)';
		data_cross_sort1 = data_cross_sort(1,:);
		data_cross_sort1 = [data_cross_sort1,data_cross_sort1(1)];
		for ii = 1:1:length(data_cross_sort1)-1
			code_new(:,data_cross_sort1(ii)) = (code_old(:,data_cross_sort1(ii))+code_old(:,data_cross_sort1(ii+1)))/2;
		end
	end
end

