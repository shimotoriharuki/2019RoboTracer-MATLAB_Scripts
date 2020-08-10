%% パラメータ入力
filename = [ "log266.csv" "log268.csv" "log267.csv" ];    % 読み込みファイル名

row = [ 2 11 12 13 17 19 6 ];   % 列数 pattern xg yg zg EncoderTotal logcnt Encoder
pulse = 24.75;	% 1mmのパルス
kg = 0.995;     % 補正係数
direction = 1;  % 周回方向  0:時計回り 1:反時計回り

%% 軌跡計算
filesize = size(filename);      % 比較するcsvファイルの個数を取得
maxlog = 0;     % 最大列数
% 比較するcsvファイルで最大の行数を調べる
for num2=1:filesize(1,2)
    log = csvread(filename(1,num2),2,0);
    logsize = size(log);
    if maxlog < logsize(1,1)
        maxlog = logsize(1,1);
    end
end

% 計算に使う行列を生成
x = zeros(maxlog,filesize(1,2));
y = zeros(maxlog,filesize(1,2));
z = zeros(maxlog,filesize(1,2));
degxy = zeros(maxlog,filesize(1,2));
degz = zeros(maxlog,filesize(1,2));
dl = zeros(maxlog,filesize(1,2));

for num2 = 1:filesize(1,2)
    log = csvread(filename(1,num2),2,0);    % ログファイル読み込み
    logsize = size(log);            % 行列数取得
    pattern = log(:,row(1,1));      % パターン取得
    xg = log(:,row(1,2));           % x軸角速度取得
    yg = log(:,row(1,3));           % y軸角速度取得
    zg = log(:,row(1,4));           % z軸角速度取得
    EncoderTotal = log(:,row(1,5)); % 総距離取得
    Encoder = log(:,row(1,7));      % 速度取得
    logcnt = log(:,row(1,6));       % 時間取得

    % ログの取得周期を計算
    dt = ( logcnt(2,1) - logcnt(1,1) )/ 1000;

    for time = 2:logsize(1,1)
        % xy平面角度
        degxy(time, num2) = degxy(time-1,num2) + ( -zg(time,1) * dt * kg);

        % pich角度
        if pattern(time, 1) > 70 && pattern(time, 1) < 80
            degz(time,num2) = degz(time-1,num2) + ( xg(time,1) * dt );
        else
            degz(time,1) = 0;
        end
        
        % dt後の距離
        dl(time, num2) = ( EncoderTotal(time,1) - EncoderTotal(time-1,1) ) / pulse;

        x(time, num2) = x(time-1,num2) + ( dl(time, num2) * sind( degxy(time, num2) ) );   % x座標計算
        y(time, num2) = y(time-1,num2) + ( dl(time, num2) * cosd( degxy(time, num2) ) );   % y座標計算
        z(time, num2) = z(time-1,num2) + ( dl(time, num2) * tand( degz(time, num2) ) );    % z座標計算

    end
end

%% 軌跡表示
plot(x,y,'o')
% 範囲指定
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
daspect([1 1 1])    % 縦横比を1:1にする

legend('Location','eastoutside','FontSize',12)
legend('1回目','2回目','3回目','4回目','5回目','6回目','7回目')