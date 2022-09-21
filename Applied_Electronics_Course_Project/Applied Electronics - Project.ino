#include<Servo.h>
Servo servo;

int pirPin = 6;
int pirVcc = 12;
int trigPin = 9;
int echoPin = 10;
int laserPin = 3;
int servoPin = 11;

int valPir = 0;
int pirState = 0;
long duration = 0;
double distance = 0;
double valDist = 0;
int pos = 90;
int ang = 0;
int num = 0;
int mode = 0;
int flag = 0;

void setup() {
  pinMode(pirPin, INPUT);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(laserPin, OUTPUT);

  digitalWrite(pirVcc, HIGH);
  digitalWrite(laserPin, LOW);
  
  servo.attach(servoPin);
  servo.write(pos);

  Serial.begin(9600);
  Serial.println("Default Mode Is Auto");
}

void loop() {
  delay(1000);
  mode = 0;
  flag = senseObject();

  if(flag == 1){
    valDist = measureDistance();
    shoot(valDist);
  }
  else Serial.println("Everything Is Fine!");

  if(Serial.available()){
    manual();
  }
}

int senseObject() {
  valPir = digitalRead(pirPin);
  
  if(valPir == HIGH){
    if(pirState == 0){
      Serial.println("Object Detected!");
      pirState = 1;
      return 1;
    }
  }
  else{
    if(pirState == 1){
      Serial.println("Eveything Is Fine!");
      pirState = 0;
    }
    return 0;
  }
}

double measureDistance() {
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  duration = pulseIn(echoPin, HIGH); // Micro Seconds
  distance = duration * 0.034 / 2; // cm

  Serial.print("Distance = ");
  Serial.print(distance);
  Serial.println(" cm");

  return distance;
} 

void shoot(double val) {
  if(val > 1 and val < 10) mode = 1; 
  else if(val >= 10 and val < 20) mode = 2; 
  else if(val >= 20 and val < 30) mode = 3; 
  else if(val >= 30 and val < 40) mode = 4; 
  else Serial.println("Object is out of range!");

  if(mode != 0){
    for(pos = 45; pos <= 135; pos += mode*5){
      servo.write(pos);
      Serial.print("Pos: ");
      Serial.println(pos);
      digitalWrite(laserPin, HIGH);
      delay(500);
      digitalWrite(laserPin, LOW);
      delay(500);
    }
    pos = 90;
    servo.write(pos);
  }
}

void manual(){
  ang = Serial.readStringUntil('@').toInt();
  num = Serial.readStringUntil('#').toInt();
  servo.write(ang);
  
  Serial.println("Start Shooting!");
  for(int i = 1; i <= num; i++){
    Serial.println(i);
    digitalWrite(laserPin, HIGH);
    delay(500);
    digitalWrite(laserPin, LOW);
    delay(500);
  }
  Serial.println("Mission Complete!");
  
  servo.write(pos);
}
