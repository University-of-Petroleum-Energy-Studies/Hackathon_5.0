#include <LiquidCrystal.h>
#include <Adafruit_Sensor.h>
#include "dht.h"
#define dht_in A0 

dht DHT;


LiquidCrystal lcd(12, 11, 5, 4, 3, 2);
int alert = 13;
int rain_detect_in=A1;
const int rainMin = 0;     // sensor minimum
const int rainMax = 1024;


// custom characters generated for matrix display we are using
byte heart[] = {  B00000,  B01010,  B11111,  B11111,  B11111,  B01110,  B00100,  B00000 };

byte smiley[] = {  B00000,  B00000,  B01010,  B00000,  B00000,  B10001,  B01110,  B00000  };

byte degree[] = {  B00000,  B00110,  B00110,  B00000,  B00000,  B00000,  B00000,  B00000  };

void setup() {
  pinMode(alert,OUTPUT);
  Serial.begin(9600);
  lcd.begin(16,2);
  
  delay(2000);//Wait before accessing Sensor
  
  printStartingStatement();
  

}

void loop(){
  //checkTemp();
  detectRain();
}// end loop()

void detectRain(){
      int rainReading = analogRead(rain_detect_in);
      int rain_mapped= map(rainReading, rainMin, rainMax, 0, 3);
      lcd.clear();
      lcd.setCursor(0,0);
      Serial.print("Rain possiblility "); Serial.print((rainMax-rain_mapped));     
       switch (rain_mapped) { 
         case 0:     lcd.print("......HEAVY....." ); lcd.setCursor(0,1); lcd.print(".....RAIN....." ); showAlert(); break;
         case 1:    lcd.print("......MIGHT....." ); lcd.setCursor(0,1); lcd.print(".....RAIN....." ); showAlert(); break;
         case 2:    lcd.print("......NOT......" ); lcd.setCursor(0,1); lcd.print("...RAINING...." );  break;
        }
    delay(3000);
      
      
  
  
  }

void checkTemp(){
    DHT.read11(dht_in);  
    lcd.createChar(3,degree);
    lcd.clear();
    lcd.setCursor(0,0); lcd.print("TEMP   ="); lcd.print(DHT.temperature); lcd.write(3); lcd.print("C");
    lcd.setCursor(0,1); lcd.print("HUMID  ="); lcd.print(DHT.humidity); lcd.print(" %");
    
    Serial.print("Temperature ");    Serial.print(DHT.temperature);     Serial.println("C  ");      
    Serial.print("Humidity = ");    Serial.print(DHT.humidity);    Serial.print("%  ");
    
    delay(3000);
  }




void showAlert(){  
    for(int i=0;i<3;i++){
      digitalWrite(alert, HIGH);
      delay(100);
      digitalWrite(alert, LOW); 
      delay(100);
    }
}

void printStartingStatement(){  
   lcd.createChar(1,smiley);
   lcd.createChar(2,heart);
  lcd.noCursor();
  lcd.setCursor(0,0);  lcd.print("^^^Welcome TO^^^");  lcd.setCursor(0,1);  lcd.print("******ARIA******");
  delay(1000);  
  lcd.clear();
  lcd.setCursor(0,0);  lcd.print("ADVANCE RESEARCH");  lcd.setCursor(0,1);  lcd.print(" IN AGRICULTURE ");
  delay(1000);
  lcd.clear();
  lcd.setCursor(0,0);  lcd.print(".MADE IN INDIA "); lcd.write(1);  lcd.setCursor(0,1);  lcd.print("....WITH LOVE ");  lcd.write(2);
  delay(1500);
  lcd.clear();
}
