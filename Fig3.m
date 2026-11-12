% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~（Fig3a)~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% global Beacon; 
% Initial();
% BorderLength=1000;
% figure(1)
% plot3([960,930,60,960], [60,960,490,60], [940,960,950,940], '-o');   % Triangular deployment of beacon nodes
% hold on
% plot3([950,920,50,950], [50, 950,500,50], [490, 500, 510 490], '-o');
% hold on
% plot3([970, 940, 70,970], [70, 970, 510, 70], [70, 40, 60, 70], '-o');
% hold on
% 
% plot3([900 910 930 920 900],[100 900 930 120 100],[900 910 110 100 900], '-.*');  % Rectangular deployment of beacon nodes
% hold on
% plot3([110 100 120 130 110],[110 910 920 130 110],[920 930 120 130 920], '-.*');
% hold on
% scatter3(Beacon(1,:),Beacon(2,:),Beacon(3,:), 'p');   % Beacon node regular beacon node random deployment
% xlim([0,BorderLength]);
% ylim([0,BorderLength]);
% zlim([0,BorderLength]);
% xlabel('X (m)');
% ylabel('Y (m)');
% zlabel('Z (m)');

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Fig3b and Fig3c~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
global UNAmount; 
Initial();
[E1, LE1]=RND( );
[E2, LE2]=CFS( );
[E3, LE3]=SCFS( );
[E4, LE4]=MWLS( );
[E5, LE5]=JSPCTL( );
figure(1) ;    
x=1:1:UNAmount;
plot(x,E1,'-o', x,E2,'-+', x,E3,'-.', x,E4, '-*', x,E5,'-d')  %  
legend('RND', 'CFS', 'SCFS', 'MWLS', 'JSPCTL','location', 'north')  % 
xlabel('k');
ylabel('ee (m)');

% % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Fig3d  ~~~~~~~~~~~~~~~~~~~~~~~~
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

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Fig3d~~~~~~~~~~~~~~~~~~~~~~~~ The following data was obtained by running the above code.
% y1=[2.8368 2.3548 1.6733 1.4742 1.4043];     
% y2=[4.4842 2.5207 1.823  1.6458 1.8633];
% y3=[3.4161 2.4301 2.0617 1.98   1.8539];
% y4=[4.7117 4.5996 3.6052 3.4666 3.6273];
% y5=[5.0649 4.849  4.1804 3.8843 4.0802];
% x1=[6 7 8 9 10];
% 
% 
% figure(1);
% plot(x1,y1, '-o', 'color', '#ff005e','LineWidth', 1)
% hold on
% plot( x1,y2, '-+', 'color', '#f9ca24 ', 'LineWidth',1)
% hold on
% plot(x1,y3, '-x', 'color', '#1874CD',  'LineWidth', 1)
% hold on
% plot(x1,y4, '-*', 'color', '#00cd66', 'LineWidth', 1)
% hold on
% plot(x1,y5, '-d', 'color', '#1874CD',  'LineWidth', 1)
% hold off
% legend('RND', 'CFS', 'SCFS', 'MWLS','JSPCTL', 'location', 'north');
% xlabel('Number of Beacon nodes');
% ylabel('ee (m)');
