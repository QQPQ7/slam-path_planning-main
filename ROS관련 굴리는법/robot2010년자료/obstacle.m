function [ tf ] = obstacle( x,y )
tf = 0;
if(x<0||x>1000||y<0||y>1000) % Border Line
    tf = 1;
end
if(x>200&&x<500&&y>500&&y<700)
    tf = 1;
end
if(x>700&&x<800&&y>600&&y<900)
    tf = 1;
end
if((x-700)^2+(y-250)^2<150^2)
    tf = 1;
end