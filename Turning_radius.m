% �p�����[�^
Rotation_point_from_axle = 25.006;      %[mm]
Sensor_bar_lengt = 87.745;              %[mm]
T = 112;                                %�g���b�h[mm]
AD = linspace(0, 127, 128);
RAD_PER_AD = 0.02181661565;   %AD1�ω�������̊p�x[rad]
theta = AD * RAD_PER_AD; %AD�l�ɂ�����p�x0�`160[deg]�̃��W�A��

% �Z���T�̐�̍��W�v�Z
x = Sensor_bar_lengt * sin(theta);
y = Rotation_point_from_axle + Sensor_bar_lengt* cos(theta);

% �񓙕ӎO�p�`�̒�ӂƊp�x���v�Z
Base = sqrt((x).^2 + (y).^2); %���
Phi = atan(y ./ x);           %�p�x

%�ȗ����a���v�Z
R = (Base ./ 2) ./ cos(Phi);

%�ȗ����a���獶�E�̑��x���̔���v�Z
vl = (R + T./2) ./ R;
vr = (R - T./2) ./ R;

fprintf('vl\n');
fprintf('%f, ',vl);
fprintf('\n');

fprintf('vr\n');
fprintf('%f, ',vr);
fprintf('\n');

subplot(2,1,1);
plot(theta, vl, theta, vr);
title('�X�e�A�̊p�x�ɂ�����ԗւ̑��x��')
xlabel('�X�e�A�̊p�x[rad]') 
ylabel('���x��') 
% legend({'vl','vr'}, vl, vr);

subplot(2,1,2);
plot(theta, R);
title('�X�e�A�̊p�x�ɂ�����ȗ����a')
xlabel('�X�e�A�̊p�x[rad]') 
ylabel('�ȗ����a[mm]') 
ylim([0 1000])