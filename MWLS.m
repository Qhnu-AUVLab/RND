function [E4, LE4]=MWLS(noisel )
% function [PN4]=MWLS(noisel )
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~初始化参数~~~~~~~~~~~~~~~~~~~~~~~~
global BeaconAmount BeaconNoise UNAmount rx c;
global sigma_r2 Q_rtu Tnoise;
rx(:,1)=rx(:,1);
for k=1:UNAmount
   for j=1:BeaconAmount     
        R(j,1)=sqrt((rx(1,k)-BeaconNoise(1,j))^2+(rx(2,k)-BeaconNoise(2,j))^2+(rx(3,k)-BeaconNoise(3,j))^2);       % The mutual distance between unknown nodes and anchor nodes
   end
   R(:,1)=R(:,1)+mvnrnd(zeros(BeaconAmount,1), Q_rtu).'+Tnoise;
   for j=1:BeaconAmount     
        h(j,1)=R(j,1)^2-BeaconNoise(:,j)'*BeaconNoise(:,j);
        G(j,1:3)=-2*BeaconNoise(:,j)';
        G(j,4)=-1;
   end
   x(:,k)=inv(G'*G)*G'*h;  
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~stage 1~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   V=2*diag(R);
   for j=1:BeaconAmount
       O(j,1:3)=2*(x(1:3,k)-BeaconNoise(:,j));
   end
   Q1=Q_rtu;
   Q2=sigma_r2 * eye(3);
   W=inv(V*Q1*V'+O*Q2*O');
   x1(:,k)=inv(G'*W*G)*G'*W*(h+ones(BeaconAmount,1));

% % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~stage 2~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   D=[-1*ones(BeaconAmount-1,1), eye(BeaconAmount-1)];
   for j=1:BeaconAmount
        R(j,1)=sqrt((x1(1,k)-BeaconNoise(1,j))^2+(x1(2,k)-BeaconNoise(2,j))^2+(x1(3,k)-BeaconNoise(3,j))^2);       
        ht(j,1)=R(j,1)^2-BeaconNoise(:,j)'*BeaconNoise(:,j);
        Gt(j,1:3)=-2*BeaconNoise(:,j)';
   end
   Vt=2*diag(R);
   for j=1:BeaconAmount
       Ot(j,1:3)=2*(x1(1:3,k)-BeaconNoise(:,j));
   end
   h2=D*ht;
   G2=D*Gt;
   V2=D*Vt;
   O2=D*Ot;
   W2=inv(V2*Q1*V2'+O2*Q2*O2');
   x2(:,k)=inv(G2'*W2*G2)*G2'*W2*h2;
   psi1=inv(G2'*W2*G2)*G2'*W2*V2;
   psi2=inv(G2'*W2*G2)*G2'*W2*O2;

% % % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~stage 3~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   for j=1:BeaconAmount
       R(j,1)=sqrt((x2(1,k)-BeaconNoise(1,j))^2+(x2(2,k)-BeaconNoise(2,j))^2+(x2(3,k)-BeaconNoise(3,j))^2);       
       h3(j,1)=R(j,1)^2-BeaconNoise(:,j)'*BeaconNoise(:,j)+2*BeaconNoise(:,j)'*x2(:,k)-x2(:,k)'*x2(:,k);
       G3(j,1:3)=-2*(x2(:,k)-BeaconNoise(:,j))';
   end
   V3=V;
   for j=1:BeaconAmount
       O3(j,1:3)=2*(x2(1:3,k)-BeaconNoise(:,j));
   end
   V4=[V3;psi1];
   O4=[O3;psi2];
   h4=[h3;zeros(3,1)];
   G4=[G3;eye(3)];
   W3=inv(V4*Q1*V4'+O4*Q2*O4');
   dx=-inv(G4'*W3*G4)*G4'*W3*h4;
   x3(:,k)=x2(:,k)-dx;
    clear R
    LE4(k)=norm(G4*dx-h4);
    E4(k)=norm(x(1:3,k)-rx(:,k));
    PN4=x(1:3,:);
end
end 

