function [E3, LE3]=SCFS( ) 
%  function [PN3]=SCFS( ) 
global BeaconAmount BeaconNoise UNAmount v c t rx;
global sigma_r2 Q_rtu;
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~stage 1~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Initial()
for k=1:UNAmount
    for i=1:BeaconAmount
        h(i,1)=t(i,k)*v'*BeaconNoise(:,i)-(norm(BeaconNoise(:,i)))^2;
        g(:,i)=[t(i,k)*v-2*BeaconNoise(:,i); -1/4*t(i,k)^2; 1];
    end
    G1=g';
    phi0=inv(G1'*G1)*G1'*h;
    P0(:,k)=phi0(1:3,1);
    c=sqrt(phi0(4,1));
    for i=1:BeaconAmount
        b(i)=1/2*(t(i,k)*c^2+2*v'*BeaconNoise(:,i)-2*v'*P0(:,k));
        d(:,i)=[t(i,k)*(BeaconNoise(:,i)-P0(:,k)); t(i,k)*v-2*BeaconNoise(:,i)+2*P0(:,k)];
    end
    B1= diag(b);
    Qtm= Q_rtu; 
    D1=d';
    Qw=sigma_r2 * eye(6);
    W1=inv(B1*Qtm*B1'+D1*Qw*D1');
    phi1=inv(G1'*W1*G1)*G1'*W1*h;             
    P1(:,k)=phi1(1:3,1);
    c1=sqrt(phi1(4,1)); 
% 
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~stage 2~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    B2=[2*diag(phi1(1:3,1)) zeros(3,2); zeros(2,3) eye(2)];
    h2=[phi1(1:3,1).*phi1(1:3,1); phi1(4:5,1)];
    G2=[eye(4); ones(1,3) 0];
    W2=inv(B2')*G1'*W1*G1*inv(B2);
    phi2=inv(G2'*W2*G2)*G2'*W2*h2;             
    P2(:,k)=sqrt(phi2(1:3,1)).*sign(phi1(1:3,1));
    c2=sqrt(phi2(4,1));
    
    LE3(k)=norm(G2*phi2-h2);
    E3(k)=norm(P2(:,k)-rx(:,k));
    PN3=P2;
end
end

  







