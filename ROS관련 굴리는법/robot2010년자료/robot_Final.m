function [ Output ] = robot_Final( X,Delta_t )
L = 50; % Wheel distance
Robot_temp = 0:0.1:2*pi+0.1;
Robot_size = 55/2; % Robot radius
Velocity(1) = 100*rand(); % Left velocity
Velocity(2) = 100*rand(); % Right velocity
svalue0 = sensor_Final(X(1)+Robot_size*cos(X(3)-pi*68/180),X(2)+Robot_size*sin(X(3)-pi*68/180),X(3)-pi/2);
svalue1 = sensor_Final(X(1)+Robot_size*cos(X(3)-pi/4),X(2)+Robot_size*sin(X(3)-pi/4),X(3)-pi/4);
svalue2 = sensor_Final(X(1)+Robot_size*cos(X(3)-pi*12/180),X(2)+Robot_size*sin(X(3)-pi*12/180),X(3));
svalue3 = sensor_Final(X(1)+Robot_size*cos(X(3)+pi*12/180),X(2)+Robot_size*sin(X(3)+pi*12/180),X(3));
svalue4 = sensor_Final(X(1)+Robot_size*cos(X(3)+pi/4),X(2)+Robot_size*sin(X(3)+pi/4),X(3)+pi/4);
svalue5 = sensor_Final(X(1)+Robot_size*cos(X(3)+pi*68/180),X(2)+Robot_size*sin(X(3)+pi*68/180),X(3)+pi/2);
svalue6 = sensor_Final(X(1)+Robot_size*cos(X(3)+pi*158/180),X(2)+Robot_size*sin(X(3)+pi*158/180),X(3)+pi);
svalue7 = sensor_Final(X(1)+Robot_size*cos(X(3)-pi*158/180),X(2)+Robot_size*sin(X(3)-pi*158/180),X(3)-pi);

%if(svalue0(2)>0);disp(sprintf('센서0에서의 출력값 : %f',svalue0(2)));end
%if(svalue1(2)>0);disp(sprintf('센서1에서의 출력값 : %f',svalue1(2)));end
%if(svalue2(2)>0);disp(sprintf('센서2에서의 출력값 : %f',svalue2(2)));end
%if(svalue3(2)>0);disp(sprintf('센서3에서의 출력값 : %f',svalue3(2)));end
%if(svalue4(2)>0);disp(sprintf('센서4에서의 출력값 : %f',svalue4(2)));end
%if(svalue5(2)>0);disp(sprintf('센서5에서의 출력값 : %f',svalue5(2)));end
%if(svalue6(2)>0);disp(sprintf('센서6에서의 출력값 : %f',svalue6(2)));end
%if(svalue7(2)>0);disp(sprintf('센서7에서의 출력값 : %f',svalue7(2)));end

if(svalue2(2)>300||svalue3(2)>300)
    if((svalue0(2)+svalue1(2)+svalue2(2)+svalue7(2))>(svalue3(2)+svalue4(2)+svalue5(2)+svalue6(2)))
       Velocity(1) = -50;
       Velocity(2) = 50;
    else
        Velocity(1) = 50;
        Velocity(2) = -50;
    end
elseif(svalue1(2)>700||svalue4(2)>700)
    if(svalue1(2)>svalue4(2))
        Velocity(1) = -50;
        Velocity(2) = 50;
    else
        Velocity(1) = 50;
        Velocity(2) = -50;
    end
end
Robot_drawx = X(1) + Robot_size * cos(Robot_temp);
Robot_drawy = X(2) + Robot_size * sin(Robot_temp);
Omega = (Velocity(2) - Velocity(1))/L;
if(Velocity(1)==Velocity(2))
    X_prime = X+[Velocity(1)*cos(X(3))*Delta_t;Velocity(2)*sin(X(3))*Delta_t;0];
else
    R = (Velocity(2) + Velocity(1))*L/(2*(Velocity(2) - Velocity(1)));
    A = [cos(Omega*Delta_t) -sin(Omega*Delta_t) 0;
        sin(Omega*Delta_t) cos(Omega*Delta_t) 0;
        0 0 1];
    Y = [R*sin(X(3)) ; -R*cos(X(3)) ; X(3)];
    Z = [X(1)-R*sin(X(3)) ; X(2)+R*cos(X(3)) ; Omega*Delta_t];
    X_prime = A*Y+Z;
end
plot(Robot_drawx, Robot_drawy, 'EraseMode', 'normal');
line([X(1) X(1)+Robot_size*cos(X(3))], [X(2) X(2)+Robot_size*sin(X(3))],'EraseMode','none');
trace = [(X(1)+Robot_size*cos(X(3)+pi/2)) (X(1)+Robot_size*cos(X(3)-pi/2)) (X(2)+Robot_size*sin(X(3)+pi/2)) (X(2)+Robot_size*sin(X(3)-pi/2))];
Output = {X_prime,[svalue0(1) svalue1(1) svalue2(1) svalue3(1) svalue4(1) svalue5(1) svalue6(1) svalue7(1)],[svalue0(2) svalue1(2) svalue2(2) svalue3(2) svalue4(2) svalue5(2) svalue6(2) svalue7(2)],trace};
end

%https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=aureagenus&logNo=120101654395
%출처

