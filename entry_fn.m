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