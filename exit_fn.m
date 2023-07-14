function exit_fn(a,s)
    global spaces_open lcd total_spaces;
    if spaces_open<total_spaces %Open the gate only if spaces_open is less than total spaces in the lot
            open_procedure(a,s);
            spaces_open = spaces_open+1;
            lcd_printer(lcd,spaces_open);
    else
            lcd_printer(lcd,spaces_open);
    end
end