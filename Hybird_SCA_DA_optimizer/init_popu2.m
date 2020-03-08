
DA_num = size(x2_new,1);
DA_dim = size(x2_new,2);

dim = DA_dim;

if size(ub,2)==1
    ub=ones(1,dim)*ub;
    lb=ones(1,dim)*lb;
end


r=(ub-lb)/10;
Delta_max=(ub-lb)/10;

Food_fitness=inf;
Food_pos=zeros(DA_dim,1);

Enemy_fitness=-inf;
Enemy_pos=zeros(DA_dim,1);


% X=initialization(DA_num,DA_dim,ub,lb);
Fitness=zeros(1,DA_num);



Max_iteration = iteration_max;
SearchAgents_no = DA_num;
X = x2_new';
DeltaX=initialization(DA_num,DA_dim,ub,lb);