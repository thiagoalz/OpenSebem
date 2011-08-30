#include "OpenSebemTeclado.h"
#include <PS2Keyboard.h>
#include "OpenSebemSound.h"
#include "pitches.h"
#include "Display.h"

const int SoundPin = 6;
OpenSebemSound sound;


const int DataPin = 4;
const int IRQpin =  3;
OpenSebemTeclado teclado;


// Configuration for display (can not be modified at runtime! The Display class will keep referencing this array)
// Os itens do seu display. (Nao alterar durante a execucao)
int dsp_cfg[] = { DSP_7SEGINV,  DSP_LED, DSP_7SEGINV }; //Adicione neste vetor os componentes do seu display. As opcoes sao: DSP_7SEG, DSP_7SEGINV, DSP_ALPHA, DSP_LED, DSP_M5X7:
int dsp_len = sizeof(dsp_cfg) / sizeof(int);

/**
 * Cria um objeto Display. 
 * @param  clock     inteiro que indica o Pino para Clock
 * @param  latch     inteiro que indica o Pino para Latch
 * @param  data      inteiro que indica o Pino de entrada de dados
 * @param  dsp_cfg   array com os componentes do display
 * @param  dsp_len   inteiro com a quantidade de componentes do display
 */
Display dsp(12, 8, 11, dsp_cfg, dsp_len);

void setup() {
  delay(1000);
  teclado.setup(DataPin,IRQpin);
  sound.setup(SoundPin);
  
  sound.playMelody(sound.WelcomeMelody,5);  
}

void loop() {
  char c = teclado.readKey(); 
  
  dsp.set(0, c);
  dsp.update();
}
