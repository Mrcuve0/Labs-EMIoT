#include "OLED_lib.h"

#define DEBUG 0

#define IMG_EDIT 0
#define COLOR_REDUCTION_PERC 10

uint8_t data, i;
uint16_t reduction;
char rcv_data[8];


void setup()
{
  OLED_Setup();
  OLED_Init_128128RGB();
  OLED_SetRowAddress_128128RGB(0x00, 0x7F);
  OLED_SetColumnAddress_128128RGB(0x00, 0x7F);
  OLED_WriteMemoryStart_128128RGB();
  Serial.flush();
}

void loop()
{

}

void serialEvent()
{
  Serial.readBytes(rcv_data, 8);

  data = 0x00;
  for (i = 7; i > 0; --i) {
    #if DEBUG
//      Serial.print("I received: ");
//      Serial.println(rcv_data[i], DEC);
    #endif

    data = data | ((rcv_data[7-i] & 0x01) << i);
  }

  #if IMG_EDIT
    // Color reduction applied on all channels
    reduction = (COLOR_REDUCTION_PERC << 6) / 100;
    #if DEBUG
      Serial.println("reduction: ");
      Serial.print(reduction);
    #endif
    data = data - (uint8_t)reduction;
  #endif

  #if DEBUG
//      Serial.print("I sent: ");
//      Serial.println(data, BIN);
  #endif
    
  OLED_Data_128128RGB(data);
}
