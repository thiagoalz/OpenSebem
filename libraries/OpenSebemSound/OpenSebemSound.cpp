/*
  OpenSebemSound.cpp - Biblioteca de som para o OpenSebem
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

#include "OpenSebemSound.h"
#include "pitches.h"

OpenSebemSound::OpenSebemSound() {
}

void OpenSebemSound::setup(uint8_t pin){
    this->_pin=pin;
}


void OpenSebemSound::playMelody(int song[], int lengh){
	// iterate over the notes of the melody:
	for (int thisNote = 0; thisNote < lengh; thisNote++) {

		// to calculate the note duration, take one second 
		// divided by the note type.
		//e.g. quarter note = 1000 / 4, eighth note = 1000/8, etc.
		int noteDuration = 1000/4;
		tone(this->_pin, song[thisNote],noteDuration);

		// to distinguish the notes, set a minimum time between them.
		// the note's duration + 30% seems to work well:
		int pauseBetweenNotes = noteDuration * 1.30;
		delay(pauseBetweenNotes);
		// stop the tone playing:
		noTone(this->_pin);
	}
}

int OpenSebemSound::WelcomeMelody[] = {NOTE_E4, NOTE_G4,NOTE_A4, NOTE_G4, NOTE_E4};
int OpenSebemSound::GameSelectedMelody[] = {NOTE_C5, NOTE_G4,NOTE_C5};
int OpenSebemSound::CorrectMelody[] = {NOTE_G4, NOTE_C5,NOTE_C5};
int OpenSebemSound::WrongMelody[] = {NOTE_E4, NOTE_C4};
int OpenSebemSound::FailMelody[] = {NOTE_E4, NOTE_G4,NOTE_E4, NOTE_C4};
int OpenSebemSound::WinnerMelody[] = {NOTE_G4, NOTE_G4, NOTE_G4, NOTE_E4, NOTE_C5, NOTE_C5, NOTE_C5};
int OpenSebemSound::HighBeepMelody[] = {NOTE_C5};
int OpenSebemSound::LowBeepMelody[] = {NOTE_C4};
