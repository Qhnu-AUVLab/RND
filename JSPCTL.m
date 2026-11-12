function [E5, LE5]=JSPCTL( ) 
% function [PN5]=JSPCTL( ) 
global Beacon BeaconNoise BeaconAmount UNAmount rx c;
global Q_s Q_rts Q_rtu Tnoise; 

%% =====================Initialization parameter=====================
% Initial( );
N = BeaconAmount;                                  % 传感器数量
s_true = Beacon;                                  
%% =====================Monte Carlo cycle=====================
 for k=1:UNAmount
  u_true = rx(:,k); 
  r_ts_true = [];
  for i = 1:N
          for j = 1:N
              if(i~=j)
                  rij = norm(s_true(:,i)-s_true(:,j));
                  r_ts_true = [r_ts_true; rij];
              end
          end
      end
      r_tu_true = zeros(N,1);
      for i=1:N
           r_tu_true(i) = norm(s_true(:,i)-u_true(:,1));
      end
      noise_rts = mvnrnd(zeros(size(r_ts_true,1),1), Q_rts).';
      r_ts_obs = r_ts_true +noise_rts;
      noise_rtu = mvnrnd(zeros(N,1), Q_rtu).'+Tnoise;
      r_tu_obs = r_tu_true + noise_rtu;
  
 %% =================Phase 1: Estimation of sensor position error delta_s_hat using Bayesian Gauss-Markov LMMSE=================
    idx = 1;
    M_ts = size(r_ts_obs,1);
    h_ts = zeros(M_ts,1);
    G_ts = zeros(M_ts,3*N);
    s_noisy_mat=BeaconNoise;
    for i = 1:N
        for j = 1:N
            if(i==j), continue; end
            rij_obs = r_ts_obs(idx);
            h_ts(idx) = rij_obs^2 - (s_noisy_mat(:,i)'*s_noisy_mat(:,i) + s_noisy_mat(:,j)'*s_noisy_mat(:,j) - 2*s_noisy_mat(:,i)'*s_noisy_mat(:,j));
            %G_ts 填充
            row = zeros(1,3*N);
            col_i = (i-1)*3 + (1:3);
            col_j = (j-1)*3 + (1:3);
            row(col_i) = -2*(s_noisy_mat(:,i) - s_noisy_mat(:,j))';
            row(col_j) =  2*(s_noisy_mat(:,i) - s_noisy_mat(:,j))';
            G_ts(idx,:) = row;
            idx = idx+1;
        end
    end
    V_ts = 2*diag(r_ts_obs);
    Q_ets = V_ts * Q_rts * V_ts';
    %公式(31) delta_s_hat
    invQs = inv(Q_s);
    Qets_inv = pinv(Q_ets);
    delta_s_hat = (invQs + G_ts'*Qets_inv*G_ts) \ (G_ts'*Qets_inv * h_ts);
    cov_ds_hat = pinv(invQs + G_ts'*Qets_inv*G_ts); %公式(32)
    s_hat_vec = s_noisy_mat(:) - delta_s_hat;   %公式(33)修正传感器位置
    s_hat_mat = reshape(s_hat_vec, 3, N);
     
 %% =================Phase 2: Step 1 - WLS formula (43) =================
    h1 = zeros(N,1);
    G1 = zeros(N,4);
    for i=1:N
        si_hat = s_hat_mat(:,i);
        h1(i) = r_tu_obs(i)^2 - si_hat'*si_hat;
        G1(i,:) = [-2*si_hat', 1];
    end
    %先W1=单位矩阵得到初值
    W1_eye = eye(N);
    eta1_0 = (G1'*W1_eye*G1)\(G1'*W1_eye*h1);
    u_init = eta1_0(1:3);
    
    %构造W1,公式(41‑42)
    V1 = 2*diag(r_tu_obs);
    O1 = zeros(N,3*N);
    for i=1:N
        O1(i, (i-1)*3+1:i*3 ) = 2*(s_hat_mat(:,i)-u_init)';
    end
    Qe1 = V1*Q_rtu*V1' + O1*cov_ds_hat*O1';
    W1 = pinv(Qe1);
    eta1 = (G1'*W1*G1) \ (G1'*W1*h1);
    cov_eta1 = pinv(G1'*W1*G1);    
%% =================Phase 3: The second step of the WLS refined target position Formula (48 - 49) =================
    eta1_13 = eta1(1:3);
    h2 = [eta1_13(1)^2; eta1_13(2)^2; eta1_13(3)^2; eta1(4)];
    G2 = [1 0 0;0 1 0;0 0 1;1 1 1];
    V2 = diag([2*eta1_13; 1]);
    W2 = V2' * pinv(cov_eta1) * V2;
    eta2 = (G2'*W2*G2) \ (G2'*W2*h2);
    %恢复目标坐标，符号和eta1保持一致
    sign_u = sign(eta1_13);
    u_est(:,k) = sign_u .* sqrt(eta2);
    
     LE5(k)=norm(G2*eta2-h2);
     E5(k)=norm(u_est(:,k)-rx(:,k));
     PN5=u_est;
 end
end
