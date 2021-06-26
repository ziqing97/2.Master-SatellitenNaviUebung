function[] = pltstd(string)
A1 = importfile(string, 25, 25524);
pos = A1{:,8:10};
std_pos = sqrt(pos(:,1).^2 + pos(:,2).^2 + pos(:,3).^2);
figure
plot(std_pos)
pbaspect([3 1 1])

vel = A1{:,19:21};
std_vel= sqrt(vel(:,1).^2 + vel(:,2).^2 + vel(:,3).^2);
figure 
plot(std_vel)
pbaspect([3 1 1])
end