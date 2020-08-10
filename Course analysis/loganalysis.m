%% ƒpƒ‰ƒ[ƒ^“ü—Í
filename = 'log266.csv';    % “Ç‚İ‚İƒtƒ@ƒCƒ‹–¼

row = [ 2 11 12 13 17 19 6 ];       % —ñ” pattern xg yg zg EncoderTotal logcnt Encoder
p = [ 11 19;            % •\¦‚·‚éƒpƒ^[ƒ“”Ô†
       21 29;
       31 39;
       41 49;
       51 59;
       61 69;
       71 79;
       101 109];
 v = [ 0 1;             % •\¦‚·‚é‘¬“x[m/s]
      1.1 2;
      2.1 3;
      3.1 3.2;
      3.3 3.4;
      3.5 3.6;
      3.7 4.5];
pulse = 24.75;	% 1mm‚Ìƒpƒ‹ƒX
step = 20;      % ƒvƒƒbƒg‚ÌŠÔŠu 
kg = 0.996;     % •â³ŒW”
direction = 1;  % ü‰ñ•ûŒü  0:Œv‰ñ‚è 1:”½Œv‰ñ‚è

%% ‹OÕŒvZ
log = csvread(filename,2,0);    % ƒƒOƒtƒ@ƒCƒ‹“Ç‚İ‚İ
logsize = size(log);            % s—ñ”æ“¾
pattern = log(:,row(1,1));      % ƒpƒ^[ƒ“æ“¾
xg = log(:,row(1,2));           % x²Šp‘¬“xæ“¾
yg = log(:,row(1,3));           % y²Šp‘¬“xæ“¾
zg = log(:,row(1,4));           % z²Šp‘¬“xæ“¾
EncoderTotal = log(:,row(1,5)); % ‘‹——£æ“¾
Encoder = log(:,row(1,7));      % ‘¬“xæ“¾
logcnt = log(:,row(1,6));       % ŠÔæ“¾

% ŒvZ‚Ég‚¤s—ñ‚ğ¶¬
t = 0:logsize-1;
degxy = zeros(logsize(1,1),1);
degz = zeros(logsize(1,1),1);
dl = zeros(logsize(1,1),1);
velocity = zeros(logsize(1,1),1);
x = zeros(logsize(1,1),1);
y = zeros(logsize(1,1),1);
z = zeros(logsize(1,1),1);
% ƒpƒ^[ƒ“•Ês—ñ
xp = zeros(logsize(1,1),10);
yp = zeros(logsize(1,1),10);
xv = zeros(logsize(1,1),10);
yv = zeros(logsize(1,1),10);

% ƒƒO‚Ìæ“¾üŠú‚ğŒvZ
dt = ( logcnt(2,1) - logcnt(1,1) )/ 1000;

for time = 2:logsize(1,1)
    % xy•½–ÊŠp“x
    degxy(time, 1) = degxy(time-1,1) + ( -zg(time,1) * dt * kg);

    % pichŠp“x
    if pattern(time, 1) > 70 && pattern(time, 1) < 80
        degz(time,1) = degz(time-1,1) + ( xg(time,1) * dt );
    else
        degz(time,1) = 0;
    end
    % ‘¬“x‚ğŒvZ
    velocity(time, 1) = Encoder(time,1) / pulse;
    % dtŒã‚Ì‹——£
    dl(time, 1) = ( EncoderTotal(time,1) - EncoderTotal(time-1,1) ) / pulse;

    x(time, 1) = x(time-1,1) + ( dl(time, 1) * sind( degxy(time, 1) ) );   % xÀ•WŒvZ
    y(time, 1) = y(time-1,1) + ( dl(time, 1) * cosd( degxy(time, 1) ) );   % yÀ•WŒvZ
    z(time, 1) = z(time-1,1) + ( dl(time, 1) * tand( degz(time, 1) ) );    % zÀ•WŒvZ

    if rem(time,step) == 0
        for num = 1:7
            if pattern(time, 1) >= p(num,1) && pattern(time, 1) <= p(num,2)
                xp(time, num) = x(time,1);   % xÀ•WŒvZ
                yp(time, num) = y(time,1);   % yÀ•WŒvZ
            end

            if velocity(time, 1) > v(num,1)-0.1 && velocity(time, 1) <= v(num,2)
                xv(time, num) = x(time,1);   % xÀ•WŒvZ
                yv(time, num) = y(time,1);   % yÀ•WŒvZ
            end
        end
    end
end

%% ‹OÕ•\¦
% ƒpƒ^[ƒ“‚²‚Æ‚Éƒvƒƒbƒg
subplot(1,2,1);
plot(xp,yp,'o')
if direction == 1
    xlim([-7000 1000])
    xticks(-7000:1000:1000)
    ylim([-6000 6000])
    yticks(-6000:1000:6000)
else
    xlim([-1000 7000])
    xticks(-1000:1000:7000)
    ylim([-6000 6000])
    yticks(-6000:1000:6000)
end
grid on
daspect([1 1 1])    % c‰¡”ä‚ğ1:1‚É‚·‚é
% –}—á
legend('Location','eastoutside','FontSize',12)
legend(['pattern',num2str(p(1,1)),'`',num2str(p(1,2)),],['pattern',num2str(p(2,1)),'`',num2str(p(2,2)),],['pattern',num2str(p(3,1)),'`',num2str(p(3,2)),],['pattern',num2str(p(4,1)),'`',num2str(p(4,2)),],['pattern',num2str(p(5,1)),'`',num2str(p(5,2)),],['pattern',num2str(p(6,1)),'`',num2str(p(6,2)),],['pattern',num2str(p(7,1)),'`',num2str(p(7,2)),])


% ‘¬“x‚²‚Æ‚Éƒvƒƒbƒg
subplot(1,2,2);
plot(xv,yv,'o')
if direction == 1
    xlim([-7000 1000])
    xticks(-7000:1000:1000)
    ylim([-6000 6000])
    yticks(-6000:1000:6000)
else
    xlim([-1000 7000])
    xticks(-1000:1000:7000)
    ylim([-6000 6000])
    yticks(-6000:1000:6000)
end
grid on
daspect([1 1 1])    % c‰¡”ä‚ğ1:1‚É‚·‚é
% –}—á
legend('Location','eastoutside','FontSize',12)
legend([num2str(v(1,1)),'`',num2str(v(1,2)),'m/s'],[num2str(v(2,1)),'`',num2str(v(2,2)),'m/s'],[num2str(v(3,1)),'`',num2str(v(3,2)),'m/s'],[num2str(v(4,1)),'`',num2str(v(4,2)),'m/s'],[num2str(v(5,1)),'`',num2str(v(5,2)),'m/s'],[num2str(v(6,1)),'`',num2str(v(6,2)),'m/s'],[num2str(v(7,1)),'`',num2str(v(7,2)),'m/s'])
