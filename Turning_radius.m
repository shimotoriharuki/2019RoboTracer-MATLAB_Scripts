% パラメータ
Rotation_point_from_axle = 25.006;      %[mm]
Sensor_bar_lengt = 87.745;              %[mm]
T = 112;                                %トレッド[mm]
AD = linspace(0, 127, 128);
RAD_PER_AD = 0.02181661565;   %AD1変化あたりの角度[rad]
theta = AD * RAD_PER_AD; %AD値における角度0～160[deg]のラジアン

% センサの先の座標計算
x = Sensor_bar_lengt * sin(theta);
y = Rotation_point_from_axle + Sensor_bar_lengt* cos(theta);

% 二等辺三角形の底辺と角度を計算
Base = sqrt((x).^2 + (y).^2); %底辺
Phi = atan(y ./ x);           %角度

%曲率半径を計算
R = (Base ./ 2) ./ cos(Phi);

%曲率半径から左右の速度差の比を計算
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
title('ステアの角度における車輪の速度比')
xlabel('ステアの角度[rad]') 
ylabel('速度比') 
% legend({'vl','vr'}, vl, vr);

subplot(2,1,2);
plot(theta, R);
title('ステアの角度における曲率半径')
xlabel('ステアの角度[rad]') 
ylabel('曲率半径[mm]') 
ylim([0 1000])