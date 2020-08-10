%% �p�����[�^����
filename = 'log266.csv';    % �ǂݍ��݃t�@�C����

row = [ 2 11 12 13 17 19 6 ];       % �� pattern xg yg zg EncoderTotal logcnt Encoder
p = [ 11 19;            % �\������p�^�[���ԍ�
       21 29;
       31 39;
       41 49;
       51 59;
       61 69;
       71 79;
       101 109];
 v = [ 0 1;             % �\�����鑬�x[m/s]
      1.1 2;
      2.1 3;
      3.1 3.2;
      3.3 3.4;
      3.5 3.6;
      3.7 4.5];
pulse = 24.75;	% 1mm�̃p���X
step = 20;      % �v���b�g�̊Ԋu 
kg = 0.996;     % �␳�W��
direction = 1;  % �������  0:���v��� 1:�����v���

%% �O�Ռv�Z
log = csvread(filename,2,0);    % ���O�t�@�C���ǂݍ���
logsize = size(log);            % �s�񐔎擾
pattern = log(:,row(1,1));      % �p�^�[���擾
xg = log(:,row(1,2));           % x���p���x�擾
yg = log(:,row(1,3));           % y���p���x�擾
zg = log(:,row(1,4));           % z���p���x�擾
EncoderTotal = log(:,row(1,5)); % �������擾
Encoder = log(:,row(1,7));      % ���x�擾
logcnt = log(:,row(1,6));       % ���Ԏ擾

% �v�Z�Ɏg���s��𐶐�
t = 0:logsize-1;
degxy = zeros(logsize(1,1),1);
degz = zeros(logsize(1,1),1);
dl = zeros(logsize(1,1),1);
velocity = zeros(logsize(1,1),1);
x = zeros(logsize(1,1),1);
y = zeros(logsize(1,1),1);
z = zeros(logsize(1,1),1);
% �p�^�[���ʍs��
xp = zeros(logsize(1,1),10);
yp = zeros(logsize(1,1),10);
xv = zeros(logsize(1,1),10);
yv = zeros(logsize(1,1),10);

% ���O�̎擾�������v�Z
dt = ( logcnt(2,1) - logcnt(1,1) )/ 1000;

for time = 2:logsize(1,1)
    % xy���ʊp�x
    degxy(time, 1) = degxy(time-1,1) + ( -zg(time,1) * dt * kg);

    % pich�p�x
    if pattern(time, 1) > 70 && pattern(time, 1) < 80
        degz(time,1) = degz(time-1,1) + ( xg(time,1) * dt );
    else
        degz(time,1) = 0;
    end
    % ���x���v�Z
    velocity(time, 1) = Encoder(time,1) / pulse;
    % dt��̋���
    dl(time, 1) = ( EncoderTotal(time,1) - EncoderTotal(time-1,1) ) / pulse;

    x(time, 1) = x(time-1,1) + ( dl(time, 1) * sind( degxy(time, 1) ) );   % x���W�v�Z
    y(time, 1) = y(time-1,1) + ( dl(time, 1) * cosd( degxy(time, 1) ) );   % y���W�v�Z
    z(time, 1) = z(time-1,1) + ( dl(time, 1) * tand( degz(time, 1) ) );    % z���W�v�Z

    if rem(time,step) == 0
        for num = 1:7
            if pattern(time, 1) >= p(num,1) && pattern(time, 1) <= p(num,2)
                xp(time, num) = x(time,1);   % x���W�v�Z
                yp(time, num) = y(time,1);   % y���W�v�Z
            end

            if velocity(time, 1) > v(num,1)-0.1 && velocity(time, 1) <= v(num,2)
                xv(time, num) = x(time,1);   % x���W�v�Z
                yv(time, num) = y(time,1);   % y���W�v�Z
            end
        end
    end
end

%% �O�Օ\��
% �p�^�[�����ƂɃv���b�g
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
daspect([1 1 1])    % �c�����1:1�ɂ���
% �}��
legend('Location','eastoutside','FontSize',12)
legend(['pattern',num2str(p(1,1)),'�`',num2str(p(1,2)),],['pattern',num2str(p(2,1)),'�`',num2str(p(2,2)),],['pattern',num2str(p(3,1)),'�`',num2str(p(3,2)),],['pattern',num2str(p(4,1)),'�`',num2str(p(4,2)),],['pattern',num2str(p(5,1)),'�`',num2str(p(5,2)),],['pattern',num2str(p(6,1)),'�`',num2str(p(6,2)),],['pattern',num2str(p(7,1)),'�`',num2str(p(7,2)),])


% ���x���ƂɃv���b�g
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
daspect([1 1 1])    % �c�����1:1�ɂ���
% �}��
legend('Location','eastoutside','FontSize',12)
legend([num2str(v(1,1)),'�`',num2str(v(1,2)),'m/s'],[num2str(v(2,1)),'�`',num2str(v(2,2)),'m/s'],[num2str(v(3,1)),'�`',num2str(v(3,2)),'m/s'],[num2str(v(4,1)),'�`',num2str(v(4,2)),'m/s'],[num2str(v(5,1)),'�`',num2str(v(5,2)),'m/s'],[num2str(v(6,1)),'�`',num2str(v(6,2)),'m/s'],[num2str(v(7,1)),'�`',num2str(v(7,2)),'m/s'])
