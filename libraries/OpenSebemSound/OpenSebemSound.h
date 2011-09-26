/*
  OpenSebemSound.h - Biblioteca de Som para o OpenSebem
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

#ifndef OpenSebemSound_h
#define OpenSebemSound_h

#include <inttypes.h>

/**
 * Purpose: ....
 * Author:  Thiago A. Lechuga
 */
class OpenSebemSound {
  public:
    /**
     * Contructor.
     */
    OpenSebemSound();


    /**
     * Setup pins.
     */
    void setup(uint8_t pin);
    
    /**
     * 
     * 
     */
    void playMelody(int song[], int lengh);

	///////
    static int WelcomeMelody[];
    static int GameSelectedMelody[];
    static int CorrectMelody[];
    static int WrongMelody[];
    static int FailMelody[];
    static int WinnerMelody[];
    static int HighBeepMelody[];
    static int LowBeepMelody[];

  private:
    uint8_t _pin;
};

#endif
