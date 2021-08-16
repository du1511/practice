%% 选择
% 选择适应的更高的个体到达下一代

function new_indival = Select_indival(Fit,indival_number)
global chromosome;
N = length(Fit);                %种群的个数          
s = sum(Fit);                   %对适应度函数求和
for m=1:N
    indival_adapt(m) = Fit(m)./s;   %将适应度按照值大小分块，适应度大的概率大
end

indival_accum = cumsum(indival_adapt);     %适应度进行累加运算

for n=1:indival_number
    target_index = find(indival_accum>rand);
    new_indival(n,:) = chromosome(target_index(1),:);  
end
end


