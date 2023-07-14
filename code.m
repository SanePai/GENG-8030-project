clear all;
global lcd s red_light green_light entry_button exit_button close_val open ...
    spaces_open total_spaces light;
% Initialize arduino object
a = arduino;

% Initialize LCD object
lcd = addon(a,'ExampleLCD/LCDAddon','RegisterSelectPin','D13','EnablePin',...
    'D8','DataPins',{'D2','D3','D4','D7'});
initializeLCD(lcd);

% Initialize Servo object
s = servo(a, 'D9');

%Define pins and vals
red_light = 'D5';
green_light = 'D6';
entry_button = 'D11';
exit_button = 'D12';
close_val = 0;
open = 0.5;
spaces_open = 11; %Number of spaces open in the lot
total_spaces = 13;

%% UI 
%UI Figure
f = uifigure("Position",[100 100 640 480],"Name","GUI for Smart Parking"...
);
%Buttons
b1 = uibutton(f,"Position",[164 125 100 50], "Text","Enter", "FontSize",18);
b1.ButtonPushedFcn = {@entry_fn_gui, a, s};
b2 = uibutton(f,"Position",[363 125 100 50], "Text","Exit", "FontSize", 18);
b2.ButtonPushedFcn = {@exit_fn_gui, a, s};
%Traffic Light
light = uilamp(f, "Position",[296 232 50 50]);
light_label = uilabel(f, "HorizontalAlignment","center","FontSize",18,...
    "Position",[272 281 98 23], "Text","Traffic Light");
%Spaces open text
spaces_open_label = uitextarea(f,"HorizontalAlignment","center",...
    "FontSize",36, "FontWeight","bold", "Position", [73 363 495 60], "Editable","off");
spaces_open_label_msg = "Spaces Left: "+spaces_open;
spaces_open_label.Value = {convertStringsToChars(spaces_open_label_msg)};
%Servo position
servo_guage = uigauge(f, 'ninetydegree', "Limits",[0 90],...
    "MajorTicks",[0 90], "MajorTickLabels",{'close', 'open'}, ...
    "Orientation", "northeast", "ScaleDirection", "counterclockwise", ...
    "MinorTicks",[], "FontSize",18,"Position",[474 230 90 90], "Value",0);
servo_guage_label = uilabel(f,"HorizontalAlignment","center","FontSize",18,...
    "Position",[462 192 117 23], "Text","Servo Position");

f.Visible = "on";

%% Default state
writePosition(s,0); %Closed gate
writeDigitalPin(a,red_light,1); %Red traffic light
lcd_printer(lcd,spaces_open);
light.Color = "red";

%% Main loop
while true
    entry_val = readDigitalPin(a,entry_button);
    exit_val = readDigitalPin(a,exit_button);
    while entry_val == 0 && exit_val == 0
        break
    end

    %If entry button is pressed
    if entry_val == 1
        entry_fn(a,s);
    end

    %If exit button is pressed
    if exit_val == 1
        exit_fn(a,s);
    end
end

%% Functions
function entry_fn_gui(src, event, a, s)
    global spaces_open open close_val red_light green_light lcd light;
    if spaces_open>0
            open_procedure(a,s,open,close_val,red_light,green_light, light);
            spaces_open = spaces_open-1;
            lcd_printer(lcd,spaces_open);
    else
            lcd_printer(lcd,spaces_open);
    end
    % disp("spaces open in fn")
    % spaces_open
    return
end

function entry_fn(a, s)
    global spaces_open open close_val red_light green_light lcd light;
    if spaces_open>0
            open_procedure(a,s,open,close_val,red_light,green_light, light);
            spaces_open = spaces_open-1;
            lcd_printer(lcd,spaces_open);
    else
            lcd_printer(lcd,spaces_open);
    end
    % disp("spaces open in fn")
    % spaces_open
    return
end

function exit_fn(a,s)
    global open close_val red_light green_light spaces_open lcd total_spaces light
    if spaces_open<total_spaces
            open_procedure(a,s,open,close_val,red_light,green_light, light);
            spaces_open = spaces_open+1;
            lcd_printer(lcd,spaces_open);
    else
            lcd_printer(lcd,spaces_open);
    end
end

function exit_fn_gui(src, event, a,s)
    global open close_val red_light green_light spaces_open lcd total_spaces light
    if spaces_open<total_spaces
            open_procedure(a,s,open,close_val,red_light,green_light, light);
            spaces_open = spaces_open+1;
            lcd_printer(lcd,spaces_open);
    else
            lcd_printer(lcd,spaces_open);
    end
end