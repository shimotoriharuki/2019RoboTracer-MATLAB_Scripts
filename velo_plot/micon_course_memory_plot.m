load speed_plan/original.txt;
load speed_plan/fixed.txt;
load course_memory/radius.txt;
% load replay/radius_long.txt;

log_number = numel(original);
log_x = linspace(0, log_number, log_number)';

y_max = 5500;
x_max = 300;

subplot(3, 1, 1);
plot(log_x, radius);
ylim([-5500, 5500]);
xlim([0, x_max]);

subplot(3, 1, 2);
plot(log_x, original);
ylim([0, y_max]);
xlim([0, x_max]);

subplot(3, 1, 3);
plot(log_x, fixed);
ylim([900, 5500]);
xlim([0, x_max]);

