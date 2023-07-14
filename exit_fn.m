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