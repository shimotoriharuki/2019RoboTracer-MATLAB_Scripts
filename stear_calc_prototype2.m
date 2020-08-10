%------------------------------------------------�X�e�A�v�Z--------------------------------------
%�p�����[�^
Vm = 3;  % R10�̃J�[�u���Ȃ���ڕW���x[m/s]
dt = 0.001;  % �������[s]
ta = 0.001;  % �ڕW�p���x�ɒB���鎞��[s]
Ji = 23.600;  % inventor�Ōv�Z�����X�e�A�̊������[�����g[kg*mm^2] 21.458
J = Ji * 10^-6; %�������[�����g��P�ʊ��Z[kg*m^2]
R_curve = 0.1; % �J�[�u�̋ȗ����a[m]

deg_stear_need = 0.1;    %inventor�ŋ��߂�R10���Ȃ���Ƃ��̐���������Ƃ̃X�e�A�̊p�x[deg]
rad_stear_need = 2 * pi * deg_stear_need / 360;
omega_stear_need = rad_stear_need / dt;

% �X�e�A�ɕK�v�Ȋp�����x
alfa_stear_need = omega_stear_need / ta;

% ��L�̊p�����x���o�����߂ɕK�v�ȃg���N
Torque_stear_need = alfa_stear_need * J;

P_need = omega_stear_need * Torque_stear_need;  %�X�e�A�ɕK�v�ȏo��

fprintf('************************************************************************\n');
fprintf('�K�v�ȃX�e�A�̊p���x �@: %f [rad/s]\n', omega_stear_need);
fprintf('�K�v�ȃX�e�A�̊p�����x : %f [rad/s^2]\n', alfa_stear_need);
fprintf('�K�v�ȃX�e�A�̃g���N �@: %f [Nm]\n', Torque_stear_need);
fprintf('�K�v�ȃX�e�A�̏o��   �@: %f [W]\n', P_need);


%%%

%------------------------------------------------VCM�v�Z--------------------------------------
%�p�����[�^
B = 0.4628; %�R�C��������n�_�̎������x[T]   ���[�N�Ȃ��@R=40 r=20 C=10 a=60 ����1=3 ����2=3
r_out = 0.0316;   %���΂̊O���a[m] �X�e�A�̓����Ɋ֌W����
r_in = 0.020;    %���΂̓����a[m] �X�e�A�̓����Ɋ֌W����
N = 60; % �R�C���̊�������[��]
% Resistance_coil = 1.7;
coil_side = 0.010;  %�R�C�����l�p�Ŋ����Ƃ���1�ӂ̒���[m]     �ϐ�
if coil_side >= (r_out - r_in) 
    L = r_out - r_in; %���������؂铱�̒�[m]
else
    L = coil_side; %���������؂铱�̒�[m]
end

Conductor_resistance = 0.2739;  % ���̒�R[��/m] 0.2 = 0.5772 0.29=0.2739   �ϐ�0.4=0.1417
coil_length = 0.1009 * N;   %�R�C���̓����̒���[m]
Resistance_coil = Conductor_resistance * coil_length; %�R�C���̒�R[��]
Voltage = 8;  % ����d��[V] �X�e�A�̓����Ɋ֌W����
I = Voltage / Resistance_coil;  % �����d��[A]
R_stear = (r_out + r_in) / 2; % �R�C���̒��S�����]���܂ł̋���[m]


%�d������������ۂɓ������
F = B * I * L * N * 2  ;  %�R�C�����s���ċA���Ă��镪��2�{

%�X�e�A���o����g���N
Torque_stear = R_stear * F;

%�X�e�A���o����p�����x
alfa_stear = Torque_stear / J;

%ta�b��̃X�e�A�̊p���x
omega_stear = alfa_stear * ta;

% P = Voltage * I;    %�o��
P = Torque_stear * omega_stear;

fprintf('-------------------------------------------------------------------------\n');
fprintf('ta�b��̃X�e�A�̊p���x : %f [rad/s]\n', omega_stear);
fprintf('�X�e�A���o����p�����x : %f [rad/s^2]\n', alfa_stear);
fprintf('�X�e�A���o����g���N   : %f [Nm]\n', Torque_stear);
fprintf('�R�C���ɗ����d�� �@�@: %f [A]\n', I);
fprintf('VCM�̏o��             : %f [W]\n', P);
fprintf('************************************************************************\n');

%% MEMO

%R=31.6 r=20 h=5 75deg m=14.69[g]
% �������x 4354
% ta�b��̃X�e�A�̊p���x : 2.239944 [rad/s]
% �X�e�A���o����p�����x : 2239.944167 [rad/s^2]

%R=40 r=31.6 h=5 60deg  m=11.81[g]
% �������x 4122
% ta�b��̃X�e�A�̊p���x : 2.471721 [rad/s]
% �X�e�A���o����p�����x : 2471.720518 [rad/s^2]

%R=25 r=20 h=5 90deg m=1.33[g]
% �������x 1099
% ta�b��̃X�e�A�̊p���x : 0.246535 [rad/s]
% �X�e�A���o����p�����x : 246.535394 [rad/s^2]
%
% 
% 
% 
% 
% 