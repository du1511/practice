%% ����������·���ľ���

%inout :�������D�ͱ��
%output:�����������ֵ֮��ľ��루���ظ���
function distance = route_distance(D,S)
distance = 0;                           %��ʼ������
sample_length = length(S);
for k=1:sample_length
    if k < sample_length
        distance = distance + D(S(k),S(k+1));
    else
        distance = distance + D(S(sample_length),S(1));
    end

end
