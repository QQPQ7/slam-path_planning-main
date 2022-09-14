/*
 * --------------------------------------------------------------------------------------------------------------------
 * Example sketch/program showing how to read new NUID from a PICC to serial.
 * --------------------------------------------------------------------------------------------------------------------
 * This is a MFRC522 library example; for further details and other examples see: https://github.com/miguelbalboa/rfid
 * 
 * Example sketch/program showing how to the read data from a PICC (that is: a RFID Tag or Card) using a MFRC522 based RFID
 * Reader on the Arduino SPI interface.
 * 
 * When the Arduino and the MFRC522 module are connected (see the pin layout below), load this sketch into Arduino IDE
 * then verify/compile and upload it. To see the output: use Tools, Serial Monitor of the IDE (hit Ctrl+Shft+M). When
 * you present a PICC (that is: a RFID Tag or Card) at reading distance of the MFRC522 Reader/PCD, the serial output
 * will show the type, and the NUID if a new card has been detected. Note: you may see "Timeout in communication" messages
 * when removing the PICC from reading distance too early.
 * 
 * @license Released into the public domain.
 * 
 * Typical pin layout used:
 * -----------------------------------------------------------------------------------------
 *             MFRC522      Arduino       Arduino   Arduino    Arduino          Arduino
 *             Reader/PCD   Uno/101       Mega      Nano v3    Leonardo/Micro   Pro Micro
 * Signal      Pin          Pin           Pin       Pin        Pin              Pin
 * -----------------------------------------------------------------------------------------
 * RST/Reset   RST          9             5         D9         RESET/ICSP-5     RST
 * SPI SS      SDA(SS)      10            53        D10        10               10
 * SPI MOSI    MOSI         11 / ICSP-4   51        D11        ICSP-4           16
 * SPI MISO    MISO         12 / ICSP-1   50        D12        ICSP-1           14
 * SPI SCK     SCK          13 / ICSP-3   52        D13        ICSP-3           15
 *
 * More pin layouts for other boards can be found here: https://github.com/miguelbalboa/rfid#pin-layout
 */

#include <SPI.h>
#include <MFRC522.h>
//#include "SoftReset.h"

#define SS_PIN 10
#define RST_PIN 9
 
MFRC522 rfid(SS_PIN, RST_PIN); // Instance of the class

MFRC522::MIFARE_Key key; 

// Init array that will store new NUID 
byte nuidPICC[4];

void setup() { 
  Serial.begin(9600);
  SPI.begin(); // Init SPI bus
  rfid.PCD_Init(); // Init MFRC522 
  pinMode(8, OUTPUT);

  for (byte i = 0; i < 6; i++) {
    key.keyByte[i] = 0xFF;
  }

  //Serial.println(F("This code scan the MIFARE Classsic NUID."));
  //Serial.print(F("Using the following key:"));
  printHex(key.keyByte, MFRC522::MF_KEY_SIZE);


  
}
 
void loop() {

int data;

//data입력시 시작

  int n;

  n = Serial.read();
  if(n=='1')
  {
    Serial.println("reset");
    delay(500);
    Serial.begin(9600);
  }
  else
  {
    
  }

int i = 0;    //loop 지역 변수 i를 0으로 입력
    for(i=0;i<=100;i++) {  //while문 호출
    digitalWrite(8, HIGH); //LED ON
    delay(500);  //0.5초 딜레이
    
    digitalWrite(8, LOW);  //LED OFF
    delay(500);  //0.5초 딜레이
   
    i++;   //변수 1씩 추가

      // Reset the loop if no new card present on the sensor/reader. This saves the entire process when idle.
  if ( ! rfid.PICC_IsNewCardPresent())
    return;

  // Verify if the NUID has been readed
  if ( ! rfid.PICC_ReadCardSerial())
    return;

  //Serial.print(F("PICC type: "));
  MFRC522::PICC_Type piccType = rfid.PICC_GetType(rfid.uid.sak);
  //Serial.println(rfid.PICC_GetTypeName(piccType));

  // Check is the PICC of Classic MIFARE type
  if (piccType != MFRC522::PICC_TYPE_MIFARE_MINI &&  
    piccType != MFRC522::PICC_TYPE_MIFARE_1K &&
    piccType != MFRC522::PICC_TYPE_MIFARE_4K) {
    //Serial.println(F("Your tag is not of type MIFARE Classic."));
    return;
  }

  
  if (rfid.uid.uidByte[0] != nuidPICC[0] || 
    rfid.uid.uidByte[1] != nuidPICC[1] || 
    rfid.uid.uidByte[2] != nuidPICC[2] || 
    rfid.uid.uidByte[3] != nuidPICC[3] ) {
    //Serial.println(F("A new card has been detected."));

    // Store NUID into nuidPICC array
    for (byte i = 0; i < 4; i++) {
      nuidPICC[i] = rfid.uid.uidByte[i];
    }
   
    //Serial.println(F("The NUID tag is:"));
    //Serial.print(F("In hex: "));
    for(byte i =0; i<rfid.uid.size;i++)
    {
      Serial.print(rfid.uid.uidByte[i]< 0x10 ? " 0" : " ");
      Serial.print(rfid.uid.uidByte[i], HEX);
      
    }
    Serial.println(F(""));
    //printHex(rfid.uid.uidByte, rfid.uid.size); //HEX 출력
    //Serial.println();
    //Serial.print(F("In dec: "));
    //printDec(rfid.uid.uidByte, rfid.uid.size);
    //Serial.println();
    digitalWrite(8, LOW);  //LED OFF
    //Serial.println("hello");
    
    //while(1);
    delay(1500);


    while(n != '2')
    {
       n = Serial.read();
       if(n =='2')
       {
        Serial.println("skip");
        break;
       }
    }
    //exit(0);
    break;
    
  }
  else 
  {
    Serial.println(F("Card read previously."));
    digitalWrite(8, LOW);  //LED OFF
    Serial.println("hello");
    
    while(n != '2')
    {
       n = Serial.read();
       if(n =='2')
       {
        Serial.println("skip");
        break;
       }
    }

    
    //while(1);
    delay(1500);
    //exit(0);
    break;
  }

  // Halt PICC
  rfid.PICC_HaltA();

  // Stop encryption on PCD
  rfid.PCD_StopCrypto1();
}
}  //while문 종료 지점
  



/**
 * Helper routine to dump a byte array as hex values to Serial. 
 */
void printHex(byte *buffer, byte bufferSize) {
  for (byte i = 0; i < bufferSize; i++) {
    Serial.print(buffer[i] < 0x10 ? " 0" : " ");
    Serial.print(buffer[i], HEX);
  }
}

/**
 * Helper routine to dump a byte array as dec values to Serial.
 */
void printDec(byte *buffer, byte bufferSize) {
  for (byte i = 0; i < bufferSize; i++) {
    Serial.print(buffer[i] < 0x10 ? " 0" : " ");
    Serial.print(buffer[i], DEC);
  }
}
