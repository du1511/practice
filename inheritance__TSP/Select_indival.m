%% ѡ��
% ѡ����Ӧ�ĸ��ߵĸ��嵽����һ��

function new_indival = Select_indival(Fit,indival_number)
global chromosome;
N = length(Fit);                %��Ⱥ�ĸ���          
s = sum(Fit);                   %����Ӧ�Ⱥ������
for m=1:N
    indival_adapt(m) = Fit(m)./s;   %����Ӧ�Ȱ���ֵ��С�ֿ飬��Ӧ�ȴ�ĸ��ʴ�
end

indival_accum = cumsum(indival_adapt);     %��Ӧ�Ƚ����ۼ�����

for n=1:indival_number
    target_index = find(indival_accum>rand);
    new_indival(n,:) = chromosome(target_index(1),:);  
end
end


