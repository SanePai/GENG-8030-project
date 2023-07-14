function lcd_printer(lcd,spaces_open)
%lcd_printer Printer function for the LCD

clearLCD(lcd);
space_msg = "Spaces left: " + spaces_open;

if spaces_open>0
    printLCD(lcd,'Welcome!!!');
    printLCD(lcd,convertStringsToChars(space_msg));
else
    printLCD(lcd, 'Plz come later');
    printLCD(lcd,convertStringsToChars(space_msg));
end
end