% clear, close all;
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  Fig5a~~~~~~~~~~~~~~~~~~~~~~~~
% Initial();
% [PN1]=RND( );
% [PN2]=CFS( );
% [PN3]=SCFS( );
% [PN4]=MWLS( );
% [PN5]=JSPCTL( ); 
%  v=[1.5; 1.4; 0];
%  UN(:,1)=[300; 350; 520];
% for k=1:1:60
%   UN(:,k+1)=UN(:,k)+3*v;
% end
% figure(1)
% % plot3(UN(1,:),UN(2,:),UN(3,:),'-')
% plot3(UN(1,:),UN(2,:),UN(3,:),'-', PN1(1,:), PN1(2,:), PN1(3,:),'-o', PN2(1,:), PN2(2,:), PN2(3,:),'-+', PN3(1,:), PN3(2,:), PN3(3,:),'-x', PN4(1,:), PN4(2,:), PN4(3,:),'-*',PN5(1,:), PN5(2,:), PN5(3,:),'-d')
% legend('AL','RND', 'CFS', 'SCFS', 'MWLS','JSPCTL', 'location', 'north');
% xlabel('X (m)');
% ylabel('Y (m)');
% zlabel('Z (m)');
% grid on

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Fig5b 和 Fig5d~~~~~~~~~~~~~~~~~~~~~~~~
% for i=1:20
%     Initial();
%     [E1, LE1]=RND( );
%     [E2, LE2]=CFS( );
%     [E3, LE3]=SCFS( );
%     [E4, LE4]=MWLS( );
%     [E5, LE5]=JSPCTL( );
%     error(1,i)=mean(E1);
%     error(2,i)=mean(E2);
%     error(3,i)=mean(E3);
%     error(4,i)=mean(E4);
%     error(5,i)=mean(E5);
%     i
% end
% RNDerr=mean(error(1,:))
% CFSerr=mean(error(2,:))
% SCFSAerr=mean(error(3,:))
% MWLSerr=mean(error(4,:))
% JSPCTLerr=mean(error(5,:))
%% The following data was obtained by running the above code.
% X=[1.6576 1.939 1.8129 2.817 3.2536; 2.4103 3.2099 3.5243 7.1814 7.966; 3.387 4.2844 6.3378 12.3077 14.9711; 4.0942 6.067 8.7961 19.383 24.0167]; 
X=[4.7946 7.2532 3.8768 5.4461 5.9732; 8.0601 9.3023 9.5993 11.4535 12.5747; 10.7107 17.8742 16.7704 21.6952 22.9405; 18.6881 27.754 31.3207 32.4449 34.2688]; 
figure(1)
bar(X);
ylabel('e');
legend('RND', 'CFS', 'SCFS', 'MWLS','JSPCTL', 'location', 'north')

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Fig5c~~~~~~~~~~~~~~~~~~~~~~~~
%  Initial();
% [PN1]=RND( );
% [PN2]=CFS( );
% [PN3]=SCFS( );
% [PN4]=MWLS( );
% [PN5]=JSPCTL( ); 
% z=0;
%  for k=1:65
%      UN(1,k)=50*sin(z)+500;
%      UN(2,k)=50*cos(z)+500;
%      UN(3,k)=80*z;
%      z=z+0.1;
%  end
% figure(1)
% plot3(UN(1,:),UN(2,:),UN(3,:),'-', PN1(1,:), PN1(2,:), PN1(3,:),'-o', PN2(1,:), PN2(2,:), PN2(3,:),'-+', PN3(1,:), PN3(2,:), PN3(3,:),'-x', PN4(1,:), PN4(2,:), PN4(3,:),'-*',PN5(1,:), PN5(2,:), PN5(3,:),'-d')
% xlabel('X (m)');
% ylabel('Y (m)');
% zlabel('Z (m)');
% % plot3(UN(1,:),UN(2,:),UN(3,:))
% legend('AL','RND', 'CFS', 'SCFS', 'MWLS','JSPCTL', 'location', 'north')
% grid on
% 

%