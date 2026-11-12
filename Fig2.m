
% global UNAmount BeaconAmount; 
% for i=1:5
% Initial();   
% % noisel=mvnrnd(zeros(3,1), i*eye(3)).';
% noisel=1*ones(3,1);
% noise=i;
% [E1(i,:), LE1(i,:)]=RND(noisel, noise); 
% end
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~Drawing code (Fig2)~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
figure(1) ;     
% x=1:1:UNAmount;
% % plot(x,LE1(1,:),'-', x,LE1(2,:),'--', x,LE1(3,:),'-.', x,LE1(4,:), ':', x,LE1(5,:),'-.')  %  
% % legend('e1', 'e2', 'e3', 'e4', 'e5','location', 'north')  
% % xlabel('k');
% % ylabel('e ');
% plot(x,E1(1,:),'-', x,E1(2,:),'--', x,E1(3,:),'-.', x,E1(4,:), ':', x,E1(5,:),'-.')  %  
% legend('ee1', 'ee2', 'ee3', 'ee4', 'ee5','location', 'north')  % 
% xlabel('k');
% ylabel('ee (m)');

% ax = gca;
% ax.YAxis.Exponent = 4;
% ax.YAxis.TickLabelInterpreter = 'latex';
% ylabel('$$\|\mathbf{\epsilon}_{k}\|_2$$','Interpreter','latex','FontSize',16);
% xlabel('$$k$$','Interpreter','latex','FontSize',16);
% 
% lgd = legend('$$e_1$$','$$e_2$$','$$e_3$$','$$e_4$$','$$e_5$$');
% lgd.Interpreter = 'latex';
% lgd.FontSize = 16;


ylabel('$$\bar{\xi}_k (m)$$','Interpreter','latex','FontSize',16);
% xlabel('$$k$$','Interpreter','latex','FontSize',16);

% lgd = legend('$$\sigma_1$$','$$\sigma_2$$','$$\sigma_3$$','$$\sigma_4$$','$$\sigma_5$$');
% lgd.Interpreter = 'latex';
% lgd.FontSize = 16;



% figure(1)
% x=1:1:UNAmount;
% plot(x, LE1, '-', x, LE2, '--', x, LE3, '-.', x, LE4, ':' , x,LE5,'-.')
% legend('ABND', 'CFS', 'SCFS', 'MWLS', 'JSPCTL','location', 'north') 
% xlabel('k');
% ylabel('\xi (m)');


 
