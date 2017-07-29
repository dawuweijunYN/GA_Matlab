function [ len_code ] = CodeLen( lb,ub,prec )
%根据设计变量上下限和精度要求确定编码长度
%--------------------------------------------------
%	输入变量
%   lb：设计变量的下限向量
%	ub：设计变量的上限向量
%	prec：要求结果的精度
%--------------------------------------------------
%	输出变量
%	len_code：编码长度
%--------------------------------------------------
minlb = min(lb);
maxub = max(ub);
maxnum = (maxub-minlb)/prec;
len_temp = log2(maxnum);
len_code = ceil(len_temp);
end