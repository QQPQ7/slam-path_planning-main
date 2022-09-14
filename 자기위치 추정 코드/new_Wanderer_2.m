classdef new_Wanderer_2
    % Vector Field Histogram (VFH) method를 사용해서 로봇을 이동시키는 클래스
    % VFH는 laser 스캔 데이터가 필요
    %
    % Example: 사용방법 예시
    %
    %   % Create subscriber to laser scan topic: '/scan'.
    %   laserSub = rossubscriber('scan');
    %
    %   % Create velocity publisher to issue commands to robot.
    %   [velPub,velMsg] = rospublisher('/vel_cmd','geometry_msgs/Twist');
    %
    %   % Obtain the transform from the robot's base frame to its sensor
    %   % frame.
    %   tftree = rostf;
    %   waitForTransform(tftree,'/base','/sensor');
    %   sensorTransform = getTransform(tftree,'/base','/sensor');
    %
    %   % Construct ExampleHelperAMCLWanderer class
    %   wanderHelper = ExampleHelperAMCLWanderer(laserSub, sensorTransform, velPub, velMsg);
    %
    %   % Issue velocity commands to robot to make it move around without
    %   % hitting obstacles.
    %   for i = 1:100
    %       wander(wanderHelper);
    %       pause(0.01);
    %   end
    %
    %   % Stop the robot
    %   stop(wanderHelper);
    
    
    properties (Access = private)
        % LaserSub - Sensor Interface for laser scan.
        LaserSub
        % VelocityPublisher - Velocity publisher
        VelocityPublisher
        % VelocityMessage - ROS velocity message type
        VelocityMessage
        % Vector Field Histogram object
        VFH
        % Desired moving direction
        TargetDirection = 0
    end
    
    methods
        function obj = new_Wanderer_2(laserSub, velPub, velMsg)
            
            % Initialize sensor interface
            obj.LaserSub = laserSub;
            
            % Initialize control interface
            obj.VelocityPublisher = velPub;
            obj.VelocityMessage = velMsg;
            
            % Initialize VectorFieldHistogram object. The parameters here
            % are tuned to prevent TurtleBot pass doors in the office
            % environment used in AdaptiveMonteCarloLocalizationExample.
            obj.VFH = robotics.VectorFieldHistogram;
            obj.VFH.UseLidarScan = true;
            obj.VFH.DistanceLimits = [0.45 3];
            obj.VFH.RobotRadius = 0.3;
            obj.VFH.MinTurningRadius = 0.3;
            obj.VFH.SafetyDistance = 0.3;
            obj.VFH.HistogramThresholds= [3 10];
        end
        
        function wander(obj)
            % 장애물들을 회피하면 이동하는 함수
            
            % 레이저 스캔 데이터를 로봇에 맞게 변환
            transScan = transformLaserToRobot(obj, obj.LaserSub);
            
            % VFH 알고리즘 실행
            steerDir = step(obj.VFH, transScan, obj.TargetDirection);
            
            if ~isnan(steerDir)
                desiredV = 0.1;
                w = exampleHelperComputeAngularVelocity(steerDir, 0.3);
            else
                desiredV = 0.0;
                w = 0.3;
            end
            
            % velocity 명령을 drive 함수로 전달
            drive(obj, desiredV, w)
        end
        
        function stop(obj)
            % 로봇의 이동을 멈춤
            drive(obj, 0, 0);
        end
    end
    
    methods (Access = private)
        function drive(obj, v, w)
            % linear and angular 속도를 로봇에 명령
            obj.VelocityMessage.Linear.X = v;
            obj.VelocityMessage.Angular.Z = w;
            send(obj.VelocityPublisher, obj.VelocityMessage);
        end
    end
    
    methods (Access = private)
        function transScan = transformLaserToRobot(~, scansub)
            %  transformLaserToRobot Transform laser data to robot base frame
            %  This transform function is only suitable for 2D laser scan
            %  sensor mounted on surface parallel to ground plane.
            
            % 레이저 데이터 수신
            scanMsg = receive(scansub);
            
            scan = lidarScan(scanMsg);
          

            % Transform scan and return
            transScan = transformScan(scan, [-0.0320 0 0.1720]);

            % 기존의 TF TREE를 이용한 부분이었으나 매번 동일한 값을 반환하기에 이는 굳이 매번 계산해줄 필요가 없다고
            % 판단. 따라서 상수값으로 지정하여 TF TREE를 사용하지 않도록 함.
            % transScan = transformScan(scan, [tf.Transform.Translation.X tf.Transform.Translation.Y odomRotation(1)]);
        end
    end
    
end

