%% 计算所经历路径的距离

%inout :距离矩阵D和编号
%output:输出所有样本值之间的距离（不重复）
function distance = route_distance(D,S)
distance = 0;                           %初始化距离
sample_length = length(S);
for k=1:sample_length
    if k < sample_length
        distance = distance + D(S(k),S(k+1));
    else
        distance = distance + D(S(sample_length),S(1));
    end

end
