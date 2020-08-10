
radius = [0, 100, 150, 200, 250, 300, 500, 1000, 2000, 5000];
velo = [1000, 1000, 1000, 1500, 1500, 1500, 1600, 2200, 2800, 3000];
p = polyfit(radius,velo, 3);
x2 = 0:0.1:10000;
y2 = polyval(p,x2);
plot(radius, velo);

hold on
plot(x2, y2);
hold off
xlim([0 5000])
ylim([1000 3500]);

legend("元データ", "近似曲線")
xlabel("曲率半径[mm]")
ylabel("速度[mm/s]")