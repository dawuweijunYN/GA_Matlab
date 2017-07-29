function [ code_dec ] = DecodingBin2Dec( code_bin,len_code )
%将二进制编码解码为十进制编码
%--------------------------------------------------------
%	输入变量
%	code_bin：种群的二进制编码
%	len_code：二进制代码长度
%--------------------------------------------------------
%	输出变量
%	code_dec：种群的十进制编码
%--------------------------------------------------------
	code_bin_temp1 = code_bin(:,1:len_code);
	code_bin_temp2 = code_bin(:,len_code+1:end);
	code_bin_temp = [code_bin(:,1:len_code);code_bin(:,len_code+1:end)];	%这个初始化字符数组的方法有些笨重
	code_bin_temp(1:2:end,:) = code_bin_temp1;
	code_bin_temp(2:2:end,:) = code_bin_temp2;
	% for ii = 1:1:length(code_bin)
		% code_bin_temp(2*ii-1,:) = code_bin_temp1(ii,:);
		% code_bin_temp(2*ii,:) = code_bin_temp2(ii,:);
	% end
	code_dec_temp = bin2dec(code_bin_temp);
	code_dec_temp1 = code_dec_temp(1:2:end,:);
	code_dec_temp2 = code_dec_temp(2:2:end,:);
	code_dec = [code_dec_temp1';code_dec_temp2'];
end