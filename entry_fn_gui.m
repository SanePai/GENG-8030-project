function entry_fn_gui(src, event, a, s,b1,b2)
    global spaces_open lcd;

    %Disable buttons when one button is pressed and that event is complete
    b1.Enable="off"; 
    b2.Enable="off";

    if spaces_open>0
            open_procedure(a,s);
            spaces_open = spaces_open-1;
            lcd_printer(lcd,spaces_open);
    else
            lcd_printer(lcd,spaces_open);
    end

    %Enable the buttons after the event is complete
    b1.Enable="on";
    b2.Enable="on";

end