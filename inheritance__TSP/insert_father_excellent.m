%% func�����������������ĸ���������һ����
function new_indival = insert_father_excellent(parents_indival,son_indival,Route_length)
row_parents = length(parents_indival);
row_son = length(son_indival);
[~,index] = sort(Route_length);                                %���У�����ȡ���̾��������ֵ
new_indival = [parents_indival(index(1:row_parents-row_son),:);son_indival];   %��¼�¾������(������Ӧ��ֵ��ߵ�)����������뵽�Ӵ�


end