for i=1:Record.id - 1
    result_z(i) = Record.state(i).posI(3);
  
end
  time = 0:Var.h:(Record.id-2)*Var.h;
  figure
  plot(time,result_z)
  hold on
  plot([0,Var.end_time],[Var.sp_alt,Var.sp_alt])