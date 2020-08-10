load folder_0/imu_log1.txt;  
load folder_0/imu_log2.txt;  

x = linspace(1,1000, 1000)';

plot(x, imu_log1, x, imu_log2);
% plot(x, imu_log]1);


