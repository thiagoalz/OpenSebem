#include "OpenSebemTeclado.h"
#include <PS2Keyboard.h>
#include "OpenSebemSound.h"
#include "pitches.h"
#include "Display.h"

//Teclas
#define OPB_LIGA 'v'
#define OPB_DESLIGA 'c'
#define OPB_LIVRO 'x'
#define OPB_ENTER 'z'

//Estados
#define OPB_EST_OFF 0
#define OPB_EST_ON 1
#define OPB_EST_LIVRO 2

int estado=0;

const int SoundPin = 7;
OpenSebemSound sound;


const int DataPin = 4;
const int IRQpin =  3;
OpenSebemTeclado teclado;


// Configuration for display (can not be modified at runtime! The Display class will keep referencing this array)
// Os itens do seu display. (Nao alterar durante a execucao)
int dsp_cfg[] = { DSP_7SEGINV, DSP_7SEGINV, DSP_LED, DSP_LED, DSP_LED, DSP_ALPHA, DSP_7SEGINV, DSP_LED, DSP_LED, DSP_7SEGINV, DSP_7SEGINV, DSP_7SEGINV }; //Adicione neste vetor os componentes do seu display. As opcoes sao: DSP_7SEG, DSP_7SEGINV, DSP_ALPHA, DSP_LED, DSP_M5X7:
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
  
  Serial.begin(9600);
}

void loop() {
  //estado_desligado();
  switch(estado){
   case OPB_EST_OFF:
     estado_desligado();
     break;
   case OPB_EST_ON:
     estado_ligado();
     break;
   case OPB_EST_LIVRO:
     estado_livro();
     break;
  }
}

void estado_desligado(){
  //Zerando Displays
  for(int i=0; i<dsp_len; i++){
    dsp.set(i, ' ');
  }
  dsp.update();
  
  //Espera Ligar
  char c = teclado.readKey();
  while(c != OPB_LIGA){
    c = teclado.readKey();
  }
  
  estado=OPB_EST_ON;
}

void estado_ligado(){
  dsp.set(0, '-');
  dsp.set(1, '-');
  dsp.update();
  
  sound.playMelody(sound.WelcomeMelody,5);
  
  dsp.set(0, ' ');
  dsp.set(1, ' ');
  dsp.update();
  delay(500);
  
  pisca('-',' ',500);
  delay(500);
  pisca('-','.',500);
  
  //Verifica Teclas
  while(estado==OPB_EST_ON){
    char c = teclado.readKey();
    
    switch(c){
      case OPB_LIVRO:
        estado=OPB_EST_LIVRO;
        break;
        
      case OPB_DESLIGA:
        estado=OPB_EST_OFF;
        break;
        
      default:
        sound.playMelody(sound.LowBeepMelody,1);
        break;
    }
  }
}

void estado_livro(){
  sound.playMelody(sound.GameSelectedMelody,3);
  pisca('-','.',500);
  
  int livro=00;
  //Verifica Teclas
  while(estado==OPB_EST_LIVRO){
    char c = teclado.readKey();
    
    //Ver se  numero
    //sound.playMelody(sound.HighBeepMelody,1);
    //Se for adiciona numa lista circular (2 pos)
    //Se nao for, roda o switch
    
    switch(c){
      case OPB_ENTER:
        if(livro>0){
          runLivro(livro);
        }else{
          sound.playMelody(sound.LowBeepMelody,1);
        }
        break;
        
      case OPB_DESLIGA:
        estado=OPB_EST_OFF;
        break;
        
      default:
        sound.playMelody(sound.LowBeepMelody,1);
        break;
    }
  }
}

void runLivro(int livro){
  //Mostra questao
  //Le resposta
  //compara resposta
  //emite som
}

///////////////////////////////////
void pisca(char value, char after,int time){
  dsp.set(0, value);
  dsp.set(1, value);
  dsp.update();
  delay(time);
  dsp.set(0, after);
  dsp.set(1, after);
  dsp.update();
}
