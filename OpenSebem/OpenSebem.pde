#include "OpenSebemTeclado.h"
#include <PS2Keyboard.h>
#include "OpenSebemSound.h"
#include "pitches.h"
#include "Display.h"
#include <ctype.h>

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
  pisca('-','0',500);
  
  int livro[2]={0,0};
  int indexLivro=1;
  
  //Verifica Teclas
  while(estado==OPB_EST_LIVRO){
    char c = teclado.readKey();
    
    //Se for um numero
    if (isdigit(c)){
      sound.playMelody(sound.HighBeepMelody,1);
      livro[indexLivro]=atoi(&c);
      dsp.set(indexLivro, c);
      dsp.update();
      
      indexLivro=(indexLivro+1)%2;
    }else{
      int valorLivro=livro[1]+(livro[0]*10);
      
      switch(c){
        case OPB_ENTER:
          if(valorLivro>0){
            sound.playMelody(sound.HighBeepMelody,1);
            runLivro(valorLivro);
            estado=OPB_EST_ON;
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
}

void runLivro(int livro){
  
  int bookNumber = livro / 10;
  int sectionNumber = livro % 10;
  
  int maxQuestion = sectionNumber * 30;
  int currentQuestion = maxQuestion - 29;
  
  int answeredQuestions = 0;
  int points = 0;
  
  dsp.set(0, '.');
  dsp.set(1, '.');
  dsp.update();
  
  sound.playMelody(sound.CorrectMelody,3);
  
  while(currentQuestion<=maxQuestion && estado==OPB_EST_LIVRO){
    int tentativas=leQuestao(bookNumber, currentQuestion);
    answeredQuestions++;
    currentQuestion++;
    points += pointsByNumberOfTries(tentativas);
  }
}


int leQuestao(int book, int questao){
  int tries=0;
  char buffer [3];
  itoa(questao, buffer, 10);
  
  dsp.set(0, buffer[0]);
  dsp.set(1, buffer[1]);
  dsp.update();
  
  while(true){
   char c = teclado.readKey();
  
    switch(c){
     case OPB_A:
     case OPB_B:
     case OPB_C:
     case OPB_D:
       if (getCorrectAnswer(book, questao) == c) {
          sound.playMelody(sound.CorrectMelody,3);
          
          return tries;
        }
        
        tries++;
        if (tries >= 3) {
          sound.playMelody(sound.FailMelody,4);
          return tries;
        } else {
          sound.playMelody(sound.WrongMelody,2);
        }
        break;
        
     case OPB_DESLIGA:
       estado=OPB_EST_OFF;
       return 4;
       break;
     
     default:
       sound.playMelody(sound.LowBeepMelody,1);
     break;
    } 
  }
}

char getCorrectAnswer(int book, int questao){
  char array[]= {"CDDBAADCBDAADCBB"};
  char resposta = array[(book + questao) % 16];
  
  switch(resposta){
   case 'A':
     resposta = OPB_A;
     break;
   case 'B':
     resposta = OPB_B;
     break;
   case 'C':
     resposta = OPB_C;
     break;
   case 'D':
     resposta = OPB_D;
     break;
  }
  
  return resposta;
}

int pointsByNumberOfTries(int tentativas){
  switch (tentativas) {
        case 0:
            return 10;
        case 1:
            return 6;
        case 2:
            return 4;
            
        default:
            return 0;
   }            
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
