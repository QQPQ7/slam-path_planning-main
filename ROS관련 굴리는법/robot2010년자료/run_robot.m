clear all;
close all;
clc;
obs1x = [200 200 500 500];
obs1y = [500 700 700 500];
obs2x = [700 700 800 800];
obs2y = [600 900 900 600];
obstemp = 0:0.1:2*pi+0.1;
obscirx = 700 + 150*cos(obstemp);
obsciry = 250 + 150*sin(obstemp);


X = [200 ; 200 ; pi/2]; % Initial position and direction
Delta_t = 0.1;
fig = figure('position',[100 100 1024 768]);;
h0=subplot(2,3,[1 2 4 5], 'replace');
h1=subplot(2,3,3, 'replace');
h2=subplot(2,3,6, 'replace');
endtime = 1000;
sval_wo_n = zeros(length(0:Delta_t:endtime),1);
sval_w_n = zeros(length(0:Delta_t:endtime),1);
robot_trace = zeros(length(0:Delta_t:endtime),4);
for i = 0:Delta_t:endtime
    subplot(h0);
    fill(obscirx, obsciry, 'r'); 
    hold on;
    plot(200,200,'d');
    text(200,220,'Start');
    fill(obs1x, obs1y, 'g');
    fill(obs2x, obs2y, 'b');
    temp=robot_Final(X,Delta_t);
    X=temp{1};
    axis([0 1000 0 1000]);
    sval_wo_n(find(0:Delta_t:endtime==i,1)) = sum(temp{2})/length(temp{2});
    sval_w_n(find(0:Delta_t:endtime==i,1)) = sum(temp{3})/length(temp{3});
    robot_trace(find(0:Delta_t:endtime==i,1),:) = temp{4};
    plot(robot_trace(1:find(0:Delta_t:endtime==i,1),1),robot_trace(1:find(0:Delta_t:endtime==i,1),3),'-.r');
    plot(robot_trace(1:find(0:Delta_t:endtime==i,1),2),robot_trace(1:find(0:Delta_t:endtime==i,1),4),'-.r');
    hold off;
    subplot(h1);
    if(mod(find(0:Delta_t:endtime==i,1),30)==1)
        plot(1:find(0:Delta_t:endtime==i,1), sval_wo_n(1:find(0:Delta_t:endtime==i,1)));
        title('Average of S value w/o Noise');
        axis([find(0:Delta_t:endtime==i,1)-100 find(0:Delta_t:endtime==i,1) -5 500]);
    end
    subplot(h2);
    if(mod(find(0:Delta_t:endtime==i,1),30)==1)
        plot(1:find(0:Delta_t:endtime==i,1), sval_w_n(1:find(0:Delta_t:endtime==i,1)));
        title('Average of S value w Noise');
        axis([find(0:Delta_t:endtime==i,1)-100 find(0:Delta_t:endtime==i,1) -5 500]);
    end
    pause(Delta_t/10);
end 