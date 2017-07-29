function [ code_dec ] = DecodingBin2Dec( code_bin,len_code )
%�������Ʊ������Ϊʮ���Ʊ���
%--------------------------------------------------------
%	�������
%	code_bin����Ⱥ�Ķ����Ʊ���
%	len_code�������ƴ��볤��
%--------------------------------------------------------
%	�������
%	code_dec����Ⱥ��ʮ���Ʊ���
%--------------------------------------------------------
	code_bin_temp1 = code_bin(:,1:len_code);
	code_bin_temp2 = code_bin(:,len_code+1:end);
	code_bin_temp = [code_bin(:,1:len_code);code_bin(:,len_code+1:end)];	%�����ʼ���ַ�����ķ�����Щ����
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