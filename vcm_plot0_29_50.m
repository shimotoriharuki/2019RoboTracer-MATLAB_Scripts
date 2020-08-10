
fn1 = "increment512.txt";
fn2 = "increment512_2.txt";
fn3 = "increment512_3.txt";
fn4 = "increment512_4.txt";
fn5 = "increment512_5.txt";

rad1 = load(fn1);
rad2 = load(fn2);
rad3 = load(fn3);
rad4 = load(fn4);
rad5 = load(fn5);
% sm_rad = smoothdata(rad);


rad_shift1 = circshift(rad1,-1);
rad_shift1(end,:) = rad1(end,:);
rad_shift2 = circshift(rad2,-1);
rad_shift2(end,:) = rad2(end,:);
rad_shift3 = circshift(rad3,-1);
rad_shift3(end,:) = rad3(end,:);
rad_shift4 = circshift(rad4,-1);
rad_shift4(end,:) = rad4(end,:);
rad_shift5 = circshift(rad5,-1);
rad_shift5(end,:) = rad5(end,:);

velo1 = (rad_shift1 - rad1) / 0.001;
sm_velo1 = smoothdata(velo1);
velo2 = (rad_shift2 - rad2) / 0.001;
sm_velo2 = smoothdata(velo2);
velo3 = (rad_shift3 - rad3) / 0.001;
sm_velo3 = smoothdata(velo3);
velo4 = (rad_shift4 - rad4) / 0.001;
sm_velo4 = smoothdata(velo4);
velo5 = (rad_shift5 - rad5) / 0.001;
sm_velo5 = smoothdata(velo5);

velo_shift1 = circshift(sm_velo1,-1);
velo_shift1(end,:) = sm_velo1(end,:);
velo_shift2 = circshift(sm_velo2,-1);
velo_shift2(end,:) = sm_velo2(end,:);
velo_shift3 = circshift(sm_velo3,-1);
velo_shift3(end,:) = sm_velo3(end,:);
velo_shift4 = circshift(sm_velo4,-1);
velo_shift4(end,:) = sm_velo4(end,:);
velo_shift5 = circshift(sm_velo5,-1);
velo_shift5(end,:) = sm_velo5(end,:);

acc1 = (velo_shift1 - sm_velo1) / 0.001;
sm_acc1 = smoothdata(acc1);
acc2 = (velo_shift2 - sm_velo2) / 0.001;
sm_acc2 = smoothdata(acc2);
acc3 = (velo_shift3 - sm_velo3) / 0.001;
sm_acc3 = smoothdata(acc3);
acc4 = (velo_shift4 - sm_velo4) / 0.001;
sm_acc4 = smoothdata(acc4);
acc5 = (velo_shift5 - sm_velo5) / 0.001;
sm_acc5 = smoothdata(acc5);

x = 1:100;

% cftool(x, velo);
% cftool(x, acc);

subplot(3,1,1);


plot(x, rad1, x, rad2, x, rad3, x, rad4, x, rad5);
% plot(rad1);
title('rad 0.29 50')
legend('rad1','rad2','rad3','rad4','rad5')

subplot(3,1,2);

plot(x, sm_velo1, x, sm_velo2, x, sm_velo3, x, sm_velo4, x, sm_velo5);
% plot(velo);
title('vel')
legend('rad1','rad2','rad3','rad4','rad5')

subplot(3,1,3);
plot(x, sm_acc1, x, sm_acc2, x, sm_acc3, x, sm_acc4, x, sm_acc5);
% plot(acc);
title('acc')
legend('rad1','rad2','rad3','rad4','rad5')