% 時計回り
load imu_data_0.txt;  %0[rad/s]
load imu_data_1.txt;  %1[rad/s]
load imu_data_5.txt; %5[rad/s]
load imu_data_10.txt; %10[rad/s]
load test_run.txt; %10[rad/s]
load imu_data_.txt; %生データ
load pot_data.txt; %生データ
load lowpassed_pot.txt; %生データ

t = linspace(0,2,2499);

% imu_data_0 = imu_data_0.';
% imu_data_0 = imu_data_0(20:end);

imu_data_1 = imu_data_1.';
% imu_data_1 = imu_data_1(87:end);

imu_data_5 = imu_data_5.';
% imu_data_5 = imu_data_5(8:1336);

imu_data_10 = imu_data_10.';
% imu_data_10 = imu_data_10(8:1336);

test_run = test_run .';

imu_data_ = imu_data_ .';
pot_data = pot_data.';
lowpassed_pot = lowpassed_pot.';

rad0 = -mean(imu_data_0);
rad1 = -mean(imu_data_1);
rad5 = -mean(imu_data_5);
rad10 = -mean(imu_data_10);

i = [0, 1, 5, 10];
data = [rad0, rad1, rad5, rad10];


p = polyfit(data,i,1);
y2 = polyval(p,data);

j = linspace(0, 2087, 2087);
jj = linspace(0, 2074, 2074);
jjj = linspace(0, 2000, 2000);
% plot(data, i, data, y2);
test_run = lowpass(test_run,1,1000);
imu_data_ = lowpass(imu_data_,1,1000);
pot_data = lowpass(pot_data,1,500);

integ_pot = cumtrapz(pot_data);
diff_pot = diff(pot_data);

% plot(j, pot_data, jj, imu_data_);
% plot(j, integ_pot, j, pot_data);
plot(jjj, lowpassed_pot);
% ylim([-1000, 1000]);
