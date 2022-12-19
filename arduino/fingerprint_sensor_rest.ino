
// Import required libraries
#include "ESP8266WiFi.h"
#include "ESPAsyncWebServer.h"
#include <AsyncJson.h>
#include <Adafruit_Fingerprint.h> //https://github.com/adafruit/Adafruit-Fingerprint-Sensor-Library
#include <SoftwareSerial.h>
#include <ArduinoJson.h>

//DEFINIÇÃO DO PINO DO RELE
#define pinTrava D2

SoftwareSerial mySerial(D7, D8);
Adafruit_Fingerprint fingerprintSensor = Adafruit_Fingerprint(&mySerial);

// Replace with your network credentials
const char* ssid = "SSID";
const char* password = "SENHA";

// Create AsyncWebServer object on port 80
AsyncWebServer server(80);

bool checkFingerprintSensor(){
  if(!fingerprintSensor.verifyPassword())
  {
    return false;
  }
  return true;
}

void setup(){
  // Serial port for debugging purposes
  Serial.begin(115200);

  // Connect to Wi-Fi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi..");
  }

  // Print ESP8266 Local IP Address
  Serial.println(WiFi.localIP());

  fingerprintSensor.begin(57600);

  // Route for root / web page
  server.on("/", HTTP_GET, [](AsyncWebServerRequest *request){
    request->send_P(200, "text/plain", "Index");
  });

  server.on("/status", HTTP_GET, [](AsyncWebServerRequest *request){
    
    AsyncResponseStream *response = request->beginResponseStream("application/json");
    DynamicJsonBuffer jsonBuffer;
    JsonObject &root = jsonBuffer.createObject();

    if (checkFingerprintSensor()){
      root["isUp"] = true;
    }
    else{
      root["isUp"] = false;
    }
    root.printTo(*response);
    request->send(response);
  });

  server.on("/newfingerprint", HTTP_POST, [](AsyncWebServerRequest *request){
    // É preciso verificar como receber valores, para tratarmos o ID
    request->send_P(200, "text/plain", "{ new: true }");
  });

  server.on("/first-read", HTTP_GET, [](AsyncWebServerRequest *request){
    request->send_P(200, "text/plain", "{ first: true }");
  });

  server.on("/second-read", HTTP_GET, [](AsyncWebServerRequest *request){
    request->send_P(200, "text/plain", "{ second: true }");
  });

  server.on("/check-fingerprint", HTTP_GET, [](AsyncWebServerRequest *request){
    request->send_P(200, "text/plain", "{ check: true }");
  });

  server.on("/delete-fingerprint", HTTP_GET, [](AsyncWebServerRequest *request){
    request->send_P(200, "text/plain", "{ deleted: true }");
  });

  server.on("/get-fingerprint-count", HTTP_GET, [](AsyncWebServerRequest *request){
    AsyncResponseStream *response = request->beginResponseStream("application/json");
    DynamicJsonBuffer jsonBuffer;
    JsonObject &root = jsonBuffer.createObject();

    //Manda o sensor colocar em "templateCount" a quantidade de digitais salvas
    fingerprintSensor.getTemplateCount();

    root["fingerprintCount"] = fingerprintSensor.templateCount;

    root.printTo(*response);
    request->send(response);
  });

  server.on("/empty-database", HTTP_GET, [](AsyncWebServerRequest *request){

    AsyncResponseStream *response = request->beginResponseStream("application/json");
    DynamicJsonBuffer jsonBuffer;
    JsonObject &root = jsonBuffer.createObject();

    //Apaga todas as digitais
    if(fingerprintSensor.emptyDatabase() != FINGERPRINT_OK)
    {
      root["emptySensorDB"] = false;
    }
    else
    {
      root["emptySensorDB"] = true;
    }
    root.printTo(*response);
    request->send(response);
  });

  // server.on("/hello", HTTP_GET, [](AsyncWebServerRequest *request){
  //   request->send(200, "text/plain", "Hello World");
  // });

  // Start server
  server.begin();
}
  
void loop() {

}