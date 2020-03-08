function R = PIO_fitness(X,in)   %计算的是最小值

% load_system('lsr')
% set_param('lsr/Constant','Value',num2str(X(1)));
% 
% sim('lsr')
% 
% R=simout.Data(end);

alt_adrc.b0 = X(1);
alt_adrc.w = X(2);
quadsim_run
R = Var.alt_fitness;

% %test
% a = X(1);
% b = X(2);
% c = X(3);
% R = a*a + b*b + c*c;
end

