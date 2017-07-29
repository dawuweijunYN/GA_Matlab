clear;
%---------------------------------
%   初始参数
num_pop = 200;	%种群中的个体数量
hy_prob = 0.7;	%种群的杂交率
mu_prob = 0.2;	%个体变异率
prec = 10^-10;	%可接受的精度要求
genetic_round = 1000;	%遗传的最大代数
genetic_round0 = 1;	%遗传的最小代数
num_bestkeeper = 20;	%保优数量
eps_obj = 10^-10;
eps_var = 10^-10;
eta = 1;
permutation = 1;
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
	[ fitness01,cumulation_fitness ] = Fitness( population,obj,index_min_max );	%计算累积适应度分布
	population = Selection( population,fitness01,cumulation_fitness,num_bestkeeper );	%选择
	%population = SelectionLamarc( population,fitness01,eta,permutation);	%获得性遗传筛选
	code_dec = CodingReal2Dec( population,lb,ub,len_code );		%十进制编码
	code_bin = CodingDec2Bin( code_dec,len_code );	%二次编码，二进制编码
	code_hy = HybridBin( code_bin,hy_prob,num_pop,len_code );	%杂交
	code_mu = MutationBin( code_hy,mu_prob,num_pop,len_code);	%变异
	code_dec = DecodingBin2Dec( code_mu,len_code );	%第一层解码
	code_dec0 = code_dec;
	population = DecodingDec2Real( code_dec,lb,ub,len_code );	%解码
	obj_val = ObjFun(population);	%计算目标值
	[obj_optemp,x_op_ind] = min(obj_val);	%当前最优解
	obj_op(kk) = obj_optemp;
	x_op(:,kk) = population(:,x_op_ind);
	if kk > genetic_round0
		if (abs(obj_op(kk)-obj_op(kk-1))<eps_var)
			break;
		end
	end
	disp('遗传代数：');
	disp(kk);
end
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
