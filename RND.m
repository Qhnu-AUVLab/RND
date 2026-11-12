function [E1, LE1]=RND() 
% function [PN1]=RND() 
global BeaconAmount  BeaconNoise  UNAmount v t rx;
global sigma_r2 Q_rtu;
for k=1:UNAmount
    for i=1:BeaconAmount
        g(i,k)=norm(BeaconNoise(:,i))^2-t(i,k)*v'*BeaconNoise(:,i);
        Psi(i,1:3,k)=2*BeaconNoise(:,i)'-t(i,k)*v';
        Psi(i,4,k)=-1;
        Psi(i,5,k)=1/4*t(i,k)^2;
    end
    phi(:,k)=inv(Psi(:,:,k)'*Psi(:,:,k))*Psi(:,:,k)'*g(:,k);
    phi(1:3,k)=phi(1:3,k);
    c=sqrt(phi(5,k));
    for i=1:BeaconAmount
        a(i)=1/2*t(i,k)*c^2-v'*phi(1:3,k)+v'*BeaconNoise(:,i);
        b(:,i)=(t(i,k)*BeaconNoise(:,i)-t(i,k)*phi(1:3,k));
    end
    A= diag(a);
    Qt=Q_rtu;
    B=b';
    Qw=sigma_r2 * eye(3);
    W=inv(A*Qt*A'+B*Qw*B');
    LE1(k)=norm(g(:,k)-Psi(:,:,k)*phi(:,k));
    E1(k)=norm(rx(:,k)-phi(1:3,k));
end
for k=2:UNAmount
    for i=1:BeaconAmount
        g(i,k)=norm(BeaconNoise(:,i))^2-t(i,k)*v'*BeaconNoise(:,i);
        Psi(i,1:3,k)=2*BeaconNoise(:,i)'-t(i,k)*v';
        Psi(i,4,k)=-1;
        Psi(i,5,k)=1/4*t(i,k)^2;
    end
        c=sqrt(phi(5,k));
     for i=1:BeaconAmount
        a(i)=1/2*t(i,k)*c^2-v'*phi(1:3,k)+v'*BeaconNoise(:,i);
        b(:,i)=(t(i,k)*BeaconNoise(:,i)-t(i,k)*phi(1:3,k));
     end
         A= diag(a);
         Qt=Q_rtu;
         B=b';
         Qw=sigma_r2 * eye(3);
         W=inv(A*Qt*A'+B*Qw*B');
         phi(:,k+1)=phi(:,k)+inv(Psi(:,:,k)'*W*Psi(:,:,k))*Psi(:,:,k)'*W*(g(:,k)-g(:,k-1)-(Psi(:,:,k)-Psi(:,:,k-1))*phi(:,k)+0.1*AF(g(:,k)-Psi(:,:,k)*phi(:,k)));
         LE1(k)=norm(g(:,k)-Psi(:,:,k)*phi(:,k));
         E1(k)=norm(rx(:,k)-phi(1:3,k));
         PN1=phi(1:3,:);
    end
end