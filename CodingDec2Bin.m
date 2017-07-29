function [ code_bin ] = CodingDec2Bin( code_dec,len_code )
%将个体（染色体）十进制编码重编码为二进制编码
%需要注意，由于该函数将十进制码转化为二进制码字符串，因此进行了转置操作；
%原来每个个体按行存放，这里转化为按列存放。
%--------------------------------------------------------
%	输入变量
%	code_dec：种群的十进制编码
%	len_code：编码长度
%--------------------------------------------------------
%	输出变量
%	code_bin：种群的二进制编码
%--------------------------------------------------------
	temp = round(code_dec);
	for ii = 1:1:size(code_dec,2)
		code_bin_temp = dec2bin(temp,len_code);
	end
	code_bin_temp1 = code_bin_temp(1:2:end,:);
	code_bin_temp2 = code_bin_temp(2:2:end,:);
	code_bin = [code_bin_temp1,code_bin_temp2];	%每个个体的两个染色体编码为同一条二进制码
end