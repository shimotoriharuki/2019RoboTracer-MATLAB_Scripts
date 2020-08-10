%パラメータ
T = 120;    %トレッド[mm]
Height_G = 8;   %重心高さ[mm]
myu = tan(60 * 2 * pi / 360);   %摩擦係数
g = 9.81;   %重力加速度
M = 100 * 10^-3;  %機体重量[kg]
r_wheel = 10; %車輪半径[mm]
L_wheel = 2 * pi * r_wheel; %車輪外周長[mm]
a = 20; %目標加速度[m/s^2]
Vm = 9;    %目標最高速度[m/s]
N_wheel = 2;    %駆動輪数[個](変則四輪は2個として考えられる)
i_gear = 1.94;  %減速比　//1.85 : 1
Nm_motor = 20054 / 60;   %モータの最大回転数[rps]
Tm_motor = 9.033 * 10^-3;    %モータの最大トルク[Nm]
gear_efficiency = 0.9;  %ギアの効率
N_motor = Nm_motor * gear_efficiency;   %効率を考慮したモータ回転数[rps]
T_motor = Tm_motor * gear_efficiency;   %効率を考慮したモータトルク[Nm]
module = 0.3;   %ギアのモジュール


%------------------------------------------------横滑りと浮き上がり、ウィリーしない重心距離、スリップしない加速度--------------------------------------%
fprintf('************************************************************************\n');
fprintf('R10で横滑りしない最大速度 　: %f [m/s]\n', sqrt(myu * g * 0.1));
fprintf('R10で横転しない最大速度 　　: %f [m/s]\n', sqrt(g * T * 0.1 / (2 * Height_G)));
fprintf('目標加速度でウィリーしないタイヤの接地点から重心までの距離 　　: %f [mm]\n', a * Height_G / g);
fprintf('スリップしない最大加速度 　　: %f [m/s^2]\n', myu * g);

%------------------------------------------------車輪に必要な回転数とトルク--------------------------------------%
fprintf('************************************************************************\n');
Tt = r_wheel * M/2 * a;
fprintf('目標加速度を出すために必要な1車輪のトルク 　　: %f [mNm]\n', Tt);

omega_t = Vm / r_wheel;
fprintf('目標速度を出すために必要な1車輪の角速度 　　  : %f [rad/s]\n', omega_t);

fprintf('必要な出力 　　  : %f [W]\n', Tt * omega_t);

Nt = 60 * Vm / (L_wheel * 10^-3) ;
fprintf('目標速度を出すために必要な1車輪の回転数 　　: %f [rpm]\n', Nt);

%------------------------------------------------減速比--------------------------------------%
fprintf('************************************************************************\n');
i_N = N_motor*60 / Nt;
fprintf('回転数からの減速比 　1　: %f []\n', i_N);

i_T = Tt / T_motor * 10^-3;
fprintf('トルクからの減速比 　1　: %f []\n', i_T);

%------------------------------------------------歯数--------------------------------------%
Num_teeth_motor = 31;   %モータ側の歯数　25 27 28 29 31
Num_teeth_wheel = fix(Num_teeth_motor * i_gear);    %車輪側の歯数
Reference_circle_motor = module*Num_teeth_motor;
Reference_circle_wheel = module*Num_teeth_wheel;
Tip_circle_motor = (module * Num_teeth_motor) + 2 * module;
Tip_circle_wheel = (module * Num_teeth_wheel) + 2 * module;

fprintf('歯数比 　%f　: %f \n', Num_teeth_motor, Num_teeth_wheel);
fprintf('歯先円直径比 　%f　: %f[mm] \n', Tip_circle_motor, Tip_circle_wheel);
fprintf('基準円直径 　%f　: %f [mm] \n', Reference_circle_motor, Reference_circle_wheel);


if  (Reference_circle_motor + Reference_circle_wheel) > r_wheel * 2 %物理的にギアが噛み合う距離かどうか
    fprintf('可能');
else 
    fprintf('不可能');
end
fprintf('\n\n\n');

