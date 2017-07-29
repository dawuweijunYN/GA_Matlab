clear;
%---------------------------------
%   ��ʼ����
num_pop = 200;	%��Ⱥ�еĸ�������
hy_prob = 0.7;	%��Ⱥ���ӽ���
mu_prob = 0.3;	%���������
prec = 10^-10;	%�ɽ��ܵľ���Ҫ��
genetic_round = 10000;	%�Ŵ���������
genetic_round0 = 1;	%�Ŵ�����С����
num_bestkeeper = 20;	%��������
eps_obj = 10^-10;
eps_var = 10^-10;
%---------------------------------
%	��Ʊ�����ֵ
%lb = -5;
%ub=5;
lb = [5;5];	%��Ʊ�������ֵ��������
ub = [10;10];	%��Ʊ�������ֵ��������
%---------------------------------
%	Ŀ�꺯�����
obj = @ObjFun;
index_min_max = -1;	%��󻯻�����С��
%---------------------------------
%	ʮ���Ʊ����Ŵ��㷨
x_op = zeros(length(ub),genetic_round);	%��ʼ�����ŵ�洢����
obj_op = zeros(1,genetic_round);	%��ʼ������Ŀ��ֵ����
len_code = CodeLen( lb,ub,prec );	%������볤��
population = IniPopulGen( num_pop,lb,ub );	%���ɳ�ʼ��Ⱥ
for kk = 1:1:genetic_round
	population0 = population;
	[ fitness01,cumulation_fitness ] = Fitness( population,obj,index_min_max );	%�����ۻ���Ӧ�ȷֲ�
	population = Selection( population,fitness01,cumulation_fitness,num_bestkeeper );	%ѡ��
	code_dec = CodingReal2Dec( population,lb,ub,len_code );		%ʮ���Ʊ���
	code_hy = Hybrid( code_dec,hy_prob,num_pop );	%�ӽ�
	code_mu = Mutation( code_hy,mu_prob,num_pop,kk );	%����
	code_dec = code_mu;
	population = DecodingDec2Real( code_dec,lb,ub,len_code );	%����
	obj_val = ObjFun(population);	%����Ŀ��ֵ
	obj_val0 = obj_val;
	[obj_optemp,x_op_ind] = min(obj_val);	%��ǰ���Ž�
	obj_op(kk) = obj_optemp;
	x_op(:,kk) = population(:,x_op_ind);
	if kk > genetic_round0
		if (norm(obj_op(kk)-obj_op(kk-1))<eps_var)
			break;
		end
	end
end
disp('�Ŵ�������');
disp(kk);
disp('����Ŀ��ֵ��');
disp(obj_op(kk));
disp('���ű���ֵ��');
disp(x_op(:,kk));
%----------------------------------
%	Ŀ�꺯��
function object_val = ObjFun(x)
	%object_val = (x(1,:)-pi).^2+(x(2,:)-exp(1)).^2-3;
	%object_val = (x-exp(1)).^2-3;
    %object_val = x.^2+x+5*sin(3*x)+3*cos(4*x);
    object_val = x(1,:).*sin(4*x(1,:))+1.1*x(2,:).*sin(2*x(2,:));
end
