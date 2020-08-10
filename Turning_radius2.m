% パラメータ
Rotation_point_from_axle = 25;      %[mm] ホイールベースみたいなやつ
T = 350;                                %トレッド[mm] 112    90なら一応曲がれた
AD_resolution = 2048;
AD = linspace(0, AD_resolution - 1, AD_resolution);
RAD_PER_AD = deg2rad(160 ./ AD_resolution);   %AD1変化あたりの角度[rad] 0.02181661565
theta = AD * RAD_PER_AD; %AD値における角度0～160[deg]のラジアン[rad]
deg = theta * 180 ./ pi();

%旋回半径
R = Rotation_point_from_axle ./ tan(theta);

%曲率半径から左右の速度差の比を計算
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
title('ステアの角度における車輪の速度比')
xlabel('ステアの角度[rad]') 
ylabel('速度比') 
ylim([-4 4]);

subplot(2,1,2);
plot(theta_128, R_128);
title('ステアの角度における曲率半径')
xlabel('ステアの角度[rad]') 
ylabel('曲率半径[mm]') 
ylim([0 1000]);