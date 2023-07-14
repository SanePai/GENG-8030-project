function open_procedure(a,s,open,close_val,red_light,green_light,light)
%Used to open the gate and control traffic light
%   Open gate
%   Change light to green
%   wait 5 sec
%   change light to red
%   close gate

    writePosition(s,open);
    writeDigitalPin(a,red_light,0);
    writeDigitalPin(a,green_light,1);
    light.Color = "green"
    pause(5);
    writeDigitalPin(a,green_light,0);
    writeDigitalPin(a,red_light,1);
    light.Color = "red"
    pause(0.1)
    writePosition(s,close_val);


end