//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////***ARDUINO CODE FOR PLANT-SOFT ROBOT BIOHYBRID***////////////////////////////////////////////////////////
/////BASED ON: http://softroboticstoolkit.com/files/sorotoolkit/files/srt_controlboardcode.txt?m=1407084537 //
/////MODIFICATIONS BY JONAS JØRGENSEN (2016)//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

int led = 13; 

//-----------TIMER
#include <elapsedMillis.h>
elapsedMillis timeElapsed;
unsigned int interval = 30000;//TIME THE ROBOT CAN BE ACTIVE (INCL. INITIAL INFLATE) (interval in ms)
//#define interval 15000 
//#define interval 4294922296-45000 

//----------LDR VALUES
const int sensorPin1 = 5;
const int sensorPin2 = 6;
const int sensorPin3 = 7;
int lightLevel1;
int lightLevel2;
int lightLevel3;

int prescaler = 256; // set this to match whatever prescaler value you set in CS registers below
// intialize values for the PWM duty cycle set by pots
float potDC1 = 0;
float potDC2 = 0;
float potDC3 = 0;
float potDC4 = 0;
float potPWMfq = 50; //analogRead(A7)*100.0/1024.0; // scale values from pot to 0 to 100, which gets used for frequency (Hz)

bool initialInflate = 1; //USED TO FLAG IF INITIAL INFLATION HAS OCCURED

void setup() {

  // initialize the digital pin as an output.
  pinMode(led, OUTPUT);
  timeElapsed = 0; // clear the timer at the end of startup

  Serial.begin(9600);

  // input pins for valve switches
  pinMode(50, INPUT);
  pinMode(51, INPUT);
  pinMode(52, INPUT);
  pinMode(53, INPUT);

  // output pins for valve PWM
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(7, OUTPUT);
  pinMode(8, OUTPUT);

  int eightOnes = 255;  // this is 11111111 in binary
  TCCR3A &= ~eightOnes;   // this operation (AND plus NOT), set the eight bits in TCCR registers to 0 
  TCCR3B &= ~eightOnes;
  TCCR4A &= ~eightOnes;
  TCCR4B &= ~eightOnes;

  // set waveform generation to frequency and phase correct, non-inverting PWM output
  TCCR3A = _BV(COM3A1);
  TCCR3B = _BV(WGM33) | _BV(CS32);
  TCCR4A = _BV(COM4A1) | _BV(COM4B1) | _BV(COM4C1);
  TCCR4B = _BV(WGM43) | _BV(CS42);
}


void loop() {

if (timeElapsed > interval) breakSeq();

int lightThreshold=950; //***THIS VALUES HAS BEEN ADJUSTED FOR THE SYSTEM TO MATCH 10 CM AWAY WITH FLASHLIGHT
int GlobalLightThreshold = 1500;
int detectedLight=0;
pPWM(potPWMfq,0,0,0, 0);

//** ACTIVATE ROBOT WHEN AN INDIVIDUAL LIGHT SENSING GOES ABOVE THE THRESHOLD LEVEL
while (lightLevel1 < lightThreshold && lightLevel2 < lightThreshold && lightLevel3 < lightThreshold) {
//while (detectedLight < GlobalLightThreshold) {
  if (initialInflate == 1) {timeElapsed = 0;} //reset the timer if initial inflation has not started
  lightLevel1 = analogRead(sensorPin1);
  lightLevel2 = analogRead(sensorPin2);
  lightLevel3 = analogRead(sensorPin3);
  Serial.print("While loop");
  Serial.print("\t");
  Serial.println(timeElapsed); 
  detectedLight = lightLevel1 + lightLevel2 + lightLevel3;
  if (timeElapsed > interval) breakSeq();
  }

  lightLevel1 = analogRead(sensorPin1);
  lightLevel2 = analogRead(sensorPin2);
  lightLevel3 = analogRead(sensorPin3);

if (initialInflate == 1){
  Serial.println("Initial inflate");
  pPWM(potPWMfq,100,100,100, 0);
  delay(8500);
  initialInflate = 0;
  }

float inflateAmount=30;
Serial.println("Control");

if (lightLevel1 > lightLevel2 && lightLevel1 > lightLevel3) {
  potDC1=0;
  potDC2=inflateAmount;
  potDC3=inflateAmount;
}

if (lightLevel2 > lightLevel1 && lightLevel2 > lightLevel3) {
  potDC1=inflateAmount;
  potDC2=0;
  potDC3=inflateAmount;
}

if (lightLevel3 > lightLevel1 && lightLevel3 > lightLevel2) {
  potDC1=inflateAmount;
  potDC2=inflateAmount;
  potDC3=0;
}

pPWM(potPWMfq,potDC1,potDC2,potDC3, 0);
delay(50);
 
}


void pPWM(float pwmfreq, float pwmDC1, float pwmDC2, float pwmDC3, float pwmDC4) {

  // set PWM frequency by adjusting ICR (top of triangle waveform)
  ICR3 = F_CPU / (prescaler * pwmfreq * 2);
  ICR4 = F_CPU / (prescaler * pwmfreq * 2);
  
  // set duty cycles
  OCR3A = (ICR4) * (pwmDC1 * 0.01);
  OCR4A = (ICR4) * (pwmDC2 * 0.01);
  OCR4B = (ICR4) * (pwmDC3 * 0.01);
  OCR4C = (ICR4) * (pwmDC4 * 0.01);
}

void breakSeq(){
    Serial.println("Timer run out");
    pPWM(potPWMfq,0,0,0, 0);
    digitalWrite(led, HIGH);
    delay(40000);///WAIT FOR ROBOT TO DEFLATE
    initialInflate = 1;
    timeElapsed = 0; //reset the timer
    digitalWrite(led, LOW);
    lightLevel1 = analogRead(sensorPin1);
    lightLevel2 = analogRead(sensorPin2);
    lightLevel3 = analogRead(sensorPin3);
    }



