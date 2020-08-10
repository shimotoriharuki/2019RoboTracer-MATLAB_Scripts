%�p�����[�^
T = 120;    %�g���b�h[mm]
Height_G = 8;   %�d�S����[mm]
myu = tan(60 * 2 * pi / 360);   %���C�W��
g = 9.81;   %�d�͉����x
M = 100 * 10^-3;  %�@�̏d��[kg]
r_wheel = 10; %�ԗ֔��a[mm]
L_wheel = 2 * pi * r_wheel; %�ԗ֊O����[mm]
a = 20; %�ڕW�����x[m/s^2]
Vm = 9;    %�ڕW�ō����x[m/s]
N_wheel = 2;    %�쓮�֐�[��](�ϑ��l�ւ�2�Ƃ��čl������)
i_gear = 1.94;  %������@//1.85 : 1
Nm_motor = 20054 / 60;   %���[�^�̍ő��]��[rps]
Tm_motor = 9.033 * 10^-3;    %���[�^�̍ő�g���N[Nm]
gear_efficiency = 0.9;  %�M�A�̌���
N_motor = Nm_motor * gear_efficiency;   %�������l���������[�^��]��[rps]
T_motor = Tm_motor * gear_efficiency;   %�������l���������[�^�g���N[Nm]
module = 0.3;   %�M�A�̃��W���[��


%------------------------------------------------������ƕ����オ��A�E�B���[���Ȃ��d�S�����A�X���b�v���Ȃ������x--------------------------------------%
fprintf('************************************************************************\n');
fprintf('R10�ŉ����肵�Ȃ��ő呬�x �@: %f [m/s]\n', sqrt(myu * g * 0.1));
fprintf('R10�ŉ��]���Ȃ��ő呬�x �@�@: %f [m/s]\n', sqrt(g * T * 0.1 / (2 * Height_G)));
fprintf('�ڕW�����x�ŃE�B���[���Ȃ��^�C���̐ڒn�_����d�S�܂ł̋��� �@�@: %f [mm]\n', a * Height_G / g);
fprintf('�X���b�v���Ȃ��ő�����x �@�@: %f [m/s^2]\n', myu * g);

%------------------------------------------------�ԗւɕK�v�ȉ�]���ƃg���N--------------------------------------%
fprintf('************************************************************************\n');
Tt = r_wheel * M/2 * a;
fprintf('�ڕW�����x���o�����߂ɕK�v��1�ԗւ̃g���N �@�@: %f [mNm]\n', Tt);

omega_t = Vm / r_wheel;
fprintf('�ڕW���x���o�����߂ɕK�v��1�ԗւ̊p���x �@�@  : %f [rad/s]\n', omega_t);

fprintf('�K�v�ȏo�� �@�@  : %f [W]\n', Tt * omega_t);

Nt = 60 * Vm / (L_wheel * 10^-3) ;
fprintf('�ڕW���x���o�����߂ɕK�v��1�ԗւ̉�]�� �@�@: %f [rpm]\n', Nt);

%------------------------------------------------������--------------------------------------%
fprintf('************************************************************************\n');
i_N = N_motor*60 / Nt;
fprintf('��]������̌����� �@1�@: %f []\n', i_N);

i_T = Tt / T_motor * 10^-3;
fprintf('�g���N����̌����� �@1�@: %f []\n', i_T);

%------------------------------------------------����--------------------------------------%
Num_teeth_motor = 31;   %���[�^���̎����@25 27 28 29 31
Num_teeth_wheel = fix(Num_teeth_motor * i_gear);    %�ԗ֑��̎���
Reference_circle_motor = module*Num_teeth_motor;
Reference_circle_wheel = module*Num_teeth_wheel;
Tip_circle_motor = (module * Num_teeth_motor) + 2 * module;
Tip_circle_wheel = (module * Num_teeth_wheel) + 2 * module;

fprintf('������ �@%f�@: %f \n', Num_teeth_motor, Num_teeth_wheel);
fprintf('����~���a�� �@%f�@: %f[mm] \n', Tip_circle_motor, Tip_circle_wheel);
fprintf('��~���a �@%f�@: %f [mm] \n', Reference_circle_motor, Reference_circle_wheel);


if  (Reference_circle_motor + Reference_circle_wheel) > r_wheel * 2 %�����I�ɃM�A�����ݍ����������ǂ���
    fprintf('�\');
else 
    fprintf('�s�\');
end
fprintf('\n\n\n');

