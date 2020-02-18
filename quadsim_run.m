%	StarryPilot MatSim
%	Author: Jiachi Zou
%	06/15/2018
% 
% clear all;  %     单独运行一遍仿真的时候，要clear
% clc;          %优化时运行多遍，去掉clear

global Var;

%% initialization
init_var;
% init_disp;
Var.adrc_enable = true;   %是否使用adrc控制
Var.disturb_hd = false;   %是否加入扰动
Var.fix_pos_hd = false;   %是否固定位置
% ADRC_ENABLE = 0;

%% execute simulator
while 1
%     start_val = get(Var.start_hd, 'value');   %开始
%     if ~start_val
%         drawnow limitrate;
%         continue;
%     end
    
    k = k + 1;
    
    %% read sensor data
    Sensor = get_sensor(QuadrotorState);

    % ESO
    eso;

    %% Quadrotor Control
    % altitude control
    altitude_control;
    % attitude control
    attitude_control;
    % disturbance compensation
    disturb_comp;

    % test example
    test; %设定目标值
    
    %% mix throttle according to airframe configuration
    QuadrotorControl.throttle = throttle_mix(base_throttle, QuadrotorControl.u, QuadrotorModel.airframe);
    % compensate throttle due to the delay of motor
    throttle_compensate;

    %% update quadrotor model states
    QuadrotorState = update_quadmodel( Var.h, QuadrotorControl.throttle, motor_sysd, QuadrotorModel, QuadrotorState );
    QuadrotorState.att.q = euler2quaternion(QuadrotorState.att.euler);
    
    %% update 3D model
%     Quadrotor3D = update_quadrotor_3D( Quadrotor3D, QuadrotorState );
%     draw_quadrotor_3D( Quadrotor3D, QuadrotorState );
    
    %% record and update UI
    record;
%     updateUI;

%    draw_adrc;
% 计算代价函数值
  cal_fitness;
  %迭代推进
  Var.sim_time = Var.sim_time + Var.h;
  
  if Var.sim_time > Var.end_time
      break;
  end
 
end

  %改变控制器参数 
%   if Var.sim_time > 6
%    roll_adrc.beta1 = 104;
%   end

% draw_result

