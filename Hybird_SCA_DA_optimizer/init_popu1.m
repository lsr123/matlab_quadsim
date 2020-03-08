for i=1:size(x1_new,1)   %计算当前种群1中个体的最优值
    Objective_values(1,i)=get_fitness(x1_new(i,:));
    if i==1
        Destination_position=x1_new(i,:);
        Destination_fitness=Objective_values(1,i);
    elseif Objective_values(1,i)<Destination_fitness
        Destination_position=x1_new(i,:);
        Destination_fitness=Objective_values(1,i);
    end
    
    All_objective_values(1,i)=Objective_values(1,i);
end