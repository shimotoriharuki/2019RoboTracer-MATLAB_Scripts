fn = "increment512_2.txt";%“®‰æ‚Ì“z

t = (1:500)';

rad = load(fn);
data = [t, rad];

y = data(:, 2);
F = @(x,xdata)x(1)*exp(-x(2)*xdata) + x(3)*exp(-x(4)*xdata);
x0 = [1 1 1 0];
[x,resnorm,~,exitflag,output] = lsqcurvefit(F,x0,t,y)
plot(t,F(x,t))
title('Data points')
