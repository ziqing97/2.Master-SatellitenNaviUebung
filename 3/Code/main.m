close all
% import
% BaseAlloy1Hz = importfile('Base_Alloy_1Hz.pos', 19, 1040);
% BaseAlloy1Hzonline = importfile1('Base_Alloy_1Hz_online.pos', 7, 43);
% 
% %% A3 Vergleich
% t =  BaseAlloy1Hz{2:end,2};
% t = datetime(t,'InputFormat','HH:mm:ss.SSS');
% t = datenum(t);
% pos_1 = BaseAlloy1Hz{2:end,3:5};
% 
% t1 =  BaseAlloy1Hzonline{:,6};
% t1 = datetime(t1,'InputFormat','HH:mm:ss.SSS');
% t1 = datenum(t1);
% lat = BaseAlloy1Hzonline{:,17:19};
% lat_2 = lat(:,1) + lat(:,2)/60 + lat(:,3)/3600;
% lon = BaseAlloy1Hzonline{:,20:22};
% lon_2 = lon(:,1) + lon(:,2)/60 + lon(:,3)/3600;
% h2 = BaseAlloy1Hzonline{:,23};
% pos_2 = [lat_2, lon_2, h2];
% 
% figure
% subplot(3,1,1)
% scatter(t,pos_1(:,1))
% hold on
% scatter(t1,lat_2)
% title('Breite')
% legend('rtklib','CSRS')
% set(gca,'fontsize',20)
% datetick('x')
% 
% subplot(3,1,2)
% scatter(t,pos_1(:,2))
% hold on
% scatter(t1,lon_2)
% title('Länge')
% legend('rtklib','CSRS')
% set(gca,'fontsize',20)
% datetick('x')
% 
% 
% subplot(3,1,3)
% scatter(t,pos_1(:,3))
% hold on
% scatter(t1,h2)
% title('Höhe')
% legend('rtklib','CSRS')
% set(gca,'fontsize',20)
% datetick('x')

% 
% %% std A1
% std_all = BaseAlloy1Hz{2:end,8:10};
% 
% 
% std = sqrt(std_all(:,1).^2 + std_all(:,2).^2 + std_all(:,3).^2);
% figure
% plot(t,std,'Linewidth',3)
% datetick('x')
% xlabel('time')
% ylabel('Standardabweichung [m]')
% set(gca,'fontsize',20)
% pbaspect([3 1 1]);


%% Flug
BaseAlloy1Hz = importfile('Icare_NetR9_1Hz.pos', 19, 1040);
BaseAlloy1Hzonline = importfile2('Icare_NetR9_1Hzonline.pos', 7, 1027);
std_all = BaseAlloy1Hz{2:end,8:10};
t =  BaseAlloy1Hz{2:end,2};
t = datetime(t,'InputFormat','HH:mm:ss.SSS');
t = datenum(t);

t =  BaseAlloy1Hz{2:end,2};
t = datetime(t,'InputFormat','HH:mm:ss.SSS');
t = datenum(t);
pos_1 = BaseAlloy1Hz{2:end,3:5};

t1 =  BaseAlloy1Hzonline{:,6};
t1 = datetime(t1,'InputFormat','HH:mm:ss.SSS');
t1 = datenum(t1);
lat = BaseAlloy1Hzonline{:,17:19};
lat_2 = lat(:,1) + lat(:,2)/60 + lat(:,3)/3600;
lon = BaseAlloy1Hzonline{:,20:22};
lon_2 = lon(:,1) + lon(:,2)/60 + lon(:,3)/3600;
h2 = BaseAlloy1Hzonline{:,23};
pos_2 = [lat_2, lon_2, h2];

figure
subplot(3,1,1)
scatter(t,pos_1(:,1))
hold on
scatter(t1,lat_2)
title('Breite')
legend('rtklib','CSRS')
set(gca,'fontsize',20)
datetick('x')

subplot(3,1,2)
scatter(t,pos_1(:,2))
hold on
scatter(t1,lon_2)
title('Länge')
legend('rtklib','CSRS')
set(gca,'fontsize',20)
datetick('x')


subplot(3,1,3)
scatter(t,pos_1(:,3))
hold on
scatter(t1,h2)
title('Höhe')
legend('rtklib','CSRS')
set(gca,'fontsize',20)
datetick('x')


std = sqrt(std_all(:,1).^2 + std_all(:,2).^2 + std_all(:,3).^2);
figure
plot(t,std,'Linewidth',3)
datetick('x')
xlabel('time')
ylabel('Standardabweichung [m]')
set(gca,'fontsize',20)
pbaspect([3 1 1]);

figure
pos_diff = pos_1-pos_2;
subplot(3,1,1)
plot(t,pos_diff(:,1)*6378137/180*pi)
title('diff Breite')
set(gca,'fontsize',20)
datetick('x')
xlabel('x')
ylabel('m')

subplot(3,1,2)
plot(t,pos_diff(:,2)*6378137/180*pi)
title('diff Länge')
set(gca,'fontsize',20)
datetick('x')
xlabel('time')
ylabel('m')

subplot(3,1,3)
plot(t,pos_diff(:,3))
title('diff Höhe')
set(gca,'fontsize',20)
datetick('x')
xlabel('time')
ylabel('m')