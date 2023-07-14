function exit_fn_gui(src, event, a,s,b1,b2)
    global open close_val red_light green_light spaces_open lcd total_spaces light
    b1.Enable="off";
    b2.Enable="off";
    if spaces_open<total_spaces
            open_procedure(a,s,open,close_val,red_light,green_light, light);
            spaces_open = spaces_open+1;
            lcd_printer(lcd,spaces_open);
    else
            lcd_printer(lcd,spaces_open);
    end
    b1.Enable="on";
    b2.Enable="on";
end