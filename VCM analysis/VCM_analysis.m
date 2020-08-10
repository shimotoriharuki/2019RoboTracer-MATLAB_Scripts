load 'Angle log/Angle.txt'
data_number = 30;
Angle = Angle(1 : data_number, 1); %必要なデータだけ切り取る

n = length(Angle);
t = linspace(0, data_number, data_number)';

%---------------元データをプロット---------------%
subplot(3, 1, 1);
plot(t, Angle);

xlim([0 data_number - 2]);
xlabel('Time[ms]');
ylabel('Angle[rad]');
title('Theta - Time graph');
legend("元データ")


%---------------データの近似曲線をもとめる---------------%
p = polyfit(t, Angle, 2);
fAngle = polyval(p,t);

a = p(:,1);
b = p(:,2);
c = p(:,3);

syms s;
y = a * s^2 + b * s + c ;

hold on
fplot(y, [0, 30]);
legend("近似曲線")
hold off

%--------------1階微分----------------%
Omega = diff(y) / 0.001;
t(data_number, :) = []; %要素をへらす

subplot(3, 1, 2);
fplot(Omega, [0, 30]);
xlim([0 data_number - 2]);
xlabel('Time[ms]');
ylabel('Omega[rad/s]');
title('Omega - Time graph');

%--------------2階微分----------------%
Alpha = diff(Omega) / 0.001;
t(data_number - 1, :) = []; %要素をへらす

subplot(3, 1, 3);
fplot(Alpha, [0, 30]);
xlim([0 data_number - 2]);
xlabel('Time[ms]');
ylabel('Alpha[rad/s^2]');
title('Alpha - Time graph');
