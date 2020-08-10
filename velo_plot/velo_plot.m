%{
load folder_1/velo_log9.txt;  
load folder_1/velo_log5.txt;  
load folder_1/velo_log2.txt;  
% load folder_1/velo_log1.txt;  

load folder_2/velo_log_R.txt;
load folder_2/velo_log_L.txt;

load folder_2/velo_log_R_ff1000.txt;
load folder_2/velo_log_L_ff1000.txt;

load folder_2/velo_log_R_onlyff.txt;
load folder_2/velo_log_L_onlyff.txt;

load folder_2/velo_log_R_ff500.txt;
load folder_2/velo_log_L_ff500.txt;

load folder_2/velo_log_R_ff1500.txt;
load folder_2/velo_log_L_ff1500.txt;

load folder_2/velo_log_R_ff2000.txt;
load folder_2/velo_log_L_ff2000.txt;

load folder_2/velo_log_R_ffhenka.txt;
load folder_2/velo_log_L_ffhenka.txt;
%}
load folder_3/run_veloR.txt;
load folder_3/run_veloL.txt;

load folder_4/velo_log_R_ff_afr.txt;
load folder_4/velo_log_L_ff_afr.txt;

load folder_5/target_speed_L.txt;
load folder_5/target_speed_R.txt;
load folder_5/now_speed_L.txt;
load folder_5/now_speed_R.txt;

load folder_6/target_speed_L.txt;
load folder_6/target_speed_R.txt;
load folder_6/now_speed_L.txt;
load folder_6/now_speed_R.txt;

load running_log/log.txt;
load running_log/imu_log.txt;
load running_log/pot_log.txt;
load running_log/velo_log.txt;


x = linspace(1,800, 800)';
x1 = linspace(1,1100, 1100)';


y2000 = linspace(2000,2000, 800)';
y1500 = linspace(1500,1500, 800)';
y1000 = linspace(1000,1000, 800)';
y500 = linspace(500,500, 800)';

y1_1000 = linspace(1000,1000, 1100)';
y1_1400 = linspace(1400,1400, 1100)';

x_1500 = linspace(1, 1500, 1500)';


% log_number = numel(imu_log);
% log_x = linspace(0, log_number, log_number);

% % plot(x, velo_log1, x, velo_log2,x, velo_log5, x, velo_log9);
%{
plot(x, velo_log_L, x, velo_log_R);

hold on
plot(x, y2000, x, y1500, x, y1000, x, y500)
hold off
xlabel('time[ms]')
ylabel('velocity[mm/s]')
legend("Leftt speed with speed control only", "Right speed with speed control only")
%}

hold on
% plot(x, velo_log_L_ffhenka, x, velo_log_R_ffhenka)
hold off

plot(x1, run_veloL, x1, run_veloR);

% legend("veloL", "veloR", "onlyffveloL", "onlyffveloR", "ffveloL1000", "ffveloR1000", "ffveloL500", "ffveloR500", "ffveloL1500", "ffveloR1500", "ffveloL12000", "ffveloR2000");


plot(x_1500, velo_log_L_ff_afr, x_1500, velo_log_R_ff_afr);

xlabel('time[ms]')
ylabel('velocity[mm/s]')
legend("Leftt speed with speed control and FF", "Right speed with speed control and FF")
% plot(x1, now_speed_L, x1, now_speed_R, x1, target_speed_L, x1, target_speed_R);
% legend("now speed_L", "now speed_R", "target speed_L", "target speed_R");

% plot(x1, now_speed_L, x1, now_speed_R, x1, target_speed_L, x1, target_speed_R);
% legend("now speed_L", "now speed_R", "target speed_L", "target speed_R");

% plot(log_x, imu_log, log_x, pot_log);
% legend("imu log", "pot log")
% xlim([0 1000]);
% ylim([-10 10]);
% plot(log_x, velo_log);
