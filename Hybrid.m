function [ code_new] = Hybrid( code_old,hy_prob,num_popul )
%�����ӽ�����Ӵ���Ⱥ
%--------------------------------------------------------
%	�������
%	code_old:�״���Ⱥ
%   hy_prob:�ӽ��ĸ�����ֵ
%--------------------------------------------------------
%	�������
%	code_new���ӽ�����Ӵ���Ⱥ
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

