%% func：将父代中相对优秀的个体存放于下一代中
function new_indival = insert_father_excellent(parents_indival,son_indival,Route_length)
row_parents = length(parents_indival);
row_son = length(son_indival);
[~,index] = sort(Route_length);                                %排列，便于取出短距离的索引值
new_indival = [parents_indival(index(1:row_parents-row_son),:);son_indival];   %记录下距离最短(就是适应度值最高的)几条基因插入到子代


end