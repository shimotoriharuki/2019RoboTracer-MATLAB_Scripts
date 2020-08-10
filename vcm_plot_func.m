
% fn = "vcm_rad_data.txt";
% fn = "vcm_rad_data256.txt";
% fn = "vcm_rad_data512.txt";
% fn = "vcm_rad_data1024.txt";
% fn = "MaxPower1024.txt";
% fn = "MaxPower512.txt";
% fn = "MaxPower256.txt";
% fn = "increment512.txt"; %Å‰‚Éæ‚Á‚½ƒf[ƒ^
fn = "increment512_2.txt";%“®‰æ‚Ì“z

x = 1:100;

rad_data = load(fn);
rad_data = rad_data';
p = polyfit(x,rad_data,4);
rad = polyval(p,x);
rad = rad';

a = p(:,1);
b = p(:,2);
c = p(:,3);
d = p(:,4);
e = p(:,5);

syms s;
y = a*s^4 + b*s^3 + c*s^2 + d*s + e;

error = ((rad_data - rad') ./ rad_data)*100;

subplot(3,1,1);
T = table(rad, rad_data', error' ,'VariableNames',{'rad','rad_data','FitError'});
% T(2,;) = 

fplot(y,[0,100]);
title('func ‘S—Í‚Åñ‚ğU‚Á‚½‚ÌŠp“x')
xlabel('Time[ms]')
ylabel('Angle[rad]')

subplot(3,1,2);

omega = diff(y)/0.001;
fplot(omega,[0,100]);
title('func Šp‘¬“x')
xlabel('Time[ms]')
ylabel('Angular_velocityee[rad/s]')

subplot(3,1,3);
alpha = diff(omega)/0.001;
fplot(alpha,[0,100]);
title('func Šp‰Á‘¬“x')
xlabel('Time[ms]')
ylabel('Angular acceleration[rad/s^2]')



