%author:DZQ
%time  :2021/8/12  
%func:%输入一个text文件，包含二维的城市坐标
%      输出: 迭代过程，最佳的路线，迭代次数，最短运行距离

%% old friends
clc;                                                         
clear;                                                       
close all;  %关闭所有的图片
 
%% 
city_position = importdata('citys_position.txt');             %读取城市坐标  (    city_position(number,:);   )
sample_number = 100;                                          %设定样本数为100
iterations_total = 300;                                       %总的迭代次数
iter_num = 1;                                                 %初始化当前迭代次数
iter_best = 0;                                                %迭代最佳值
route_dis_total = 0;                                          %单个样本上的距离初始化
selet_rate = 0.9;                                             %选择率
cross_rate = 0.8;                                             %发生交叉的概率
variation_rate = 0.1;                                         %发生变异的概率

citys_number = size(city_position,1);                         %计算城市数量
Distance_citys = pdist2(city_position,city_position);         %计算城市之间的距离矩阵
 
global chromosome ;
chromosome = zeros(sample_number,citys_number);               %初始化全局变量
%% 种群初始化 
for i=1:sample_number
    chromosome(i,:) = randperm(citys_number);                 % 对城市随机打乱（编码） 
end
%% 种群个体经过选择，交叉，变异后，进行不断地迭代选出最优个体 
while iter_num <= iterations_total                            %进行迭代
    for j=1:sample_number                                     %选定的100个样本进行求距离
        route_dis_total(j) = route_distance(Distance_citys,chromosome(j,:));  %对每种情况求取距离     
    end
   [Min_route,Min_index] = min(route_dis_total);              %求解出整个的种群下最小路线的样本和对应位置

   iter_best(iter_num) = Min_route;                           %为了绘制收敛曲线图   
   best_road(iter_num,:) =  [ chromosome(Min_index,:) chromosome(Min_index,1)];  %%此处加上一个最优路径迭代曲线，注意的最后添加回归起点
   
   Fitnenss = 1./route_dis_total;                             %适应的函数
   select_num = max(floor(sample_number*selet_rate+0.6),2);   %被选中的个体数目，最小取2（生物学代沟，子代数量变少，可以在后续添加）
   %% 所进行的工作是尽可能的打乱城市（基因）顺序
   new_indival = Select_indival(Fitnenss,select_num);          %经过选择选出适应度相对高的个体（染色体）
   new_indival = Cross_indival(new_indival,cross_rate);        %对经过选择的个体进行交叉
   new_indival = Variation_indival(new_indival,variation_rate);%对经过交叉后的个体进行变异
   new_indival = Reverse(new_indival, Distance_citys);         %对所选个体进行逆转
   %%将父代的一部分优异个体复制复制到子代                                                                            
   chromosome = insert_father_excellent(chromosome, new_indival,route_dis_total);
   
   %% 绘制曲线规划的过程
   x = city_position( best_road(iter_num,:),1);         %当前最优路线下，横坐标向量
   y = city_position( best_road(iter_num,:),2);         %当前最优路线下，纵坐标向量
   plot( x,y,'rp-');                                    %绘制当前最优路线图
   xlabel('经度');       %横坐标
   ylabel('纬度');       %纵坐标
   title('遗传算法(GA)优化TSP问题');    %图片标题
    pause(0.0001);                                           %暂停0.1ms，观看迭代过程
   %% 迭代次数累加
   iter_num = iter_num+1;                                   %迭代次数累加
end
%% 绘制收敛过程
figure('name','收敛过程');
plot(iter_best);
xlabel('迭代次数');       %横坐标
ylabel('总共走过的路程值');       %纵坐标
title('收敛过程');    %图片标题
%% 在任务框内写出行进城市的路线
for i=1:citys_number
    X = sprintf('经过第%d个城市,编号为%s',i,num2str(best_road(end,i)));
    disp(X);               %显示最终的运行距离
end
%% 计算所走的最近的距离
disp(['最短距离为:' num2str(iter_best(end))]);               %显示最终的运行距离

%% 画出最终结果图
figure('name','TSP问题的最终规划路线')
for i = 1 : citys_number                            
   scatter(city_position(i,1),city_position(i,2),'b');            %画出散点图
   hold on
   text(city_position(i,1),city_position(i,2)+10,num2str(i));     %用text做好标记
end
   plot(city_position( best_road(end,:),1),city_position( best_road(end,:),2),'rp-');       %基于最优路线画出最终结果
   text(city_position( best_road(end,1),1),city_position( best_road(end,1),2),'起点');       %基于最优路线画出最终结果
   text(city_position( best_road(end,end-1),1),city_position( best_road(end,end-1),2),'终点');       %基于最优路线画出最终结果
   xlabel('经度');                                                  %横坐标
   ylabel('纬度');                                                  %纵坐标
   title('TSP问题的最终规划路线');                                       %图片标题
   









