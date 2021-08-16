%author:DZQ
%time  :2021/8/12  
%func:%����һ��text�ļ���������ά�ĳ�������
%      ���: �������̣���ѵ�·�ߣ�����������������о���

%% old friends
clc;                                                         
clear;                                                       
close all;  %�ر����е�ͼƬ
 
%% 
city_position = importdata('citys_position.txt');             %��ȡ��������  (    city_position(number,:);   )
sample_number = 100;                                          %�趨������Ϊ100
iterations_total = 300;                                       %�ܵĵ�������
iter_num = 1;                                                 %��ʼ����ǰ��������
iter_best = 0;                                                %�������ֵ
route_dis_total = 0;                                          %���������ϵľ����ʼ��
selet_rate = 0.9;                                             %ѡ����
cross_rate = 0.8;                                             %��������ĸ���
variation_rate = 0.1;                                         %��������ĸ���

citys_number = size(city_position,1);                         %�����������
Distance_citys = pdist2(city_position,city_position);         %�������֮��ľ������
 
global chromosome ;
chromosome = zeros(sample_number,citys_number);               %��ʼ��ȫ�ֱ���
%% ��Ⱥ��ʼ�� 
for i=1:sample_number
    chromosome(i,:) = randperm(citys_number);                 % �Գ���������ң����룩 
end
%% ��Ⱥ���徭��ѡ�񣬽��棬����󣬽��в��ϵص���ѡ�����Ÿ��� 
while iter_num <= iterations_total                            %���е���
    for j=1:sample_number                                     %ѡ����100���������������
        route_dis_total(j) = route_distance(Distance_citys,chromosome(j,:));  %��ÿ�������ȡ����     
    end
   [Min_route,Min_index] = min(route_dis_total);              %������������Ⱥ����С·�ߵ������Ͷ�Ӧλ��

   iter_best(iter_num) = Min_route;                           %Ϊ�˻�����������ͼ   
   best_road(iter_num,:) =  [ chromosome(Min_index,:) chromosome(Min_index,1)];  %%�˴�����һ������·���������ߣ�ע��������ӻع����
   
   Fitnenss = 1./route_dis_total;                             %��Ӧ�ĺ���
   select_num = max(floor(sample_number*selet_rate+0.6),2);   %��ѡ�еĸ�����Ŀ����Сȡ2������ѧ�������Ӵ��������٣������ں�����ӣ�
   %% �����еĹ����Ǿ����ܵĴ��ҳ��У�����˳��
   new_indival = Select_indival(Fitnenss,select_num);          %����ѡ��ѡ����Ӧ����Ըߵĸ��壨Ⱦɫ�壩
   new_indival = Cross_indival(new_indival,cross_rate);        %�Ծ���ѡ��ĸ�����н���
   new_indival = Variation_indival(new_indival,variation_rate);%�Ծ��������ĸ�����б���
   new_indival = Reverse(new_indival, Distance_citys);         %����ѡ���������ת
   %%��������һ����������帴�Ƹ��Ƶ��Ӵ�                                                                            
   chromosome = insert_father_excellent(chromosome, new_indival,route_dis_total);
   
   %% �������߹滮�Ĺ���
   x = city_position( best_road(iter_num,:),1);         %��ǰ����·���£�����������
   y = city_position( best_road(iter_num,:),2);         %��ǰ����·���£�����������
   plot( x,y,'rp-');                                    %���Ƶ�ǰ����·��ͼ
   xlabel('����');       %������
   ylabel('γ��');       %������
   title('�Ŵ��㷨(GA)�Ż�TSP����');    %ͼƬ����
    pause(0.0001);                                           %��ͣ0.1ms���ۿ���������
   %% ���������ۼ�
   iter_num = iter_num+1;                                   %���������ۼ�
end
%% ������������
figure('name','��������');
plot(iter_best);
xlabel('��������');       %������
ylabel('�ܹ��߹���·��ֵ');       %������
title('��������');    %ͼƬ����
%% ���������д���н����е�·��
for i=1:citys_number
    X = sprintf('������%d������,���Ϊ%s',i,num2str(best_road(end,i)));
    disp(X);               %��ʾ���յ����о���
end
%% �������ߵ�����ľ���
disp(['��̾���Ϊ:' num2str(iter_best(end))]);               %��ʾ���յ����о���

%% �������ս��ͼ
figure('name','TSP��������չ滮·��')
for i = 1 : citys_number                            
   scatter(city_position(i,1),city_position(i,2),'b');            %����ɢ��ͼ
   hold on
   text(city_position(i,1),city_position(i,2)+10,num2str(i));     %��text���ñ��
end
   plot(city_position( best_road(end,:),1),city_position( best_road(end,:),2),'rp-');       %��������·�߻������ս��
   text(city_position( best_road(end,1),1),city_position( best_road(end,1),2),'���');       %��������·�߻������ս��
   text(city_position( best_road(end,end-1),1),city_position( best_road(end,end-1),2),'�յ�');       %��������·�߻������ս��
   xlabel('����');                                                  %������
   ylabel('γ��');                                                  %������
   title('TSP��������չ滮·��');                                       %ͼƬ����
   









