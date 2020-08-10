load course_memory/radius.txt;
load course_memory/speed_plan.txt;

log_number = numel(radius);
log_x = linspace(0, log_number, log_number);
%{
subplot(2,1,1);
plot(log_x, radius);
ylim([-6000, 6000]);
xlim([0, 500]);

subplot(2,1,2);
plot(log_x, speed_plan);
ylim([0, 6500]);
xlim([0, 500]);
%}

limit = 3000;
jimit = 0;
temp = zeros(limit);
max_acc = 1000;    % [mm/ss]
max_dec = 100;    % [mm/ss]
l = 10; %[mm]
speed_plan_p = circshift(speed_plan, -1);
speed_plan_o = speed_plan;

%繰り返さないやつ
%{
for index = 1 : limit
    velo_diff = abs(speed_plan_p(index, 1) - speed_plan_o(index, 1));   %[mm/s]

    t = l / velo_diff;  %[s]
    now_acc = velo_diff / t;    %[mm/ss]

   if (abs(now_acc) > max_acc && speed_plan_p(index, 1) > speed_plan_o(index, 1)) %加速度が足りない　かつ　加速するとき
      speed_plan_p(index, 1) = sqrt(max_acc * l) + speed_plan_o(index, 1);
      speed_plan_o = circshift(speed_plan_p, 1);
      disp("acc");
   end
end
%}
R_speed_plan_o = flipud(speed_plan_o);
R_speed_plan_p = circshift(R_speed_plan_o, 1);

% 減速調整
for index = 1 : limit
    velo_diff = abs(R_speed_plan_p(index, 1) - R_speed_plan_o(index, 1));%[mm/s]

    t = l / velo_diff;%[s]
    now_acc = velo_diff / t;%[mm/ss]

   if (abs(now_acc) > max_dec && R_speed_plan_p(index, 1) > R_speed_plan_o(index, 1)) %加速度が足りない　かつ　減速するとき
      R_speed_plan_p(index, 1) = R_speed_plan_o(index, 1);
      R_speed_plan_o = circshift(R_speed_plan_p, -1);

   end

%  temp(index, 1) = speed_plan_o(index, 1);

end
speed_plan_o = flipud(R_speed_plan_o);

subplot(2,1,1);
plot(log_x, speed_plan);
ylim([0, 6500]);
xlim([0, 500]);
title('Origin');


subplot(2,1,2);
plot(log_x, speed_plan_o);
ylim([0, 6500]);
xlim([0, 500]);
title('Fix acceleration')

% 繰り返す奴

speed_plan_p = circshift(speed_plan, -1);
speed_plan_o = speed_plan;
% 加速調整
for j = 1 : jimit
    for index = 1 : limit
        velo_diff = abs(speed_plan_p(index, 1) - speed_plan_o(index, 1));%[mm/s]

        t = l / velo_diff;%[s]
        now_acc = velo_diff / t;%[mm/ss]

       if (abs(now_acc) > max_acc && speed_plan_p(index, 1) > speed_plan_o(index, 1)) %加速度が足りない　かつ　加速するとき
          speed_plan_p(index, 1) = (speed_plan_p(index, 1) + speed_plan_o(index, 1)) / 2; %一個後の値を更新する
    %       speed_plan_p(index, 1) = speed_plan_o(index, 1); %一個後の値を更新する
          speed_plan_o = circshift(speed_plan_p, 1);
          disp("acc");


       end

    %  temp(index, 1) = speed_plan_o(index, 1);

    end



end

R_speed_plan_o = flipud(speed_plan_o);
R_speed_plan_p = circshift(R_speed_plan_o, -1);
    
for j = 1 : jimit
   % 減速調整
    for index = 1 : limit
        velo_diff = abs(R_speed_plan_p(index, 1) - R_speed_plan_o(index, 1));%[mm/s]

        t = l / velo_diff;%[s]
        now_acc = velo_diff / t;%[mm/ss]

       if (abs(now_acc) > max_dec && R_speed_plan_p(index, 1) > R_speed_plan_o(index, 1)) %加速度が足りない　かつ　減速するとき
          R_speed_plan_p(index, 1) = (R_speed_plan_p(index, 1) + R_speed_plan_o(index, 1)) / 2; %今の値を更新する
    %       R_speed_plan_p(index, 1) = R_speed_plan_o(index, 1); %今の値を更新する
          R_speed_plan_o = circshift(R_speed_plan_p, 1);
%           disp("dec");
%           disp(now_acc);

       end

    %  temp(index, 1) = speed_plan_o(index, 1);

    end
end

speed_plan_o = flipud(R_speed_plan_o);



%{
hold on
subplot(2,1,1);
plot(log_x, speed_plan);
ylim([0, 6500]);
xlim([0, 500]);
title('Origin');


subplot(2,1,2);
plot(log_x, speed_plan_o);
ylim([0, 6500]);
xlim([0, 500]);
title('Fix acceleration')

hold off
% title("Fix deceleration");
%}

