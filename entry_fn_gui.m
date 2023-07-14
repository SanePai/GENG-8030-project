function entry_fn_gui(src, event, a, s,b1,b2)
    global spaces_open open close_val red_light green_light lcd light;
    b1.Enable="off";
    b2.Enable="off";
    if spaces_open>0
            open_procedure(a,s,open,close_val,red_light,green_light, light);
            spaces_open = spaces_open-1;
            lcd_printer(lcd,spaces_open);
    else
            lcd_printer(lcd,spaces_open);
    end
    % disp("spaces open in fn")
    % spaces_open
    b1.Enable="on";
    b2.Enable="on";

end