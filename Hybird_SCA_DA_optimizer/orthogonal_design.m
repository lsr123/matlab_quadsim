function [out_p,best_result,p1_num,p2_num] = orthogonal_design(p1,p2)
%ORTHOGONAL_DESIGN.M 此处显示有关此函数的摘要
%   此处显示详细说明
%best_result 为正交实验后的最优 fitness
%p1 p2 为两个输入的向量
% out_p 为正交后的向量 p1_num 为结果向量中p1分量的个数，p2_num为结果向量中p2分量的个数
  a = p1;
  b = [p1(1) p2(2) p2(3)];
  c = [p2(1) p1(2) p2(3)];
  d = [p2(1) p2(2) p1(1)];
  
  a_fitness = get_fitness(a);
  b_fitness = get_fitness(b);
  c_fitness = get_fitness(c);
  d_fitness = get_fitness(d);
    
  K1a = (a_fitness + b_fitness)/2;
  K1b = (a_fitness + c_fitness)/2;
  K1c = (a_fitness + d_fitness)/2;
  K2a = (c_fitness + d_fitness)/2;
  K2b = (b_fitness + d_fitness)/2;
  K2c = (b_fitness + c_fitness)/2;

  count_p1 = 0;  %数一下最后结果中，来自p1的分量有几个
  if K1a<K2a
      out_p(1) = p1(1);
      count_p1 = count_p1+1;
  else
      out_p(1) = p2(1);
  end
  
  if K1b<K2b
      out_p(2) = p1(2);
      count_p1 = count_p1+1;
  else
      out_p(2) = p2(2);
  end
  
  if K1c<K2c
      out_p(3) = p1(3);
      count_p1 = count_p1+1;
  else
      out_p(3) = p2(3);
  end
  
  out_p_fitness = get_fitness(out_p);
  p1_num = count_p1;
  p2_num = 3 - p1_num;
  
  best_result = a_fitness;
  if out_p_fitness<best_result
      best_result = out_p_fitness;
  end
    
    
  
end

