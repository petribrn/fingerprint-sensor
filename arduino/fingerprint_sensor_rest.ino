
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
const char* ssid = "vptr_2.4";
const char* password = "35220911";

// Create AsyncWebServer object on port 80
AsyncWebServer server(80);

bool checkFingerprintSensor(){
  if(!fingerprintSensor.verifyPassword())
  {
    return false;
  }
  return true;
}

int fingerprint_id;

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


  // server.onRequestBody([](AsyncWebServerRequest * request, uint8_t *data, size_t len, size_t index, size_t total) {
  //   if (request->url() == "/post") {
  //     DynamicJsonBuffer jsonBuffer;
  //     JsonObject& root = jsonBuffer.parseObject((const char*)data);
  //     if (root.success()) {
  //       if (root.containsKey("id")) {
  //         Serial.println(root["id"].asString()); // Hello
  //       }
  //     }
  //     request->send(200, "text/plain", "end");
  //   }
  // });

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

  server.on(
    "/newfingerprint",
    HTTP_POST,
    [](AsyncWebServerRequest * request){},
    NULL,
    [](AsyncWebServerRequest * request, uint8_t *data, size_t len, size_t index, size_t total) {
      DynamicJsonBuffer jsonBuffer;
      JsonObject& root = jsonBuffer.parseObject((const char*)data);
      if (root.success()) {
        if (root.containsKey("id")) {
          Serial.println(root["id"].asString());
          fingerprint_id = root["id"];
          root["initSignUp"] = true;
        } else {
          Serial.println("Fail to receive data InitSignUp");
          root["initSignUp"] = false;
        }
      }
      AsyncResponseStream *response = request->beginResponseStream("application/json");
      root.printTo(*response);
      request->send(response);
  });

  server.on("/first-read", HTTP_GET, [](AsyncWebServerRequest *request){
    AsyncResponseStream *response = request->beginResponseStream("application/json");
    DynamicJsonBuffer jsonBuffer;
    JsonObject &root = jsonBuffer.createObject();

     //Espera até pegar uma imagem válida da digital
    while (fingerprintSensor.getImage() != FINGERPRINT_OK);
    
    //Converte a imagem para o primeiro padrão
    if (fingerprintSensor.image2Tz(1) != FINGERPRINT_OK)
    {
      //Se chegou aqui deu erro, então abortamos os próximos passos
      Serial.println(F("Erro image2Tz 1"));
      root["error"] = "Erro image2Tz 1";
      root.printTo(*response);
      request->send(response);
      return;
    }

    root["doneFirstRead"] = true;
    root["removeFinger"] = "Retire o dedo do sensor";

    root.printTo(*response);
    request->send(response);
  });

  server.on("/second-read", HTTP_GET, [](AsyncWebServerRequest *request){
    AsyncResponseStream *response = request->beginResponseStream("application/json");
    DynamicJsonBuffer jsonBuffer;
    JsonObject &root = jsonBuffer.createObject();

    //Espera até tirar o dedo
    while (fingerprintSensor.getImage() != FINGERPRINT_NOFINGER);

    //Espera até pegar uma imagem válida da digital
    while (fingerprintSensor.getImage() != FINGERPRINT_OK);

    //Converte a imagem para o segundo padrão
    if(fingerprintSensor.image2Tz(2) != FINGERPRINT_OK)
    {
      Serial.println(F("Erro image2Tz 2"));
      root["error"] = "Erro image2Tz 2";
      root.printTo(*response);
      request->send(response);
      return;
    }

    //Cria um modelo da digital a partir dos dois padrões
    if(fingerprintSensor.createModel() != FINGERPRINT_OK)
    {
      Serial.println(F("Erro createModel"));
      root["error"] = "Erro createModel";
      root.printTo(*response);
      request->send(response);
      return;
    }

    //Guarda o modelo da digital no sensor
    if(fingerprintSensor.storeModel(fingerprint_id) != FINGERPRINT_OK)
    {
      Serial.println(F("Erro storeModel"));
      root["error"] = "Erro storeModel";
      root.printTo(*response);
      request->send(response);
      return;
    }

    root["doneSecondRead"] = true;
    root["fingerprintId"] = fingerprint_id;

    fingerprint_id = 0;

    root.printTo(*response);
    request->send(response);
  });

  server.on("/check-fingerprint", HTTP_GET, [](AsyncWebServerRequest *request){
    AsyncResponseStream *response = request->beginResponseStream("application/json");
    DynamicJsonBuffer jsonBuffer;
    JsonObject &root = jsonBuffer.createObject();

    //Espera até pegar uma imagem válida da digital
    while (fingerprintSensor.getImage() != FINGERPRINT_OK);

    //Converte a imagem para o padrão que será utilizado para verificar com o banco de digitais
    if (fingerprintSensor.image2Tz() != FINGERPRINT_OK)
    {
      Serial.println(F("Erro image2Tz"));
      root["error"] = "Erro image2Tz";
      root.printTo(*response);
      request->send(response);
      return;
    }

    //Procura por este padrão no banco de digitais
    if (fingerprintSensor.fingerFastSearch() != FINGERPRINT_OK)
    {
      Serial.println(F("Digital não encontrada"));
      root["error"] = "Fingerprint not found";
      root.printTo(*response);
      request->send(response);
      return;
    }
    
    digitalWrite(pinTrava, LOW);
    delay(5000);
    digitalWrite(pinTrava, HIGH);

    root["foundId"] = fingerprintSensor.fingerID;
    root["confidence"] = fingerprintSensor.confidence;

    root.printTo(*response);
    request->send(response);
  });

  server.on(
    "/delete-fingerprint",
    HTTP_POST,
    [](AsyncWebServerRequest * request){},
    NULL,
    [](AsyncWebServerRequest * request, uint8_t *data, size_t len, size_t index, size_t total) {
      DynamicJsonBuffer jsonBuffer;
      JsonObject& root = jsonBuffer.parseObject((const char*)data);
      if (root.success()) {
        if (root.containsKey("id")) {
          Serial.println(root["id"].asString());
          //Apaga a digital nesta posição
          if(fingerprintSensor.deleteModel(root["id"]) != FINGERPRINT_OK)
          {
            Serial.println(F("Erro ao deletar digital"));
            root["error"] = "Erro ao deletar digital";
            root["deletedFingerprint"] = false;
          }
          else
          {
            root["deletedFingerprint"] = true;
          }
        } else {
          Serial.println("Fail to receive data DeleteFingerprint");
          root["deletedFingerprint"] = false;
        }
      }
      AsyncResponseStream *response = request->beginResponseStream("application/json");
      root.printTo(*response);
      request->send(response);
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