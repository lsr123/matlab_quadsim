function [ Best_solution,Second_Bsolution,Best_num,Second_num] = sort_solution(X)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
%Best_solution 最好个体的向量 
%Second_Bsolution 第二好个体的向量
%Best_num 第一好个体 是哪一个粒子
%Second_num 第二好个体是哪一个粒子
for i=1:size(X,1)
    p1_new_fitness(i) = get_fitness(X(i,:));
end


[res1,res2]=sort(p1_new_fitness);
Best_solution = res1(1);
Second_Bsolution = res1(2);
Best_num = res2(1);
Second_num = res2(2);

end

