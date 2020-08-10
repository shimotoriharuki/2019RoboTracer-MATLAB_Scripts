
% fn = "vcm_rad_data.txt";
% fn = "vcm_rad_data256.txt";
% fn = "vcm_rad_data512.txt";
% fn = "vcm_rad_data1024.txt";
% fn = "MaxPower1024.txt";
% fn = "MaxPower512.txt";
% fn = "MaxPower256.txt";
% fn = "increment512.txt"; %最初に取ったデータ
fn = "increment512_2.txt";%動画の奴

x = 1:100;

rad_data = load(fn);
rad_data = rad_data';
p = polyfit(x,rad_data,4);
rad = polyval(p,x);
rad = rad';

a = p(:,1);
b = p(:,2);
c = p(:,3);
d = p(:,4);
e = p(:,5);

% syms s;
% % y = a*s^4 + b*s^3 + c*s^2 + d*s + e;
% fplot(y);

% plot(x, rad, x, rad);


rad_shift = circshift(rad,-1);
% rad_shift(end,:) = rad(end,:);
velo = (rad_shift - rad) / 0.001;
% sm_velo = smoothdata(velo);


velo_shift = circshift(velo,-1);
% velo_shift(end,:) = velo(end,:);
acc = (velo_shift - velo) / 0.001;
% sm_acc = smoothdata(acc);


% subplot(3,1,1);

plot(x, rad_data, x, rad);
title('全力で首を振った時の角度')
xlabel('Time[ms]')
ylabel('Angle[rad]')
legend('元データ','近似曲線')

%{
subplot(3,1,2);
% plot(x, velo, x, sm_velo);
plot(x, velo);
title('角速度')
xlabel('Time[ms]')
ylabel('Angular_velocitye[rad/s]')
legend('計算値')
ylim([-2 40])

subplot(3,1,3);
% plot(x, acc, x, sm_acc);
plot(x, acc);
title('角加速度')
xlabel('Time[ms]')
ylabel('Angular acceleration[rad/s^2]')
legend('計算値')
ylim([0 700])
%}
