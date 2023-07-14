function lcd_printer(lcd,spaces_open)
    %Printer function for the LCD and text in the GUI window
    global spaces_open_label;
    clearLCD(lcd);
    space_msg = convertStringsToChars("Spaces left: " + spaces_open);
    
    if spaces_open>0 %Change message based on spaces_left
        printLCD(lcd,'Welcome!!!');
        printLCD(lcd,space_msg);
        spaces_open_label.Value = {'Welcome!!!'; space_msg};
    else
        printLCD(lcd, 'Plz come later');
        printLCD(lcd,space_msg);
        spaces_open_label.Value = {'Plz come later'; space_msg};
    end
end