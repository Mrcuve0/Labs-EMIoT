#ifndef _OLED_DEFAULT_LIB_H
#define _OLED_DEFAULT_LIB_H

#include "Arduino.h"
#include "OLED_Definitions.h"
#include <SPI.h>

#ifdef __cplusplus
extern "C" {
#endif

void OLED_Command_128128RGB(unsigned char c); // send command to OLED

void OLED_Data_128128RGB(unsigned char d); // send data to OLED

void OLED_SetColumnAddress_128128RGB(unsigned char x_start, unsigned char x_end); // set column address start + end

void OLED_SetRowAddress_128128RGB(unsigned char y_start, unsigned char y_end); // set row address start + end

void OLED_WriteMemoryStart_128128RGB(void); // write to RAM command

void OLED_Init_128128RGB(void); //OLED initialization

void OLED_Setup(void);

#ifdef __cplusplus
}
#endif

#endif //_OLED_DEFAULT_LIB_H
