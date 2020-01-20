#include "OLED_Lib.h"

    char c[1],c_mask=0x00;

void setup()
{
    
    OLED_Setup();
    OLED_Init_128128RGB();
    OLED_SetRowAddress_128128RGB(0, 0);
    OLED_SetColumnAddress_128128RGB(0, 0);
    //pinMode(LED_BUILTIN, OUTPUT);


}

void loop()
{
  
  
}

void serialEvent()
{
    
    if(Serial.available()>0)
    { 
         //digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
        Serial.readBytes(c,1);
        c_mask=c&0xA0;
        /*if (c_mask == 0b00) //new pixel
        {
            // Start special character
            
            OLED_Data_128128RGB(c);
        }else if(c_mask == 0b01){ //new image
          OLED_SetRowAddress_128128RGB(0, 0);
          OLED_SetColumnAddress_128128RGB(0, 0);
          OLED_Data_128128RGB(c);
        }
        */
        Serial.println(c,BIN);
        //Serial.println(c_mask,BIN);
    }
    // Reset OLED address when a "start" byte is received
    
}
