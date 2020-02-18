function R = fitness(X,in)   %计算的是最小值

% load_system('lsr')
% set_param('lsr/Constant','Value',num2str(X(1)));
% 
% sim('lsr')
% 
% R=simout.Data(end);

alt_adrc.b0 = X(1)
quadsim_run
R = Var.alt_fitness;

% %test
% a = X(1);
% R = a*a-2*a;
end

