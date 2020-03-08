
function output = get_fitness(X)
%GET_FITNESS 此处显示有关此函数的摘要
%   此处显示详细说明
% X
% for i=1:size(X,2)
%     output = output+X(i)*X(i);
% end
global CC
CC = CC + 1
% output = sum(X.^2);
% output = sum(abs(X))+prod(abs(X));
% output=max(abs(X));



X(1) = 0.5*X(1)+22.5;
X(2) = X(2) + 100;
X(3) = 0.4*X(3) + 100;
alt_adrc.b0 = X(1);
alt_adrc.w = X(2);
alt_adrc.r = X(3);
quadsim_run
output = Var.alt_fitness;



end

