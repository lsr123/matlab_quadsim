%	StarryPilot MatSim
%	Author: Jiachi Zou
%	06/15/2018
% 
% clear all;  %     ��������һ������ʱ��Ҫclear
% clc;          %�Ż�ʱ���ж�飬ȥ��clear

global Var;

%% initialization
init_var;
% init_disp;
Var.adrc_enable = true;   %�Ƿ�ʹ��adrc����
Var.disturb_hd = false;   %�Ƿ�����Ŷ�
Var.fix_pos_hd = false;   %�Ƿ�̶�λ��
% ADRC_ENABLE = 0;

%% execute simulator
while 1
%     start_val = get(Var.start_hd, 'value');   %��ʼ
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
    test; %�趨Ŀ��ֵ
    
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
% ������ۺ���ֵ
  cal_fitness;
  %�����ƽ�
  Var.sim_time = Var.sim_time + Var.h;
  
  if Var.sim_time > Var.end_time
      break;
  end
 
end

  %�ı���������� 
%   if Var.sim_time > 6
%    roll_adrc.beta1 = 104;
%   end

% draw_result

