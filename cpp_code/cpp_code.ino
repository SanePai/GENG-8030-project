#include <Servo.h>
#include <LiquidCrystal.h>

// Create servo and lcd objects
Servo gate_servo;
LiquidCrystal lcd(13, 8, 2, 3, 4, 7);

// Define pins and values
const int red_light = 5;
const int green_light = 6;
const int entry_button = 11;
const int exit_button = 12;
const int close_val = 0;
const int open = 90;
int spaces_open = 12;
const int total_spaces = 13;



void setup()
{
  Serial.begin(9600);
  gate_servo.attach(9, 500, 2500); // Intialize servo 
  lcd.begin(16, 2); // Intialize lcd

  // Define pinmodes
  pinMode(red_light, OUTPUT);
  pinMode(green_light, OUTPUT);
  pinMode(entry_button, INPUT);
  pinMode(exit_button, INPUT);

  // Intial state 
  gate_servo.write(close_val);
  digitalWrite(red_light,1);
  lcd_printer(spaces_open);


}

void loop()
{
  if (digitalRead(entry_button) == 1){
    spaces_open = entry_fn();
  }

  if (digitalRead(exit_button) == 1){
    spaces_open = exit_fn();
  }

}


void lcd_printer(int spaces_open){
  lcd.clear();
  String space_msg = "Spaces left: " + String(spaces_open);
  //Change message based on spaces_left
  if (spaces_open>0){
        lcd.print("Welcome!!!");
        lcd.setCursor(0, 1);
        lcd.print(space_msg);
  } 
    else{
        lcd.print("Plz come later");
        lcd.setCursor(0, 1);
        lcd.print(space_msg);
    }
}

int entry_fn(){
  if (spaces_open>0){
    open_procedure();
    spaces_open -= 1;
    lcd_printer(spaces_open);
  }
  else{
    lcd_printer(spaces_open);
  }
  return spaces_open;
}

void open_procedure(){
  gate_servo.write(open);
  digitalWrite(red_light,0);
  digitalWrite(green_light,1);

  delay(5000);

  digitalWrite(green_light,0);
  digitalWrite(red_light,1);
  gate_servo.write(close_val);


}

int exit_fn(){
  //Open the gate only if spaces_open is less than total spaces in the lot
  if (spaces_open<total_spaces){
          open_procedure();
          spaces_open += 1;
          lcd_printer(spaces_open);
  }
  else{
          lcd_printer(spaces_open);
  }
  return spaces_open;
}