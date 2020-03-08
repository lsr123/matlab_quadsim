
% sim.time = 0;
% sim.h = 0.005;
% sim.endtime = 5;

iteration_max = 500; %最大迭代次数
k = 0;%当前迭代次数

ps = 0.3; %种群分类参数

popu.num = 30; %种群中个体的数量
popu.D = 2; %种群中个体的维度
bound = [20 40;
         100 150]; %每一行为 每个维度的下限和上限
         

