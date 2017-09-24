/*
 * test function file
`*`by Michelle Quin
*/

const int buzzer = 5;
const int motorPin = 4;

void setup() {
  pinMode( buzzer , OUTPUT);
  pinMode( motorPin, OUTPUT);

}

void loop() {

  /*
   * AUDIO TESTING:
   * frequency, harmonic regularity, 
   * duration, rate, rhythmn
   */
  
  /*frequency & harmonic regularity*/
  
  //single_frequency(500);
  //beep_frequency(50);
  
  //two_tone(50, 1000);
  //three_tone(50, 200, 500);

  //harmonic_up(50, 100, 30);
  //harmonic_down(2000, 50, 50);
  

  /*duration & rate */
  
  //note_duration(500);
  
  //rate(50);
  
  //rate_duration(500,50);

  /* rhythm */
  
  //rhythm(500, 100, 50);

  /*
   * VIBRATION TESTING:
   * duration, gap length, intensity, 
   * amount of displays, pattern
   */

   /* duration & gap length */

   //vib_duration(500);
   
   //vib_duration_gap(10000);
   //vib_diff_duration_gap(500, 5000);

   //vib_gap(1000);

   /* stimulus intensity */

   //vib_intensity(50);

   /* amount of displays */
   
   //two_displays(500, 1000);
   //two_diff_displays(500, 1000, 2000, 100);

   /* pattern */

   //vib_pattern(1000, 500, 2000, 1000, 250, 150);

   digitalWrite(motorPin, LOW);
  
}

/*
 * AUDIO TEST FUNCTIONS
 */

/*Frequency testing */

//testing purely frequency, one note 2000 ms
//x = frequency
void single_frequency(int x) {
  tone(buzzer, x, 2000);
  
}

//testing frequency with rapid beeping/delay
//x = frequency
void beep_frequency(int x) {
  tone(buzzer, x);
  delay(100);
  noTone(buzzer);
  delay(100);
}

//testing two frequency pattern
//x = starting frequency, y = second frequency
void two_tone (int x, int y) {
      tone(buzzer, x);
      delay(100);
      noTone(buzzer);
      delay(100);
      tone(buzzer, y);
      delay(100);
      noTone(buzzer);
      delay(100);
}

/*Harmonic Regularity*/

//testing three tone harmony fluctuation
//x=starting, y=mid, z=end
void three_tone (int x, int y, int z) {
      tone(buzzer, x);
      delay(100);
      noTone(buzzer);
      delay(100);
      tone(buzzer, y);
      delay(100);
      noTone(buzzer);
      delay(100);
      tone(buzzer, z);
      delay(100);
      noTone(buzzer);
      delay(100);
      tone(buzzer, y);
      delay(100);
      noTone(buzzer);
      delay(100);
}

//testing incrementing frequency - harmonic up
//x = starting frequency, y = increment, z = cycles
void harmonic_up(int x, int y, int z) {
  int i;
  for (i=0; i<z; i++) {
    tone(buzzer, x + y*i);
    delay(100);
    noTone(buzzer);
    delay(100);
  }
}

//testing descending frequency - harmonic down
//x = starting frequency, y = increment, z = cycles
void harmonic_down(int x, int y, int z) {
  int i;
  for (i=0; i<z; i++) {
    tone(buzzer, x - y*i);
    delay(100);
    noTone(buzzer);
    delay(100);
  }
}

/*Duration Testing*/

//testing duration of each note
//x = delay
//constant frequency of 500 Hz
void note_duration(int x) {
  tone(buzzer, 500);
  delay(x);
  noTone(buzzer);
  delay(100);
}

/*Rate Testing */
//x = gap length
//constant frequency of 500 Hz
void rate(int x) {
  tone(buzzer, 500);
  delay(100);
  noTone(buzzer);
  delay(x);
}

//both duration and rate testing
//x = note length, y = gap length
//constant frequency of 500 Hz
void rate_duration(int x, int y) {
  tone(buzzer, 500);
  delay(x);
  noTone(buzzer);
  delay(y);
}

/* Rhythm */

//change rhythm of constant frequency 500
//x, y, z = three different gap lengths/durations
void rhythm(int x, int y, int z) {
      tone(buzzer, 500);
      delay(x);
      noTone(buzzer);
      delay(y);
      tone(buzzer, 500);
      delay(z);
      noTone(buzzer);
      delay(x);
      tone(buzzer, 500);
      delay(y);
      noTone(buzzer);
      delay(z);
}

/* END AUDIO FUNCTIONS */

/*
 * VIBRATION MOTOR FUNCTIONS
 */

/* Duration Testing */

//change total duration
//x = duration length in ms
void vib_duration(int x) {
  delay(x);
  digitalWrite(motorPin, LOW);
  digitalWrite(motorPin, HIGH);
}

//proportionately change pulse duration and gap length
//x = duration/gap length in ms
void vib_duration_gap(int x) {
  digitalWrite(motorPin, LOW);
  delay(x);
  digitalWrite(motorPin, HIGH);
  delay(x);
}

//separately change both pulse duration and gap length
//x = gap length, y = duration in ms
void vib_diff_duration_gap(int x, int y) {
  digitalWrite(motorPin, LOW);
  delay(x);
  digitalWrite(motorPin, HIGH);
  delay(y);
}

/*Gap Length Testing*/

//change gap length with constant duration of 500 ms
//x = gap length
void vib_gap(int x) {
  digitalWrite(motorPin, LOW);
  delay(x);
  digitalWrite(motorPin, HIGH);
  delay(500);
}

/*Stimulus Intensity Testing*/

//change intensity of vibration at
//constant 2000 ms duration
void vib_intensity(int x) {
  delay(2000);
  analogWrite(motorPin, 0);
  analogWrite(motorPin, x);
}

/* Amount of Displays Testing */

//two displays, one on pin 4, other on pin 6
//x = duration/gap length of pin 6
//y = duration/gap length of pin 4
void two_displays(int x, int y) {
  
  digitalWrite(6, LOW);
  delay(x);
  digitalWrite(6, HIGH);
  delay(x);

  digitalWrite(motorPin, LOW);
  delay(y);
  digitalWrite(motorPin, HIGH);
  delay(y);
}

//two displays, one on pin 4, other on pin 6
//change duration and gap length separately
//pin 6: x = gap length, y = duration
//pin 4: z = gap length, q = duration
void two_diff_displays(int x, int y, int z, int q) {
  digitalWrite(6, LOW);
  delay(x);
  digitalWrite(6, HIGH);
  delay(y);

  digitalWrite(motorPin, LOW);
  delay(z);
  digitalWrite(motorPin, HIGH);
  delay(q);
}

/*Pattern Testing*/

//two different durations, intensities, and gap lengths
//x = gap length 1, y = gap length 2
//z = duration 1, q = duration 2
//a = intensity 1, b = intensity 2
void vib_pattern(int x, int y, int z, int q, int a, int b) {
  analogWrite(motorPin, 0);
  delay(x);
  analogWrite(motorPin, a);
  delay(z);
  analogWrite(motorPin, 0);
  delay(y);
  analogWrite(motorPin, b);
  delay(q);
}

