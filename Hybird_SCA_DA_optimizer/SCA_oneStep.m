
% 根据当前的种群位置，更新一步
% for i=1:size(x1_new,1)   %计算当前种群1中个体的最优值
%     Objective_values(1,i)=get_fitness(x1_new(i,:));
%     if i==1
%         Destination_position=x1_new(i,:);
%         Destination_fitness=Objective_values(1,i);
%     elseif Objective_values(1,i)<Destination_fitness
%         Destination_position=x1_new(i,:);
%         Destination_fitness=Objective_values(1,i);
%     end
%     
%     All_objective_values(1,i)=Objective_values(1,i);
% end


% t=2; % start from the second iteration since the first iteration was dedicated to calculating the fitness   
% Eq. (3.4)
a = 2;
r1=a-t*((a)/iteration_max); % r1 decreases linearly from a to 0
    
% Update the position of solutions with respect to destination
for i=1:size(x1_new,1) % in i-th solution
     for j=1:size(x1_new,2) % in j-th dimension
            
         % Update r2, r3, and r4 for Eq. (3.3)
         r2=(2*pi)*rand();
         r3=2*rand;
         r4=rand();
            
         % Eq. (3.3)
         if r4<0.5
             % Eq. (3.1)
             x1_new(i,j)= x1_new(i,j)+(r1*sin(r2)*abs(r3*Destination_position(j)-x1_new(i,j)));
         else
             % Eq. (3.2)
             x1_new(i,j)= x1_new(i,j)+(r1*cos(r2)*abs(r3*Destination_position(j)-x1_new(i,j)));
         end
            
     end
end
    
for i=1:size(x1_new,1)
         
        % Check if solutions go outside the search spaceand bring them back
        %防止超出 约束
        Flag4ub=x1_new(i,:)>ub;
        Flag4lb=x1_new(i,:)<lb;
        x1_new(i,:)=(x1_new(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
        
        % Calculate the objective values
        Objective_values(1,i)=get_fitness(x1_new(i,:));
        
        % Update the destination if there is a better solution
        if Objective_values(1,i)<Destination_fitness
            Destination_position=x1_new(i,:);
            Destination_fitness=Objective_values(1,i);
        end
end

SCA_best_score = Destination_fitness;

