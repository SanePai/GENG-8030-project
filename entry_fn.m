function entry_fn(a, s)
    global spaces_open lcd;
    if spaces_open>0 %Only open if there are open spaces in the lot
            open_procedure(a,s);
            spaces_open = spaces_open-1;
            lcd_printer(lcd,spaces_open);
    else
            lcd_printer(lcd,spaces_open);
    end
end