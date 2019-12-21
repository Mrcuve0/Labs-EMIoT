#include "OLED_Lib.h"

void setup()
{
    OLED_Setup();
    OLED_Init_128128RGB();
    OLED_SetRowAddress_128128RGB(0, 0);
    OLED_SetColumnAddress_128128RGB(0, 0);
}

void loop()
{
}

void serialEvent()
{
    unsigned char c;
    // Reset OLED address when a "start" byte is received
    while (Serial.available())
    {
        c = Serial.read();
        if (c == 0xAA)
        {
            // Start special character
        }
        OLED_Data_128128RGB(c);
    }
}
