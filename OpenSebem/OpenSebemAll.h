/*
  OpenSebemAll.h - Biblioteca com todas as classes para o OpenSebem
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

#ifndef OpenSebemAll_h
#define OpenSebemAll_h

#include <inttypes.h>
#include <WProgram.h>
#include <stdlib.h>
#include <stdio.h>

//Teclas
#define OPB_LIGA 'v'
#define OPB_DESLIGA 'c'
#define OPB_LIVRO 'x'
#define OPB_ENTER 'z'

#define OPB_A 'a'
#define OPB_B 's'
#define OPB_C 'd'
#define OPB_D 'f'

//Estados
//#define OPB_EST_OFF 0
//#define OPB_EST_ON 1
//#define OPB_EST_LIVRO 2

class Activity{
    public:
    Activity();
    virtual void reset();
    virtual void oneLoopIteration();
    virtual void buttonPress(char b);
};
//------------------------------------------------------------------------------

class Welcome: public Activity{
    public:
    Welcome();
    virtual void reset();
    virtual void oneLoopIteration();
    virtual void buttonPress(char b);
};
//------------------------------------------------------------------------------

class Standby: public Activity{
    public:
    Standby();
    virtual void reset();
    virtual void oneLoopIteration();
    virtual void buttonPress(char b);
};
//------------------------------------------------------------------------------

/**
 * Purpose: Classe principal. Simulador. 
 * Author:  Thiago A. Lechuga
 */
class OpenSebem {
  public:

    /**
     * Contructor.
     */
    OpenSebem();

    void init();
        
    void showReminder();

    void resetDefaultVariables();
        
    void reset();

    void delay(int ticks, int callback);
        
    void oneLoopIteration();
        
    void setActivity(Activity *m, bool keepScreenContents);
       
    void prompt(int initialDigit, int maxDigitSize, char promptCharacter);
        
    void buttonPress(char b);
        
    void enableKeyboard();
        
    void disableKeyboard();
        
    int pointsByNumberOfTries(int t);

    /**
     * Setup pins.
     *
    void setup(uint8_t pin);*/

  private:
    bool bugfix;
    /* we are simulating all the bugs from the original machine */
    Activity *activity;
    Activity *previousActivity;
    int ticks;
    //delayTable: {},
    bool keyboardEnabled;
};

#endif
