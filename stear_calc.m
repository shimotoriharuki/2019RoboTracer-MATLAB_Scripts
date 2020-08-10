%------------------------------------------------ステア計算--------------------------------------
%パラメータ
Vm = 3;  % R10のカーブを曲がる目標速度[m/s]
dt = 0.001;  % 制御周期[s]
ta = 0.001;  % 目標角速度に達する時間[s]
Ji = 20.807;  % inventorで計算したステアの慣性モーメント[kg*mm^2] 21.458
J = Ji * 10^-6; %慣性モーメントを単位換算[kg*m^2]
R_curve = 0.1; % カーブの曲率半径[m]

deg_stear_need = 0.5;    %inventorで求めたR10を曲がるときの制御周期ごとのステアの角度[deg]
rad_stear_need = 2 * pi * deg_stear_need / 360;
omega_stear_need = rad_stear_need / dt;

% 機体がカーブを目標速度で曲がるときの角速度
% omega_body = Vm / R_curve;

% 上記の角速度で制御周期ごとにステアを切る角度
% theta_stear_need = omega_body * dt;  % 近似値

% 上記の角速度で制御周期ごとにステアを切る角速度
% omega_stear_need = theta_stear_need / dt; % 近似値

% ステアに必要な角加速度
alfa_stear_need = omega_stear_need / ta;

% 上記の角加速度を出すために必要なトルク
Torque_stear_need = alfa_stear_need * J;

P_need = omega_stear_need * Torque_stear_need;  %ステアに必要な出力

fprintf('************************************************************************\n');
fprintf('必要なステアの角速度 　: %f [rad/s]\n', omega_stear_need);
fprintf('必要なステアの角加速度 : %f [rad/s^2]\n', alfa_stear_need);
fprintf('必要なステアのトルク 　: %f [Nm]\n', Torque_stear_need);
fprintf('必要なステアの出力   　: %f [W]\n', P_need);


%%%

%------------------------------------------------VCM計算--------------------------------------
%パラメータ
B = 0.7618; %コイルがある地点の磁束密度[T]   ヨークなし　R=40 r=20 C=10 a=60 距離1=3 距離2=3
r_out = 0.039;   %磁石の外半径[m] ステアの動きに関係ある
r_in = 0.021;    %磁石の内半径[m] ステアの動きに関係ある
N = 100; % コイルの巻き線数[回]
Conductor_resistance = 0.1417;  % 導体抵抗[Ω/m]0.2739   変数0.1
Conductor_approximate_mass = 1.1; %導体の概算質量[kg/km]
coil_side = 0.025;  %コイルを四角で巻くとして1辺の長さ[m]     変数
if coil_side >= (r_out - r_in) 
    L = r_out - r_in; %磁束を横切る導体長[m]
else
    L = coil_side; %磁束を横切る導体長[m]
end

coil_length = 0.112 * N;   %コイルの銅線の長さ[m]
Resistance_coil = Conductor_resistance * coil_length; %コイルの抵抗[Ω] ステアの動きに関係ある
coil_wight = Conductor_approximate_mass * coil_length;  %コイルの重さ[g]

Voltage = 7.4;  % 印加電圧[V] ステアの動きに関係ある
I = Voltage / Resistance_coil;  % 流れる電流[A]
R_stear = (r_out + r_in) / 2; % コイルの中心から回転軸までの距離[m]


%電圧を印加した際に得られる力
F = B * I * L * N * 2 ;  %コイルが行って帰ってくる分で2倍

%ステアが出せるトルク
Torque_stear = R_stear * F;

%ステアが出せる角加速度
alfa_stear = Torque_stear / J;

%ta秒後のステアの角速度
omega_stear = alfa_stear * ta;

% P = Voltage * I;    %出力
P = Torque_stear * omega_stear;

fprintf('-------------------------------------------------------------------------\n');
fprintf('ta秒後のステアの角速度 : %f [rad/s]\n', omega_stear);
fprintf('ステアが出せる角加速度 : %f [rad/s^2]\n', alfa_stear);
fprintf('ステアが出せるトルク   : %f [Nm]\n', Torque_stear);
fprintf('コイルに流れる電流 　　: %f [A]\n', I);
fprintf('コイルの長さ 　　　　　: %f [m]\n', coil_length);
fprintf('コイルの重さ 　　　　　: %f [g]\n', coil_wight);
fprintf('VCMの出力             : %f [W]\n', P);
fprintf('************************************************************************\n');
