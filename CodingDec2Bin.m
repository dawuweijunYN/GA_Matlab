function [ code_bin ] = CodingDec2Bin( code_dec,len_code )
%�����壨Ⱦɫ�壩ʮ���Ʊ����ر���Ϊ�����Ʊ���
%��Ҫע�⣬���ڸú�����ʮ������ת��Ϊ���������ַ�������˽�����ת�ò�����
%ԭ��ÿ�����尴�д�ţ�����ת��Ϊ���д�š�
%--------------------------------------------------------
%	�������
%	code_dec����Ⱥ��ʮ���Ʊ���
%	len_code�����볤��
%--------------------------------------------------------
%	�������
%	code_bin����Ⱥ�Ķ����Ʊ���
%--------------------------------------------------------
	temp = round(code_dec);
	for ii = 1:1:size(code_dec,2)
		code_bin_temp = dec2bin(temp,len_code);
	end
	code_bin_temp1 = code_bin_temp(1:2:end,:);
	code_bin_temp2 = code_bin_temp(2:2:end,:);
	code_bin = [code_bin_temp1,code_bin_temp2];	%ÿ�����������Ⱦɫ�����Ϊͬһ����������
end