#include "WiFiModuleEEPROM.h"

boolean scon=false;
boolean ccon=false;

void setup()
{
  Serial.begin(115200);
  initProcess(true);
}

void loop()
{
  confProcess();
}
