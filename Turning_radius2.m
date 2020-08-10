% �p�����[�^
Rotation_point_from_axle = 25;      %[mm] �z�C�[���x�[�X�݂����Ȃ��
T = 350;                                %�g���b�h[mm] 112    90�Ȃ�ꉞ�Ȃ��ꂽ
AD_resolution = 2048;
AD = linspace(0, AD_resolution - 1, AD_resolution);
RAD_PER_AD = deg2rad(160 ./ AD_resolution);   %AD1�ω�������̊p�x[rad] 0.02181661565
theta = AD * RAD_PER_AD; %AD�l�ɂ�����p�x0�`160[deg]�̃��W�A��[rad]
deg = theta * 180 ./ pi();

%���񔼌a
R = Rotation_point_from_axle ./ tan(theta);

%�ȗ����a���獶�E�̑��x���̔���v�Z
vl = (R + (T./2)) ./ R;
vr = (R - (T./2)) ./ R;

vl_128 = vl(1:128);
vr_128 = vr(1:128);
theta_128 = theta(1:128);
R_128 = R(1:128);

fprintf('vl\n');
fprintf('%f, ',vl_128);
fprintf('\n');

fprintf('vr\n');
fprintf('%f, ',vr_128);
fprintf('\n');


subplot(2,1,1);
plot(theta_128, vl_128, theta_128, vr_128);
title('�X�e�A�̊p�x�ɂ�����ԗւ̑��x��')
xlabel('�X�e�A�̊p�x[rad]') 
ylabel('���x��') 
ylim([-4 4]);

subplot(2,1,2);
plot(theta_128, R_128);
title('�X�e�A�̊p�x�ɂ�����ȗ����a')
xlabel('�X�e�A�̊p�x[rad]') 
ylabel('�ȗ����a[mm]') 
ylim([0 1000]);