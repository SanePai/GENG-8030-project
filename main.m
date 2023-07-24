clear all;
global lcd s red_light green_light entry_button exit_button close_val open ...
    spaces_open total_spaces light spaces_open_label servo_guage;

% Initialize arduino object
a = arduino;

% Initialize LCD object
lcd = addon(a,'ExampleLCD/LCDAddon','RegisterSelectPin','D13','EnablePin',...
    'D8','DataPins',{'D2','D3','D4','D7'});
initializeLCD(lcd);

% Initialize Servo object
s = servo(a, 'D9');

%Define pins and values
red_light = 'D5';
green_light = 'D6';
entry_button = 'D11';
exit_button = 'D12';
close_val = 0;
open = 0.5;
spaces_open = 13; %Number of spaces open in the lot
total_spaces = 13;

%% UI 

%UI Figure
f = uifigure("Position",[100 100 640 480],"Name","GUI for Smart Parking"...
,"Visible", "off"); %Create and hide figure until all elements load
f.CloseRequestFcn = @(src, event) close_confirm(src);

%Buttons
b1 = uibutton(f,"Position",[164 125 100 50], "Text","Enter", "FontSize",18);
b2 = uibutton(f,"Position",[363 125 100 50], "Text","Exit", "FontSize", 18);
b1.ButtonPushedFcn = {@entry_fn_gui, a, s, b1, b2};
b2.ButtonPushedFcn = {@exit_fn_gui, a, s, b1, b2};

%Traffic Light
light = uilamp(f, "Position",[296 232 50 50]);
light_label = uilabel(f, "HorizontalAlignment","center","FontSize",18,...
    "Position",[272 281 98 23], "Text","Traffic Light");

%Spaces open text
spaces_open_label = uitextarea(f,"HorizontalAlignment","center",...
    "FontSize",36, "FontWeight","bold", "Position", [73 363 495 96], "Editable","off");

%Servo position guage
servo_guage = uigauge(f, 'ninetydegree', "Limits",[0 90],...
    "MajorTicks",[0 90], "MajorTickLabels",{'close', 'open'}, ...
    "Orientation", "northeast", "ScaleDirection", "counterclockwise", ...
    "MinorTicks",[], "FontSize",18,"Position",[474 230 90 90], "Value",0);
servo_guage_label = uilabel(f,"HorizontalAlignment","center","FontSize",18,...
    "Position",[462 192 117 23], "Text","Servo Position");


%% Default state
writePosition(s,0); %Closed gate
writeDigitalPin(a,red_light,1); %Red traffic light
light.Color = "red";
f.Visible = "on"; %Display figure after all elements load

%% Startup messages

%Welcome
printLCD(lcd,'Welcome');
spaces_open_label.Value = "Welcome";
pause(2);

%Group number and names
clearLCD(lcd);
printLCD(lcd,'Group 19');
printLCD(lcd,'1.Kushaal');
spaces_open_label.Value = {'Group 19','1.Kushaal'};
pause(2);

clearLCD(lcd);
printLCD(lcd,'2.Harsha');
printLCD(lcd,'3.Pavan');
spaces_open_label.Value = {'2.Harsha','3.Pavan'};
pause(2);

lcd_printer(lcd,spaces_open);



%% Main loop
while true
    entry_val = readDigitalPin(a,entry_button);
    exit_val = readDigitalPin(a,exit_button);
    
    %Disable GUI buttons if spaces_open out of valid range
    if spaces_open <= 0
        b1.Enable="off";
    elseif spaces_open >= 13
        b2.Enable="off";
    else
        b1.Enable="on";
        b2.Enable="on";
    end

    %If entry button is pressed
    if entry_val == 1
        entry_fn(a,s,b1,b2);
    end

    %If exit button is pressed
    if exit_val == 1
        exit_fn(a,s,b1,b2);
    end
end


%% UI functions
function close_confirm(f)
    selection = uiconfirm(f,['Closing this window will stop the program.' ...
        ' Do you want to continue?'],...
            'Warning', 'Icon','warning');
    switch selection
            case 'OK'
                delete(f)
            case 'Cancel'
                return
    end
end

function entry_fn_gui(~, ~, a, s, b1, b2)
    entry_fn(a,s,b1,b2);
end

function exit_fn_gui(~, ~, a, s, b1, b2)
    exit_fn(a,s,b1,b2);
end