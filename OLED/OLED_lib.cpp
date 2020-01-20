#include "OLED_lib.h"

void OLED_Command_128128RGB(unsigned char c)        // send command to OLED
{             
   digitalWrite(DC_PIN, LOW);
   SPI.transfer(c);
} 

void OLED_Data_128128RGB(unsigned char d)        // send data to OLED
{ 
   digitalWrite(DC_PIN, HIGH);
   SPI.transfer(d);
}

void OLED_SetColumnAddress_128128RGB(unsigned char x_start, unsigned char x_end)    // set column address start + end
{
   OLED_Command_128128RGB(0x15);
   OLED_Data_128128RGB(x_start);
   OLED_Data_128128RGB(x_end);
}

void OLED_SetRowAddress_128128RGB(unsigned char y_start, unsigned char y_end)    // set row address start + end
{
   OLED_Command_128128RGB(0x75);
   OLED_Data_128128RGB(y_start);
   OLED_Data_128128RGB(y_end);
}

void OLED_WriteMemoryStart_128128RGB(void)    // write to RAM command
{
    OLED_Command_128128RGB(0x5C);
}

void OLED_Init_128128RGB(void)      //OLED initialization
{
    digitalWrite(RES_PIN, LOW);
    delay(500);
    digitalWrite(RES_PIN, HIGH);
    delay(500);

    OLED_Command_128128RGB(0xFD); // Command lock setting
    OLED_Data_128128RGB(0x12);    // unlock
    OLED_Command_128128RGB(0xFD); // Command lock setting
    OLED_Data_128128RGB(0xB1);    // unlock
    OLED_Command_128128RGB(0xAE);
    OLED_Command_128128RGB(0xB3); // clock & frequency
    OLED_Data_128128RGB(0xF1);    // clock=Diviser+1 frequency=fh 
    OLED_Command_128128RGB(0xCA); // Duty
    OLED_Data_128128RGB(0x7F);    // OLED _END+1
    OLED_Command_128128RGB(0xA2);   // Display offset
    OLED_Data_128128RGB(0x00);
    OLED_Command_128128RGB(0xA1); // Set display start line
    OLED_Data_128128RGB(0x00);    // 0x00 start line
    OLED_Command_128128RGB(0xA0); // Set Re-map, color depth
    OLED_Data_128128RGB(0xA0);    // 8-bit 262K
    OLED_Command_128128RGB(0xB5); // set GPIO
    OLED_Data_128128RGB(0x00);    // disabled
    OLED_Command_128128RGB(0xAB); // Function Set
    OLED_Data_128128RGB(0x01);    // 8-bit interface, internal VDD regulator
    OLED_Command_128128RGB(0xB4); // set VSL
    OLED_Data_128128RGB(0xA0);    // external VSL
    OLED_Data_128128RGB(0xB5);
    OLED_Data_128128RGB(0x55);
    OLED_Command_128128RGB(0xC1); // Set contrast current for A,B,C
    OLED_Data_128128RGB(0x8A);    // Color A
    OLED_Data_128128RGB(0x70);    // Color B
    OLED_Data_128128RGB(0x8A);    // Color C
    OLED_Command_128128RGB(0xC7); // Set master contrast
    OLED_Data_128128RGB(0x0F);    //  
    OLED_Command_128128RGB(0xB9); // use linear grayscale LUT
    OLED_Command_128128RGB(0xB1); // Set pre & dis-charge
    OLED_Data_128128RGB(0x32);    // pre=1h, dis=1h  
    OLED_Command_128128RGB(0xBB); // Set precharge voltage of color A,B,C
    OLED_Data_128128RGB(0x07);    //
    OLED_Command_128128RGB(0xB2); // display enhancement
    OLED_Data_128128RGB(0xa4);    
    OLED_Data_128128RGB(0x00);
    OLED_Data_128128RGB(0x00);
    OLED_Command_128128RGB(0xB6); // precharge period
    OLED_Data_128128RGB(0x01);    
    OLED_Command_128128RGB(0xBE); // Set VcomH
    OLED_Data_128128RGB(0x07);
    OLED_Command_128128RGB(0xA6); // Normal display
    OLED_Command_128128RGB(0xAF); // Display on
}

void OLED_Setup(void){
   
   pinMode(DC_PIN, OUTPUT);        // configure DC_PIN as output
   pinMode(RES_PIN, OUTPUT);       // configure RES_PIN as output
   pinMode(OLEDCS_PIN, OUTPUT);    // configure OLEDCS_PIN as output
   digitalWrite(OLEDCS_PIN, LOW);  // set OLEDCS_PIN (OLED always selected)
   pinMode(MOSI_PIN, OUTPUT);      // configure MOSI_PIN as output
   pinMode(SCK_PIN, OUTPUT);       // configure SCK_PIN as output

   /** Open serial communications and wait for port to open: */
   Serial.begin(115200);
   while (!Serial) {
     ; // wait for serial port to connect. Needed for native USB port only
   }
   Serial.println("Serial starts.");
   // flush serial buffer
   while(Serial.available() > 0) {
      char t = Serial.read();
   }
   Serial.println("Serial flushed.");   

   /** Create SPI device and start it **/
   SPI.beginTransaction(SPISettings(500000, MSBFIRST,SPI_MODE0));
   SPI.begin();
   Serial.println("SPI starts.");
}
