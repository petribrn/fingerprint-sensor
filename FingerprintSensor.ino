
#include <Adafruit_Fingerprint.h> //https://github.com/adafruit/Adafruit-Fingerprint-Sensor-Library
#include <SoftwareSerial.h>

//DEFINIÇÃO DO PINO DO RELE
#define pinTrava D2

SoftwareSerial mySerial(D7, D8);
Adafruit_Fingerprint fingerprintSensor = Adafruit_Fingerprint(&mySerial);

void setup()  
{
  pinMode(pinTrava, OUTPUT);
  digitalWrite(pinTrava, HIGH);

  Serial.begin(9600);
  initFingerprintSensor();
}

void initFingerprintSensor()
{
  fingerprintSensor.begin(57600);

  if(!fingerprintSensor.verifyPassword())
  {
    Serial.println(F("Não encontrou o sensor."));
    while(true);
  }
}

void loop()
{
  digitalWrite(pinTrava, LOW);

  printMenu();

  String command = getCommand();
  int i = command.toInt();

  switch (i)
  {
    case 1:
      storeFingerprint();
      break;
    case 2:
      checkFingerprint();
      break;
    case 3:
      printStoredFingerprintsCount();
      break;
    case 4:
      deleteFingerprint();
      break;
    case 5:
      emptyDatabase();
      break;
    default:
      Serial.println(F("Opção inválida"));
      break;
  }

  delay(1000);
}

void printMenu()
{
  Serial.println();
  Serial.println(F("Selecione a opção digitando um dos números abaixo: "));
  Serial.println(F("1 - Cadastrar digital"));
  Serial.println(F("2 - Verificar digital"));
  Serial.println(F("3 - Quantas digitais estão cadastradas?"));
  Serial.println(F("4 - Apagar digital em uma posição"));
  Serial.println(F("5 - Apagar banco de digitais"));
}

String getCommand()
{
  while(!Serial.available()) delay(100);
  return Serial.readStringUntil('\n');
}

//Cadastro da digital
void storeFingerprint()
{
  Serial.println(F("Qual a posição para guardar a digital? (1 a 149)"));

  String strPosition = getCommand();
  int positionParsed = strPosition.toInt();

  if(positionParsed < 1 || positionParsed > 149)
  {
    Serial.println(F("Posição inválida"));
    return;
  }

  Serial.println(F("Posicione o dedo no sensor"));

  //Espera até pegar uma imagem válida da digital
  while (fingerprintSensor.getImage() != FINGERPRINT_OK);
  
  //Converte a imagem para o primeiro padrão
  if (fingerprintSensor.image2Tz(1) != FINGERPRINT_OK)
  {
    //Se chegou aqui deu erro, então abortamos os próximos passos
    Serial.println(F("Erro image2Tz 1"));
    return;
  }
  
  Serial.println(F("Retire o dedo do sensor"));

  delay(2000);

  //Espera até tirar o dedo
  while (fingerprintSensor.getImage() != FINGERPRINT_NOFINGER);

  //Antes de guardar precisamos de outra imagem da mesma digital
  Serial.println(F("Encoste o mesmo dedo no sensor"));

  //Espera até pegar uma imagem válida da digital
  while (fingerprintSensor.getImage() != FINGERPRINT_OK);

  //Converte a imagem para o segundo padrão
  if(fingerprintSensor.image2Tz(2) != FINGERPRINT_OK)
  {
    Serial.println(F("Erro image2Tz 2"));
    return;
  }

  //Cria um modelo da digital a partir dos dois padrões
  if(fingerprintSensor.createModel() != FINGERPRINT_OK)
  {
    Serial.println(F("Erro createModel"));
    return;
  }

  //Guarda o modelo da digital no sensor
  if(fingerprintSensor.storeModel(positionParsed) != FINGERPRINT_OK)
  {
    Serial.println(F("Erro storeModel"));
    return;
  }

  Serial.println(F("Sucesso!!!"));
}

void checkFingerprint()
{
  Serial.println(F("Posicione o dedo no sensor"));

  //Espera até pegar uma imagem válida da digital
  while (fingerprintSensor.getImage() != FINGERPRINT_OK);

  //Converte a imagem para o padrão que será utilizado para verificar com o banco de digitais
  if (fingerprintSensor.image2Tz() != FINGERPRINT_OK)
  {
    Serial.println(F("Erro image2Tz"));
    return;
  }

  //Procura por este padrão no banco de digitais
  if (fingerprintSensor.fingerFastSearch() != FINGERPRINT_OK)
  {
    Serial.println(F("Digital não encontrada"));
    return;
  }

  Serial.print(F("Digital encontrada com confiança de "));
  Serial.print(fingerprintSensor.confidence);
  Serial.print(F(" na posição "));
  Serial.println(fingerprintSensor.fingerID);
  
  digitalWrite(pinTrava, LOW);
  delay(5000);
  digitalWrite(pinTrava, HIGH);
}

void printStoredFingerprintsCount()
{
  //Manda o sensor colocar em "templateCount" a quantidade de digitais salvas
  fingerprintSensor.getTemplateCount();

  Serial.print(F("Digitais cadastradas: "));
  Serial.println(fingerprintSensor.templateCount);
}

void deleteFingerprint()
{
  Serial.println(F("Qual a posição para apagar a digital? (1 a 149)"));

  String strPosition = getCommand();
  int positionParsed = strPosition.toInt();

  //Verifica se a posição é válida ou não
  if(positionParsed < 1 || positionParsed > 149)
  {
    Serial.println(F("Posição inválida"));
    return;
  }

  //Apaga a digital nesta posição
  if(fingerprintSensor.deleteModel(positionParsed) != FINGERPRINT_OK)
  {
    Serial.println(F("Erro ao deletar digital"));
  }
  else
  {
    Serial.println(F("Digital deletada com sucesso!"));
  }
}

void emptyDatabase()
{
  Serial.println(F("Tem certeza? (s/N)"));

  String command = getCommand();
  command.toUpperCase();

  if(command == "S" || command == "SIM")
  {
    Serial.println(F("Apagando banco de digitais..."));

    //Apaga todas as digitais
    if(fingerprintSensor.emptyDatabase() != FINGERPRINT_OK)
    {
      Serial.println(F("Erro ao apagar banco de digitais"));
    }
    else
    {
      Serial.println(F("Banco de digitais apagado com sucesso!"));
    }
  }
  else
  {
    Serial.println(F("Cancelado"));
  }
}
