global UNAmount
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  Fig4~~~~~~~~~~~~~~~~~~~~~~~~
%  for i=1:20
%     initialize();
%     [AANDErr, ALSErr]=AFAND( );
%     [ACFSErr]=CFS( );
%     [ASCFSErr]=SCFS( );
%     error(1,i)=AANDErr;
%     error(2,i)=ALSErr;
%     error(3,i)=ACFSErr;
%     error(4,i)=ASCFSErr;
%     i
% end
% AANDerr=mean(error(1,:))
% % maxAND=max(error(1,:))
% % minAND=min(error(1,:))
% LSAerr=mean(error(2,:))
% % maxLS=max(error(2,:))
% % minLS=min(error(2,:))
% CFSAerr=mean(error(3,:))
% % maxCFS=max(error(3,:))
% % minCFS=min(error(3,:))
% SCFSerr=mean(error(4,:))
% % maxSCFS=max(error(4,:))
% % minCFS=min(error(4,:))
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  Fig4a~~~~~~~~~~~~~~~~~~~~~~~~
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

% figure(1); 
% y1=[3.1712 4.5418 6.2725 7.9210 10.2115];      
% y1max=[0.1663 0.8012 1.0690 2.1628 1.8996];
% y1min=[-0.1831 -0.9027 -1.0895 -1.2463 -1.9234];
% y1max=[3.3375 5.3430 7.3415 10.0838 12.1111];
% y1min=[2.9881 3.6391 5.1830 6.6747 8.2881];
% x1=[5 10 15 20 25];
% errorbar(x1, y1, y1min, y1max); % 
% xlabel('Time measuring error');
% ylabel('\xi');

%% The following data was obtained by running the above code.

% y1=[3.5611 3.8256 5.1748 5.1402 6.7472 6.3283];                % Fig4a
% y2=[5.2192 3.301 7.9385 6.8874 14.6273 13.1439];
% y3=[2.1194 2.8501 4.2127 3.0131 4.3921 5.1345];
% y4=[1.4497 2.1758 2.6039 2.9646 3.0839 3.3503];
% y5=[1.8001 2.6046 3.0424 3.3188 3.6388 4.0994];
% x1=[0.5 1 1.5 2 2.5 3];

% y1=[0.3717 1.1723 1.7309 2.1607 2.7853 3.1646];                % Fig4b
% y2=[0.6457 2.5390 6.1175 3.9201 6.9456 7.9343];
% y3=[1.8727 4.3137 6.4175 11.3614 12.6510 13.1352];
% y4=[3.8560 7.8427 12.3440 18.4478 22.9553 27.0302];
% y5=[4.113  9.2682 13.2407 19.5742 23.8253 31.9746];
% x1=[5 10 15 20 25 30];

% y1=[2.5092 4.5454 5.6388  7.1117 8.2841 8.4968];                % Fig4c
% y2=[6.706  8.6466 22.0447 23.033 13.959 16.8773];
% y3=[2.9028 6.3847 6.0586  9.8461 14.5703 13.4455];
% y4=[4.1375 12.1721 18.3062 19.3679 23.726 28.2063];
% y5=[5.0191 13.0878 19.518  21.2953 26.5811 32.2372];
% x1=[1 2 3 4 5 6];

% figure(1);
% plot(x1,y1, '-o', 'color', '#ff005e','LineWidth', 2)
% hold on
% plot( x1,y2, '-+', 'color', '#f9ca24 ', 'LineWidth',2)
% hold on
% plot(x1,y3, '-x', 'color', '#1874CD',  'LineWidth', 2)
% hold on
% plot(x1,y4, '-*', 'color', '#00cd66', 'LineWidth', 2)
% hold on
% plot(x1,y5, '-d', 'color', '#1874CD',  'LineWidth', 2)
% hold off
% legend('RND', 'CFS', 'SCFS', 'MWLS','JSPCTL', 'location', 'north');
% % xlabel('Variance of ranging error‌');
% % xlabel('Time delay‌');
% xlabel('Measuring error')
% % ylabel('ee (m)');


% %~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Fig4d~~~~~~~~~~~~~~~~~~~~~~~~
Initial();
[E1, LE1]=RND( );
[E2, LE2]=CFS( );
[E3, LE3]=SCFS( );
[E4, LE4]=MWLS( );
[E5, LE5]=JSPCTL( );
figure(1)
for i=1:UNAmount
    x(i,1)=E1(i);
    x(i,2)=E2(i);
    x(i,3)=E3(i);
    x(i,4)=E4(i);
    x(i,5)=E5(i);
end
boxplot(x,'Labels',{'RND' 'CFS' 'SCFS' 'MWLS' 'JSPCTL'},'Notch','off','colors','kkkk','Whisker',1,'width',0.5); 
ylabel('Error (m)');
colors = [0.3922 0.5843 0.9294; 0.4863 0.8039 0.4863; 1.0000 0.8431 0; 0.8039 0.5176 0.9451; 1.0000 0.2510 0.2510 ];  %Data was obtained by running the above code.
h = findobj(gca,'Tag','Box');
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),colors(j,:),'FaceAlpha',.5);
end



