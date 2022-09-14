filename = 'SLAM_MAP.mat'; % SLAM을 이용해 그린 지도를 저장한 파일의 이름과 형태

rosinit; % ROS 통신 시작
% rosinit('192.168.17.129',11311)

sub = rossubscriber('/rplidar_ros/scan','sensor_msgs/LaserScan');
% sub = rossubscriber(topicname,msgtype) 형태

%sub = rossubscriber('/rplidar_ros/scan','DataFormat','struct');

pause(1);

slamObj = lidarSLAM(10,12); % mapresolution과 maxlidarRange를 설정, maxlidarRange는 Deepracer의 라이다 성능을 참고해서 12m
slamObj.LoopClosureThreshold = 360;
slamObj.LoopClosureSearchRadius = 8;


% scan한 횟수만큼 계속 결과에 반영하려면 반복문이 돌아야 하는데 그럼 scan한 결과를 저장할 배열이나 리스트가 필요?
% scan 횟수는 어떻게 지정? 

for i = 1:100 % 임의로 100번의 scan을 수행한다고 가정

    scan_data = receive(sub); % subscriber를 이용해서 레이저 데이터를 수신
    scan = lidarScan(scan_data); % 수신된 레이저 데이터를 라이다 데이터 형식으로 변환
    addScan(slamObj,scan); % scan한 결과를 반영

    if rem(i,100) == 0 % 100번째 scan이면 지도를 통해 SLAM 결과를 보여줌
        show(slamObj);
    end

end 

rosshutdown; % ROS 통신 종료


[scans, optimizedPoses]  = scansAndPoses(slamAlg);
currpose = optimizedPoses{end};

map = buildMap(scans, optimizedPoses, mapResolution, maxLidarRange);

save(filename, 'map','currpose') % SLAM을 통해 완성된 지도와 Deepracer의 마지막 위치에 해당하는 poses의 마지막인덱스를 파일에 저장
% 해당 변수들은 추후 Path Planning에서 사용할 예정
% 하지만 SLAM으로 지도를 그리는 것이 종료됨과 동시에 Path Planning이 바로 실행된다는 조건 하에서 poses의 마지막 인덱스가 현재 시점이라고 할 수 있음
% 따라서 추가적으로 SLAM을 통해서 그린 지도에서 현재 자기 위치를 Pose Estimation 할 수 있는 코드가 Path Planning에 있어야 함
