%% �������
function new_indival = Variation_indival(new_indival,variation_rate)
[row,col] = size(new_indival);                             %����Ⱥ�и������������
for i = 1:row
    if rand <= variation_rate                              %�ж��Ƿ����˱���
        R = randperm(col);                                 %��ȡ����λ��
        new_indival(i,R(1:2)) = new_indival(i,R(2:-1:1));  %������������λ��
    end
end

end