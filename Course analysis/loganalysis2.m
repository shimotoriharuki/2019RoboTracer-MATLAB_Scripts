%% �p�����[�^����
filename = [ "log266.csv" "log268.csv" "log267.csv" ];    % �ǂݍ��݃t�@�C����

row = [ 2 11 12 13 17 19 6 ];   % �� pattern xg yg zg EncoderTotal logcnt Encoder
pulse = 24.75;	% 1mm�̃p���X
kg = 0.995;     % �␳�W��
direction = 1;  % �������  0:���v��� 1:�����v���

%% �O�Ռv�Z
filesize = size(filename);      % ��r����csv�t�@�C���̌����擾
maxlog = 0;     % �ő��
% ��r����csv�t�@�C���ōő�̍s���𒲂ׂ�
for num2=1:filesize(1,2)
    log = csvread(filename(1,num2),2,0);
    logsize = size(log);
    if maxlog < logsize(1,1)
        maxlog = logsize(1,1);
    end
end

% �v�Z�Ɏg���s��𐶐�
x = zeros(maxlog,filesize(1,2));
y = zeros(maxlog,filesize(1,2));
z = zeros(maxlog,filesize(1,2));
degxy = zeros(maxlog,filesize(1,2));
degz = zeros(maxlog,filesize(1,2));
dl = zeros(maxlog,filesize(1,2));

for num2 = 1:filesize(1,2)
    log = csvread(filename(1,num2),2,0);    % ���O�t�@�C���ǂݍ���
    logsize = size(log);            % �s�񐔎擾
    pattern = log(:,row(1,1));      % �p�^�[���擾
    xg = log(:,row(1,2));           % x���p���x�擾
    yg = log(:,row(1,3));           % y���p���x�擾
    zg = log(:,row(1,4));           % z���p���x�擾
    EncoderTotal = log(:,row(1,5)); % �������擾
    Encoder = log(:,row(1,7));      % ���x�擾
    logcnt = log(:,row(1,6));       % ���Ԏ擾

    % ���O�̎擾�������v�Z
    dt = ( logcnt(2,1) - logcnt(1,1) )/ 1000;

    for time = 2:logsize(1,1)
        % xy���ʊp�x
        degxy(time, num2) = degxy(time-1,num2) + ( -zg(time,1) * dt * kg);

        % pich�p�x
        if pattern(time, 1) > 70 && pattern(time, 1) < 80
            degz(time,num2) = degz(time-1,num2) + ( xg(time,1) * dt );
        else
            degz(time,1) = 0;
        end
        
        % dt��̋���
        dl(time, num2) = ( EncoderTotal(time,1) - EncoderTotal(time-1,1) ) / pulse;

        x(time, num2) = x(time-1,num2) + ( dl(time, num2) * sind( degxy(time, num2) ) );   % x���W�v�Z
        y(time, num2) = y(time-1,num2) + ( dl(time, num2) * cosd( degxy(time, num2) ) );   % y���W�v�Z
        z(time, num2) = z(time-1,num2) + ( dl(time, num2) * tand( degz(time, num2) ) );    % z���W�v�Z

    end
end

%% �O�Օ\��
plot(x,y,'o')
% �͈͎w��
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

legend('Location','eastoutside','FontSize',12)
legend('1���','2���','3���','4���','5���','6���','7���')