#include <M5StickCPlus.h>
#include <BLEDevice.h>
#include <BLEUtils.h>
#include <BLEServer.h>
#include <ArduinoJson.h>
#include <Wire.h>
#include <VL53L0X.h>

#define SERVICE_UUID        "ea7a61ea-2acc-49dd-885a-d97f09c56c8f"
#define CHARACTERISTIC_UUID "c8c38119-0948-4e26-9288-13fcce4f03df"

// distance
VL53L0X sensor;
// BLE
BLECharacteristic *pCharacteristic = NULL;
BLEServer *pServer = NULL;

RTC_TimeTypeDef timeStamp;

void setup() {
  initM5();
  initBLE();
  initDistance();
  deinitM5();
}

void loop() {
  uint16_t distance = getDistance();
  
  DynamicJsonDocument doc(200);
  JsonObject data = doc.to<JsonObject>();
  data["distance"] = distance;

  char buffer[255];
  serializeJson(doc, buffer, sizeof(buffer));
  Serial.println(buffer);

  pCharacteristic->setValue(buffer);
  pCharacteristic->notify(true);
  
  delay(100);
}

// M5 methods
void initM5() {
  M5.begin(115200);
  M5.Lcd.setTextColor(TFT_GREEN);
  M5.Lcd.setTextSize(3);
  M5.Lcd.println("loading...");
}

void deinitM5() {
  M5.Lcd.setTextColor(TFT_GREEN);
  M5.Lcd.setTextSize(3);
  M5.Lcd.println("Done");
}

// distance methods
void initDistance() {
  Wire.begin(0, 26);
  sensor.setTimeout(200);
  if (!sensor.init()) {
    Serial.println("Failed to detect and initialize sensor!");
    while (1) {}
  }
  sensor.startContinuous(200);
}

uint16_t getDistance() {
  uint16_t distance = sensor.readRangeContinuousMillimeters();
  Serial.print("Distance: ");
  Serial.print(distance);
  if (sensor.timeoutOccurred()) {
    Serial.print(" TIMEOUT");
  }
  Serial.println();
  return distance;
}

// BLE methods
void initBLE() {
  BLEDevice::init("kuotore");
  pServer = BLEDevice::createServer();
  BLEService *pService = pServer->createService(SERVICE_UUID);
  pCharacteristic = pService->createCharacteristic(CHARACTERISTIC_UUID,
                                                   BLECharacteristic::PROPERTY_READ
                                                   | BLECharacteristic::PROPERTY_WRITE);
  pService->start();
  BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
  pAdvertising->addServiceUUID(SERVICE_UUID);
  pAdvertising->setScanResponse(true);
  pAdvertising->setMinPreferred(0x06);
  pAdvertising->setMinPreferred(0x12);
  BLEDevice::startAdvertising();
  M5.Lcd.println("M5StickC online");
}