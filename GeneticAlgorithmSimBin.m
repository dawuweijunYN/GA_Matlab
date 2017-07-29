clear;
%---------------------------------
%   ��ʼ����
num_pop = 200;	%��Ⱥ�еĸ�������
hy_prob = 0.7;	%��Ⱥ���ӽ���
mu_prob = 0.2;	%���������
prec = 10^-10;	%�ɽ��ܵľ���Ҫ��
genetic_round = 1000;	%�Ŵ���������
genetic_round0 = 1;	%�Ŵ�����С����
num_bestkeeper = 20;	%��������
eps_obj = 10^-10;
eps_var = 10^-10;
eta = 1;
permutation = 1;
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
	[ fitness01,cumulation_fitness ] = Fitness( population,obj,index_min_max );	%�����ۻ���Ӧ�ȷֲ�
	population = Selection( population,fitness01,cumulation_fitness,num_bestkeeper );	%ѡ��
	%population = SelectionLamarc( population,fitness01,eta,permutation);	%������Ŵ�ɸѡ
	code_dec = CodingReal2Dec( population,lb,ub,len_code );		%ʮ���Ʊ���
	code_bin = CodingDec2Bin( code_dec,len_code );	%���α��룬�����Ʊ���
	code_hy = HybridBin( code_bin,hy_prob,num_pop,len_code );	%�ӽ�
	code_mu = MutationBin( code_hy,mu_prob,num_pop,len_code);	%����
	code_dec = DecodingBin2Dec( code_mu,len_code );	%��һ�����
	code_dec0 = code_dec;
	population = DecodingDec2Real( code_dec,lb,ub,len_code );	%����
	obj_val = ObjFun(population);	%����Ŀ��ֵ
	[obj_optemp,x_op_ind] = min(obj_val);	%��ǰ���Ž�
	obj_op(kk) = obj_optemp;
	x_op(:,kk) = population(:,x_op_ind);
	if kk > genetic_round0
		if (abs(obj_op(kk)-obj_op(kk-1))<eps_var)
			break;
		end
	end
	disp('�Ŵ�������');
	disp(kk);
end
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
