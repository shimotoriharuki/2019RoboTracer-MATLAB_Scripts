
% fn = "vcm_rad_data.txt";
% fn = "vcm_rad_data256.txt";
% fn = "vcm_rad_data512.txt";
% fn = "vcm_rad_data1024.txt";
% fn = "MaxPower1024.txt";
% fn = "MaxPower512.txt";
% fn = "MaxPower256.txt";
fn = "increment512.txt"; %�ŏ��Ɏ�����f�[�^
% fn = "increment512_2.txt";%����̓z

x = 1:100;

rad = load(fn);

% sm_rad = polyfit(x ,(rad)', 3); 


rad_shift = circshift(rad,-1);
rad_shift(end,:) = rad(end,:);
velo = (rad_shift - rad) / 0.001;
sm_velo = smoothdata(velo);


velo_shift = circshift(sm_velo,-1);
velo_shift(end,:) = velo(end,:);
acc = (velo_shift - sm_velo) / 0.001;
sm_acc = smoothdata(acc);




subplot(3,1,1);

plot(x, rad);
title('�S�͂Ŏ��U�������̊p�x')
xlabel('Time[ms]')
ylabel('Angle[rad]')

subplot(3,1,2);

% plot(x, velo, x, sm_velo);
plot(x, velo, x, sm_velo);
title('�p���x')
xlabel('Time[ms]')
ylabel('Angular_velocitye[rad/s]')
legend('�v�Z�l','�ړ�����')

subplot(3,1,3);
% plot(x, acc, x, sm_acc);
plot(x, acc, x, sm_acc);
title('�p�����x')
xlabel('Time[ms]')
ylabel('Angular acceleration[rad/s^2]')
legend('�v�Z�l','�ړ�����')
