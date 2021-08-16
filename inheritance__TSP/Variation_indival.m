%% 个体变异
function new_indival = Variation_indival(new_indival,variation_rate)
[row,col] = size(new_indival);                             %求种群中个数及其基因数
for i = 1:row
    if rand <= variation_rate                              %判断是否发生了变异
        R = randperm(col);                                 %任取两个位置
        new_indival(i,R(1:2)) = new_indival(i,R(2:-1:1));  %交换两个城市位置
    end
end

end