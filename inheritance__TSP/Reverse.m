%%������ת����
%��ȡһ����������������з�ת
function NEWChrom2 = Reverse(NEWChrom2, D)
[row, col] = size(NEWChrom2);
NEWChrom3 = NEWChrom2;  %NEWChorm��Ϊһ���Ƚϵ��м����
for i = 1:row
   distance_old = route_distance(D,NEWChrom2(i,:));  %����һά�Ļ�����distance(i),����ͬ��
    r = unidrnd(col,1,2);  %�������������
    minrev = min(r);
    maxrev = max(r);
    NEWChrom3(i,minrev:maxrev) = fliplr(NEWChrom3(i,minrev:maxrev));      %��fliplr�Ծ�����з�ת
    distance_new = route_distance(D,NEWChrom3(i,:));
    if distance_new < distance_old
        NEWChrom2(i,:) = NEWChrom3(i,:);  %������������
    end
end

