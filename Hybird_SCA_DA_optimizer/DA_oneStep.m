
 SearchAgents_no = size(x2_new,1);
 dim = size(x2_new,2);
 Max_iteration = iteration_max;
 X = x2_new';
 DeltaX=initialization(SearchAgents_no,dim,ub,lb);
 
    r=(ub-lb)/4+((ub-lb)*(iter/Max_iteration)*2);
    
    w=0.9-iter*((0.9-0.4)/Max_iteration);
       
    my_c=0.1-iter*((0.1-0)/(Max_iteration/2));
    if my_c<0
        my_c=0;
    end
    
    s=2*rand*my_c; % Seperation weight
    a=2*rand*my_c; % Alignment weight
    c=2*rand*my_c; % Cohesion weight
    f=2*rand;      % Food attraction weight
    e=my_c;        % Enemy distraction weight
    
    for i=1:SearchAgents_no %Calculate all the objective values first
        Fitness(1,i)=get_fitness(X(:,i)');
        if Fitness(1,i)<Food_fitness
            Food_fitness=Fitness(1,i);
            Food_pos=X(:,i);
        end
        
        if Fitness(1,i)>Enemy_fitness
            if all(X(:,i)<ub') && all( X(:,i)>lb')
                Enemy_fitness=Fitness(1,i);
                Enemy_pos=X(:,i);
            end
        end
    end
    
    for i=1:SearchAgents_no
        index=0;
        neighbours_no=0;
        
        clear Neighbours_DeltaX
        clear Neighbours_X
        %find the neighbouring solutions
        for j=1:SearchAgents_no
            Dist2Enemy=distance(X(:,i),X(:,j));
          
            if (all(Dist2Enemy<=r) && all(Dist2Enemy~=0))
                index=index+1;
                neighbours_no=neighbours_no+1;
                Neighbours_DeltaX(:,index)=DeltaX(:,j);
                Neighbours_X(:,index)=X(:,j);
            end
        end
        
        % Seperation%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Eq. (3.1)
        S=zeros(dim,1);
        if neighbours_no>1
            for k=1:neighbours_no
                S=S+(Neighbours_X(:,k)-X(:,i));
            end
            S=-S;
        else
            S=zeros(dim,1);
        end
        
        % Alignment%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Eq. (3.2)
        if neighbours_no>1
            A=(sum(Neighbours_DeltaX')')/neighbours_no;
        else
            A=DeltaX(:,i);
        end
        
        % Cohesion%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Eq. (3.3)
        if neighbours_no>1
            C_temp=(sum(Neighbours_X')')/neighbours_no;
        else
            C_temp=X(:,i);
        end
        
        C=C_temp-X(:,i);
        
        % Attraction to food%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Eq. (3.4)
        Dist2Food=distance(X(:,i),Food_pos(:,1));
        if all(Dist2Food<=r)
            F=Food_pos-X(:,i);
        else
            F=0;
        end
        
        % Distraction from enemy%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Eq. (3.5)
        Dist2Enemy=distance(X(:,i),Enemy_pos(:,1));
        if all(Dist2Enemy<=r)
            Enemy=Enemy_pos+X(:,i);
        else
            Enemy=zeros(dim,1);
        end
        
        for tt=1:dim
%             if X(tt,i)>ub(tt)
%                X(tt,i)=lb(tt);
%                DeltaX(tt,i)=rand;
%             end
%             if X(tt,i)<lb(tt)
%                 X(tt,i)=ub(tt);
%                 DeltaX(tt,i)=rand;
%             end
            if X(tt,i)>ub
               X(tt,i)=lb;
               DeltaX(tt,i)=rand;
            end
            if X(tt,i)<lb
                X(tt,i)=ub;
                DeltaX(tt,i)=rand;
            end

        end
        
        if any(Dist2Food>r)
            if neighbours_no>1
                for j=1:dim
                    DeltaX(j,i)=w*DeltaX(j,i)+rand*A(j,1)+rand*C(j,1)+rand*S(j,1);
                    if DeltaX(j,i)>Delta_max(j)
                        DeltaX(j,i)=Delta_max(j);
                    end
                    if DeltaX(j,i)<-Delta_max(j)
                        DeltaX(j,i)=-Delta_max(j);
                    end
                    X(j,i)=X(j,i)+DeltaX(j,i);
                end
            else
                % Eq. (3.8)
                X(:,i)=X(:,i)+Levy(dim)'.*X(:,i);
                DeltaX(:,i)=0;
            end
        else
            for j=1:dim
                % Eq. (3.6)
                DeltaX(j,i)=(a*A(j,1)+c*C(j,1)+s*S(j,1)+f*F(j,1)+e*Enemy(j,1)) + w*DeltaX(j,i);
                if DeltaX(j,i)>Delta_max(j)
                    DeltaX(j,i)=Delta_max(j);
                end
                if DeltaX(j,i)<-Delta_max(j)
                    DeltaX(j,i)=-Delta_max(j);
                end
                X(j,i)=X(j,i)+DeltaX(j,i);
            end 
        end
        
        Flag4ub=X(:,i)>ub';
        Flag4lb=X(:,i)<lb';
        X(:,i)=(X(:,i).*(~(Flag4ub+Flag4lb)))+ub'.*Flag4ub+lb'.*Flag4lb;
        
    end
    DA_best_score=Food_fitness;
    Best_pos=Food_pos;
    
    x2_new = X';
    
%     cg_curve(iter)=Best_score;
    
    