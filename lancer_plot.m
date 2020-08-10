fn = "lancer_data.txt";

data = load(fn);

t = data(:,1);
temp = data(:,2);
rad = ((1.8517*pi*temp) / 255) - 0.9258*pi;

sm_rad = smoothdata(rad);
rad_shift = circshift(sm_rad,-1);
rad_shift(end,:) = sm_rad(end,:);

velo = (rad_shift - sm_rad) / 0.001;
sm_velo = smoothdata(velo);

velo_shift = circshift(sm_velo,-1);
velo_shift(end,:) = sm_velo(end,:);

acc = (velo_shift - velo) / 0.001;
sm_acc = smoothdata(acc);

subplot(3,1,1);
plot(t, rad ,t, sm_rad);
title('rad')

subplot(3,1,2);
% plot(x, velo, x, sm_velo);
plot(t, velo, t, sm_velo);
title('vel')

subplot(3,1,3);
plot(t, acc, t, sm_acc);
% plot(x, acc, x, sm_acc);
title('acc')

