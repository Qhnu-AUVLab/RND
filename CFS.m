function [E2, LE2]=CFS( ) 
% function [PN2]=CFS( ) 
global BeaconAmount BeaconNoise UNAmount v c t rx;
global sigma_r2 Q_rtu;


% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~stage 1~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Initial( );
for k=1:UNAmount
    h(1,1)=2*v'*BeaconNoise(:,1)-t(1,k)*(norm(v))^2;
    g(:,1)=[2*v' -t(1,k) 0 2]';
    b(1)=c^2-(norm(v))^2;
    q(1)=2*v'*(BeaconNoise(:,1)-BeaconNoise(:,1))-(t(1,k)-t(1,k))*(norm(v))^2;
    for i=2:BeaconAmount
        q(i)=2*v'*(BeaconNoise(:,i)-BeaconNoise(:,1))-(t(i,k)-t(1,k))*(norm(v))^2;
        a(:,i)=[2*((t(i,k)-t(1,k))*v-BeaconNoise(:,i)+BeaconNoise(:,1)); 2*v; -2*v]; 
        h(i,1)=4*(norm(BeaconNoise(:,1)))^2-4*(norm(BeaconNoise(:,i)))^2+2*(t(i,k)-t(1,k))*q(i);
        g(:,i)=[8*(BeaconNoise(:,1)-BeaconNoise(:,i)); -(t(i,k)-t(1,k))^2; -(q(i))^2; -4*(t(i,k)-t(1,k))];
    end
    G1=g';
    phi1(:,1)=inv(G1'*G1)*G1'*h;
    P0(:,k)=phi1(1:3,1)-phi1(6,1)/(phi1(4,1)-(norm(v))^2);
    c=sqrt(phi1(4,1)); 

    d(1:6,1)=[2*(BeaconNoise(:,1)-P0(:,k)-t(1,k)*v)' 2*(v+c*(P0(:,k)-BeaconNoise(:,1))/norm(P0(:,k)-BeaconNoise(:,1)))'];
    d(7:9,1)=zeros(3,1);
    rho=(P0(:,k)-BeaconNoise(:,1))/norm(P0(:,k)-BeaconNoise(:,1));
    for i=2:BeaconAmount
        b(i)=2*(q(i)-q(i)*1/c^2*(norm(v))^2-(t(i,k)-t(1,k))*(norm(v))^2+(t(i,k)-t(1,k))*c^2)+4*(c-(norm(v))^2/c)*norm(P0(:,k)-BeaconNoise(:,1));
        e(:,i)=-4*(c*(t(i,k)-t(1,k))-(norm(v))^2/c*(t(i,k)-t(1,k)-2*(BeaconNoise(:,1)-BeaconNoise(:,i))'*v/c))*rho+8*(BeaconNoise(:,1)-P0(:,k)-norm(P0(:,k)-BeaconNoise(:,1))*v/c);
        f(:,i)=[-8*((t(i,k)-t(1,k))*v+BeaconNoise(:,1)-BeaconNoise(:,i))*1/c*norm(P0(:,k)-BeaconNoise(:,1)); e(:,i); -8*(BeaconNoise(:,i)-P0(:,k)-norm(P0(:,k)-BeaconNoise(:,1))*v/c)];
        d(:,i)=f(:,i)-2*(q(i)*1/c^2+(t(i,k)-t(1,k)))*a(:,i);
    end 
    B1= diag(b);
    D1=d';
    Qtm=sigma_r2*eye(BeaconAmount); 
    Qw=sigma_r2 * eye(9);
    W1=inv(B1*Qtm*B1'+D1*Qw*D1');
    phi1=inv(G1'*W1*G1)*G1'*W1*h;            
    P1(:,k)=phi1(1:3)-phi1(6)/(phi1(4)-(norm(v))^2);
    c1=sqrt(phi1(4)); 
 
   %% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~stage 2~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    SB2=[1 0 0; 0 phi1(4,1) 0; -phi1(6,1)/(phi1(4,1)-(norm(v)))^2 0 1];
    B2=[eye(3) zeros(3); zeros(3) SB2];
    h2=[phi1(1:3,1); phi1(4,1); -1; phi1(6,1)];
    SG2=[0 1; 0 -phi1(5,1); phi1(4,1)-(norm(v))^2 0];
    G2=[eye(3) v zeros(3,1); zeros(3) SG2];
    W2=inv(B2')*(G1'*W1*G1)*inv(B2);
    phi2=inv(G2'*W2*G2)*G2'*W2*h2;           
    P2(:,k)=phi2(1:3,1);
   %% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~stage 3~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    B3=[2*diag(phi2(1:3,1)) zeros(3,2); 2*BeaconNoise(:,1)' 2*phi2(4,1)*phi2(5,1) 0; zeros(1,3) 0 1]; 
    h3=[phi2(1:3,1).*phi2(1:3,1); -(norm(BeaconNoise(:,1)))^2+2*BeaconNoise(:,1)'*phi2(1:3,1); phi2(5,1)];
    G3=[eye(3) zeros(3,1); ones(1,3) -phi2(4,1)^2; zeros(1,3) 1];
    W3=inv(B3')*G2'*inv(B2')*G1'*W1*G1*inv(B2)*G2*inv(B3);
    phi3=inv(G3'*W3*G3)*G3'*W3*h3;           
    P3(:,k)=sqrt(phi3(1:3,1)).*sign(phi2(1:3,1));
    c=sqrt(phi3(4,1));
    
    LE2(k)=norm(G3*phi3-h3);
    E2(k)=norm(P3(:,k)-rx(:,k));
    PN2=P3;
end
end 

