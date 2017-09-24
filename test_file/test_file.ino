/*
 * test function file
`*`by Michelle Quin
*/

const int buzzer[] = {5, 6};
const int buzzer2;
const int motorPin = 4;

void setup() {

  Serial.begin(9600);
  pinMode( buzzer , OUTPUT);
  pinMode( buzzer2, OUTPUT);
  pinMode( motorPin, OUTPUT);

}

void loop() {

  char recipeNumber = 0;

  if(Serial.available())
  {
    recipeNumber = Serial.read();
  }

  switch (recipeNumber)
  {
    case '1':
      single_frequency(50);
      break;
    case '2':
    single_frequency(200);
      break;
    case '3':
    single_frequency(750);
      break;
    case '4':
    two_tone(200, 1000);
      break;
    case '5':
    two_tone(500, 50);
      break;

     case '6':
    vib_intensity(200);
      break;
      case '7':
    vib_intensity(75);
      break;

     case '8':
    three_tone(200, 50, 500);
      break;
      case '9':
    three_tone(1000, 500, 50);
      break;
      case 'A':
     harmonic_up(50, 100, 10);
      break;
      case 'B':
    harmonic_down(2000, 500, 5);
      break;

    case 'C':
   vib_duration_gap(750);
      break;
      case 'D':
    vib_duration_gap(100);
      break;

    case 'E':
    note_duration(750);
      break;
      case 'F':
    note_duration(100);
      break;
      case 'G':
    rate_duration(500,50);
      break;
      case 'H':
    rate_duration(100,250);
      break;

   case 'I':
    vib_duration(1000);
      break;
      case 'J':
    vib_duration(100);
      break;
     

    case 'K':
   rate(100);
      break;
      case 'L':
    rate(750);
      break;

      case 'M':
   vib_diff_duration_gap(250, 500);
    break;
      case 'N':
    vib_diff_duration_gap(750, 100);
      break;

     case 'O':
    rhythm(500, 100, 200);
    break;

       case 'P':
      vib_pattern(1000, 750, 500, 250, 255, 127);
      break;
  }

  recipeNumber = 0;

  digitalWrite(motorPin, LOW);
  
}

/*
 * AUDIO TEST FUNCTIONS
 */

/*Frequency testing */

//testing purely frequency, one note 2000 ms
//x = frequency
void single_frequency(int x) {
      tone(buzzer[0], x, 500);
}

//testing frequency with rapid beeping/delay
//x = frequency
void beep_frequency(int x) {
  for (int i=0; i<2; i++) {
    tone(buzzer[i], x);
    delay(100);
    noTone(buzzer[i]);
    delay(100);
  }
}

//testing two frequency pattern
//x = starting frequency, y = second frequency
void two_tone (int x, int y) {
  for (int i=0; i<2; i++) {
      tone(buzzer[i], x);
      delay(100);
      noTone(buzzer[i]);
      delay(100);
      tone(buzzer[i], y);
      delay(100);
      noTone(buzzer[i]);
      delay(100);
  }
}

/*Harmonic Regularity*/

//testing three tone harmony fluctuation
//x=starting, y=mid, z=end
void three_tone (int x, int y, int z) {
  for (int i=0; i<2; i++) {
      tone(buzzer[i], x);
      delay(100);
      noTone(buzzer[i]);
      delay(100);
      tone(buzzer[i], y);
      delay(100);
      noTone(buzzer[i]);
      delay(100);
      tone(buzzer[i], z);
      delay(100);
      noTone(buzzer[i]);
      delay(100);
      tone(buzzer[i], y);
      delay(100);
      noTone(buzzer[i]);
      delay(100);
  }
}

//testing incrementing frequency - harmonic up
//x = starting frequency, y = increment, z = cycles
void harmonic_up(int x, int y, int z) {
  int i;
  for (i=0; i<z; i++) {
    for (int j=0; j<2; j++) {
      tone(buzzer[j], x + y*i);
      delay(100);
      noTone(buzzer[j]);
      delay(100);
    }
  }
}

//testing descending frequency - harmonic down
//x = starting frequency, y = increment, z = cycles
void harmonic_down(int x, int y, int z) {
  int i;
  for (i=0; i<z; i++) {
    for (int j=0; j<2; j++) {
      tone(buzzer[j], x - y*i);
      delay(100);
      noTone(buzzer[j]);
      delay(100);
    }
  }
}

/*Duration Testing*/

//testing duration of each note
//x = delay
//constant frequency of 500 Hz
void note_duration(int x) {
  tone(buzzer[0], 500);
  delay(x);
  noTone(buzzer[0]);
  delay(100);
}

/*Rate Testing */
//x = gap length
//constant frequency of 500 Hz
void rate(int x) {
  for (int i = 0; i<3; i++){
  tone(buzzer[1], 500);
  delay(100);
  noTone(buzzer[1]);
  delay(x);
  }
}

//both duration and rate testing
//x = note length, y = gap length
//constant frequency of 500 Hz
void rate_duration(int x, int y) {
  for (int i = 0; i<3; i++){
  tone(buzzer[1], 500);
  delay(x);
  noTone(buzzer[1]);
  delay(y);
  }
}

/* Rhythm */

//change rhythm of constant frequency 500
//x, y, z = three different gap lengths/durations
void rhythm(int x, int y, int z) {
  for (int i=0; i<2; i++) {
      tone(buzzer[i], 500);
      delay(x);
      noTone(buzzer[i]);
      delay(y);
      tone(buzzer[i], 500);
      delay(z);
      noTone(buzzer[i]);
      delay(x);
      tone(buzzer[i], 500);
      delay(y);
      noTone(buzzer[i]);
      delay(z);
  }
}

/* END AUDIO FUNCTIONS */

/*
 * VIBRATION MOTOR FUNCTIONS
 */

/* Duration Testing */

//change total duration
//x = duration length in ms
void vib_duration(int x) {
  digitalWrite(motorPin, LOW);
  digitalWrite(motorPin, HIGH);
  delay(x);
}

//proportionately change pulse duration and gap length
//x = duration/gap length in ms
void vib_duration_gap(int x) {
  for (int i=0; i<3; i++) {
    digitalWrite(motorPin, LOW);
    delay(x);
    digitalWrite(motorPin, HIGH);
    delay(x);
  }
}

//separately change both pulse duration and gap length
//x = gap length, y = duration in ms
void vib_diff_duration_gap(int x, int y) {
  for (int i=0; i<3; i++) {
    digitalWrite(motorPin, LOW);
    delay(x);
    digitalWrite(motorPin, HIGH);
    delay(y);
  }
}

/*Gap Length Testing*/

//change gap length with constant duration of 500 ms
//x = gap length
void vib_gap(int x) {
  for (int i=0; i<3; i++) {
    digitalWrite(motorPin, LOW);
    delay(x);
    digitalWrite(motorPin, HIGH);
    delay(500);
  }
}

/*Stimulus Intensity Testing*/

//change intensity of vibration at
//constant 2000 ms duration
void vib_intensity(int x) {
  analogWrite(motorPin, 0);
  analogWrite(motorPin, x);
  delay(500);
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
  for (int i=0; i<3; i++) {
  analogWrite(motorPin, 0);
  delay(x);
  analogWrite(motorPin, a);
  delay(z);
  analogWrite(motorPin, 0);
  delay(y);
  analogWrite(motorPin, b);
  delay(q);
  }
}

