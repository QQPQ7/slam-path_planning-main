function [ mean_value ] = sensor_Final( x,y,theta )
temp1 = sensor_part(x,y,theta-pi/9);
temp2 = sensor_part(x,y,theta);
temp3 = sensor_part(x,y,theta+pi/9);
mean_value1 = (temp1+temp2+temp3)/3;
mean_value2 = mean_value1 + (51-floor(rand()*102));
mean_value = [mean_value1 mean_value2];
clear temp1;
clear temp2;
clear temp3;
end

