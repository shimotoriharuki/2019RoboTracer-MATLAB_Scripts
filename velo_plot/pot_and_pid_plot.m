load running_log/pot_log.txt;
load running_log/pid_log.txt;

log_number = numel(pot_log);
log_x = linspace(0, log_number, log_number);

subplot(2,1,1);
plot(log_x, pid_log);
ylim([-2024 2024]);
subplot(2,1,2);

plot(log_x, pot_log);
ylim([-450 450]);
