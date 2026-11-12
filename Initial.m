function Initial( )
clear, close all;
global Beacon BeaconAmount BeaconNoise UNAmount v c t rx; 
global sigma_r2 Q_s Q_rts Q_rtu Tnoise;
BorderLength=1000;
BeaconAmount=6;
UNAmount=65;
% Beacon=[962 933 61 954 42 56 977 948 72; 67 962 494 508 953 55 76 972 516; 942 967 956 492 503 519 76 42 65]; 
%  Beacon=[60 930 960 50 910 950 70 940 970;490 960 60 500 900 50 510 970 70; 950 960 940 510 910 490 60 40 70];  %信标节点三角形分布
% Beacon=[105 120 135 150 930 950 910 940 ; 950 150 900 230 920 120 935 110; 930 870 120 140 950 900 150 100];
Beacon=BorderLength.*rand(3,BeaconAmount); %
v=[1.5; 1.4; 0];
c=1500;
rx(:,1)=[300; 350; 520];
sigma_r2 = 3;                            % Distance noise variance sigma_r^2
sigma_s2_ratio = 2;                        % sigma_s^2/sigma_r^2, 
sigma_s2 = sigma_s2_ratio * sigma_r2;        
Q_s = sigma_s2 * eye(3*BeaconAmount);          % Sensor position error covariance
Q_rts = sigma_r2 * eye(BeaconAmount*(BeaconAmount-1));    % Covariance of ranging noise between sensors
Q_rtu = sigma_r2 * eye(BeaconAmount);          %Sensor-target range measurement noise covariance
Tnoise=0.03*c*ones(BeaconAmount,1);
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 模拟测量数据 ~~~~~~~~~~~~~~~~~~~~~~~~
t=zeros(BeaconAmount,UNAmount);
z=0;
for k=1:UNAmount
%     rx(:,k+1)=rx(:,k)+v*3;
    rx(1,k)=50*sin(z)+500;
    rx(2,k)=50*cos(z)+500;
    rx(3,k)=80*z;
    z=z+0.1;
    Delta_s = mvnrnd(zeros(3*BeaconAmount,1), Q_s).'; 
    Delta_s_mat=reshape(Delta_s,3,BeaconAmount);
    BeaconNoise=Beacon+Delta_s_mat;
   for i=1:BeaconAmount
       D0(i,1)=norm(rx(:,k)-Beacon(:,i));
       t0(i,1)=D0(i,1)/c;
       xr(:,k)=rx(:,k)+v*2*t0(i,1);
       Dr(i,1)=norm(xr(:,k)-Beacon(:,i));
   end 
   D(:,1)=D0(:,1)+Dr(:,1);
   D_noise(:,1)=D(:,1)+mvnrnd(zeros(BeaconAmount,1), Q_rtu).';
   t(:,k)=D_noise(:,1)/c+0.03;             %   时延误差。
end
end                        




