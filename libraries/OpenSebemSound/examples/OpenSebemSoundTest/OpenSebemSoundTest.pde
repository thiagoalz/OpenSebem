#include "OpenSebemSound.h"
#include "pitches.h"

const int SoundPin = 8;

OpenSebemSound sound;

void setup() {
	sound.setup(SoundPin);

	sound.playMelody(sound.WelcomeMelody,5);
	delay(1500);
	sound.playMelody(sound.GameSelectedMelody,3);
	delay(1500);
	sound.playMelody(sound.CorrectMelody,3);
	delay(1500);
	sound.playMelody(sound.WrongMelody,2);
	delay(1500);
	sound.playMelody(sound.FailMelody,4);
	delay(1500);
	sound.playMelody(sound.WinnerMelody,7);
	delay(1500);
	sound.playMelody(sound.HighBeepMelody,1);
	delay(1500);
	sound.playMelody(sound.LowBeepMelody,1);
}

void loop() {
  // no need to repeat the melody.
}
