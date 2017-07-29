clear;
%---------------------------------
%   初始参数
num_pop = 200;	%种群中的个体数量
hy_prob = 0.7;	%种群的杂交率
mu_prob = 0.3;	%个体变异率
prec = 10^-10;	%可接受的精度要求
genetic_round = 10000;	%遗传的最大代数
genetic_round0 = 1;	%遗传的最小代数
num_bestkeeper = 20;	%保优数量
eps_obj = 10^-10;
eps_var = 10^-10;
%---------------------------------
%	设计变量阈值
%lb = -5;
%ub=5;
lb = [5;5];	%设计变量下限值，列向量
ub = [10;10];	%设计变量上限值，列向量
%---------------------------------
%	目标函数句柄
obj = @ObjFun;
index_min_max = -1;	%最大化或者最小化
%---------------------------------
%	十进制编码遗传算法
x_op = zeros(length(ub),genetic_round);	%初始化最优点存储矩阵
obj_op = zeros(1,genetic_round);	%初始化最优目标值向量
len_code = CodeLen( lb,ub,prec );	%计算编码长度
population = IniPopulGen( num_pop,lb,ub );	%生成初始种群
for kk = 1:1:genetic_round
	population0 = population;
	[ fitness01,cumulation_fitness ] = Fitness( population,obj,index_min_max );	%计算累积适应度分布
	population = Selection( population,fitness01,cumulation_fitness,num_bestkeeper );	%选择
	code_dec = CodingReal2Dec( population,lb,ub,len_code );		%十进制编码
	code_hy = Hybrid( code_dec,hy_prob,num_pop );	%杂交
	code_mu = Mutation( code_hy,mu_prob,num_pop,kk );	%变异
	code_dec = code_mu;
	population = DecodingDec2Real( code_dec,lb,ub,len_code );	%解码
	obj_val = ObjFun(population);	%计算目标值
	obj_val0 = obj_val;
	[obj_optemp,x_op_ind] = min(obj_val);	%当前最优解
	obj_op(kk) = obj_optemp;
	x_op(:,kk) = population(:,x_op_ind);
	if kk > genetic_round0
		if (norm(obj_op(kk)-obj_op(kk-1))<eps_var)
			break;
		end
	end
end
disp('遗传代数：');
disp(kk);
disp('最优目标值：');
disp(obj_op(kk));
disp('最优变量值：');
disp(x_op(:,kk));
%----------------------------------
%	目标函数
function object_val = ObjFun(x)
	%object_val = (x(1,:)-pi).^2+(x(2,:)-exp(1)).^2-3;
	%object_val = (x-exp(1)).^2-3;
    %object_val = x.^2+x+5*sin(3*x)+3*cos(4*x);
    object_val = x(1,:).*sin(4*x(1,:))+1.1*x(2,:).*sin(2*x(2,:));
end
