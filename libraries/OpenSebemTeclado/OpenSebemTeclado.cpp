/*
  OpenSebemTeclado.cpp - Biblioteca de teclado para o OpenSebem
  Copyright (c) 2011 Thiago Alvarenga Lechuga.  All right reserved.
  Written by Thiago A. Lechuga <thiagoalz@gmail.com>

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public
  License along with this library; if not, write to the Free Software
  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
*/


#include <inttypes.h>
#include "WProgram.h"

#include <PS2Keyboard.h>
#include "OpenSebemTeclado.h"


OpenSebemTeclado::OpenSebemTeclado() {
}

void OpenSebemTeclado::setup(uint8_t dataPin, uint8_t irqPin){
    this->_dataPin=dataPin;
    this->_irqPin=irqPin;
    this->_keyboard.begin(this->_dataPin, this->_irqPin);
}


char OpenSebemTeclado::readKey() {
	char c;
	//Hold untill there is something to read
    while(!_keyboard.available()){
		delay(100);
	}

	//Read it
	if (_keyboard.available()) {      
      // read the next key
      c = _keyboard.read();
	}

	return c;
}

