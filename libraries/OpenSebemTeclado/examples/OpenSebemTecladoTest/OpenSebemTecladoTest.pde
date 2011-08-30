#include "OpenSebemTeclado.h"
#include <PS2Keyboard.h>

const int DataPin = 4;
const int IRQpin =  3;
OpenSebemTeclado teclado;

void setup() {
	delay(1000);
	teclado.setup(DataPin,IRQpin);
	Serial.begin(9600);
}


void loop() {
    // read the next key
	char c = teclado.readKey();

	Serial.print(c);
}


