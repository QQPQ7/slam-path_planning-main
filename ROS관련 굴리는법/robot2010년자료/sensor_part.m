function [ ret_val ] = sensor_part( x,y,theta )
ret_val = 0;
for i=0:5:60
    if(obstacle(x+i*cos(theta),y+i*sin(theta)))
        temp = i;
        for j=1:5
            if(~obstacle(x+(temp-j)*cos(theta),y+(temp-j)*sin(theta)))
                ret_val = ana2dig(temp-j+1);
                break;
            end
        end
        break;
    end
end
end