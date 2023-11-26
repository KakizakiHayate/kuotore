//
//  CentralViewModel.swift
//  Kuotore
//
//  Created by 柿崎逸 on 2023/11/23.
//

import Foundation
import CoreBluetooth
import os

final class CentralViewModel: NSObject, ObservableObject {

    @Published var message = ""
    // MARK: - Properties
    var centralManager: CBCentralManager?
    var discoveredPeripheral: CBPeripheral?
    var transferCharacteristic: CBCharacteristic?
    var writeIterationsComplete = 0
    var connectionIterationsComplete = 0
    let defaultIterations = 5
    var data = Data()

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self,
                                          queue: nil,
                                          options: [CBCentralManagerOptionShowPowerAlertKey: true])
    }
}

// MARK: - CentralViewModel
extension CentralViewModel {
    func stopAction() {
        centralManager?.stopScan()
    }

    /// Bluetoothデバイスとの通信が不要になったときに呼ぶ
    private func cleanup() {
        guard let discoveredPeripheral = discoveredPeripheral else { return }
        guard case .connected = discoveredPeripheral.state else { return }

        guard let service = discoveredPeripheral.services else { return }
        let characteristics = service.compactMap { $0.characteristics }
            .flatMap { $0 }
        characteristics.forEach {
            if $0.uuid == TransferService.characteristicUUID && $0.isNotifying {
                self.discoveredPeripheral?.setNotifyValue(false, for: $0)
                os_log("ペリフェラルからの通知をオフにしました")
            }
        }

        centralManager?.cancelPeripheralConnection(discoveredPeripheral)
        os_log("ペリフェラルとの接続を解除しました")
    }

    private func writeData() {
        guard let discoveredPeripheral = discoveredPeripheral else { return }
        guard let transferCharacteristic = transferCharacteristic else { return }

        while writeIterationsComplete < defaultIterations
                && discoveredPeripheral.canSendWriteWithoutResponse {
            writeIterationsComplete += 1
        }

        if writeIterationsComplete == defaultIterations {
            discoveredPeripheral.setNotifyValue(false, for: transferCharacteristic)
        }
    }

    private func retrievePeripheral() {

        let connectedPeripherals = (centralManager?.retrieveConnectedPeripherals(withServices: [TransferService.serviceUUID]))

        os_log("Found connected Peripherals with transfer service: %@", connectedPeripherals ?? "No Peripherals")

        if let connectedPeripheral = connectedPeripherals?.last {
            os_log("Connecting to peripheral %@", connectedPeripheral)
            self.discoveredPeripheral = connectedPeripheral
            centralManager?.connect(connectedPeripheral, options: nil)
        } else {
            centralManager?.scanForPeripherals(withServices: [TransferService.serviceUUID], options: nil)
        }
    }
}

// MARK: - CentralViewModel: CBCentralManagerDelegate
extension CentralViewModel: CBCentralManagerDelegate {

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print(".powerOn")
            retrievePeripheral()
            return

        case .poweredOff :
            print(".powerOff")
            return

        case .resetting:
            print(".restting")
            return

        case .unauthorized:
            print(".unauthorized")
            return

        case .unknown:
            print(".unknown")
            return

        case .unsupported:
            print(".unsupported")
            return

        @unknown default:
            print("A previously unknown central manager state occurred")
            return
        }
    }

    /// 検索したペリフェラルに接続
    func centralManager(_ central: CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any],
                        rssi RSSI: NSNumber
    ) {
        guard RSSI.intValue >= -50 else { return }

        if discoveredPeripheral != peripheral {
            discoveredPeripheral = peripheral
            centralManager?.connect(peripheral, options: nil)
        }
    }

    /// サービスを検索
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        centralManager?.stopScan()

        connectionIterationsComplete += 1
        writeIterationsComplete = 0

        data.removeAll(keepingCapacity: false)

        peripheral.delegate = self
        peripheral.discoverServices([TransferService.serviceUUID])
    }

    /// ペリフェラルとの接続に失敗したとき
    func centralManager(_ central: CBCentralManager,
                        didFailToConnect peripheral: CBPeripheral,
                        error: Error?
    ) {
        cleanup()
    }

    /// ペリフェラルから切断されたとき
    func centralManager(_ central: CBCentralManager,
                        didDisconnectPeripheral peripheral: CBPeripheral,
                        error: Error?
    ) {
        discoveredPeripheral = nil

        if connectionIterationsComplete < defaultIterations {
            retrievePeripheral()
        } else {
            print("Connection iterations completed")
        }
    }
}

// MARK: - CBCentralManagerDelegate: CBPeripheralDelegate
extension CentralViewModel: CBPeripheralDelegate {

    /// Characteristicを検索
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if error != nil {
            cleanup()
            return
        } else {
            guard let peripheralServices = peripheral.services else {
                return
            }

            for service in peripheralServices {
                peripheral.discoverCharacteristics([TransferService.characteristicUUID], for: service)
            }
        }
    }

    /// ペリフェラルがcharacteristicsを見つけたことを知らせる
    func peripheral(_ peripheral: CBPeripheral,
                    didDiscoverCharacteristicsFor service: CBService,
                    error: Error?
    ) {

        if let error = error {
            print("Error discovering characteristics: \(error.localizedDescription)")
            cleanup()
            return
        }

        guard let serviceCharacteristics = service.characteristics else {
            return
        }

        for characteristic in serviceCharacteristics where characteristic.uuid == TransferService.characteristicUUID {
            transferCharacteristic = characteristic
            peripheral.setNotifyValue(true, for: characteristic)
        }
    }

    /// ペリフェラルからデータが届いたことを知らせる
    func peripheral(_ peripheral: CBPeripheral,
                    didUpdateValueFor characteristic: CBCharacteristic,
                    error: Error?
    ) {
        if let error {
            print("Error discovering characteristics: \(error.localizedDescription)")
            cleanup()
            return
        } else {
            guard let characteristicData = characteristic.value else { return }
            guard let json = try? JSONSerialization.jsonObject(with: characteristicData, options: []) as? [String: Int] else {
                return
            }
            print(json["distance"] ?? 0)
            print(type(of: json["distance"] ?? 0)) // ここでInt型の距離を表示している

            guard let stringFromData = String(data: characteristicData, encoding: .utf8) else {
                return
            }

            print("Received \(characteristicData.count) bytes: \(stringFromData)")

            if stringFromData == "EOM" {
                message = String(data: data, encoding: .utf8) ?? ""
                writeData()
            } else {
                data.append(characteristicData)
            }
        }
    }

    /// 指定されたcharacteristicの通知の要求をペリフェラルが受信したことを通知
    func peripheral(_ peripheral: CBPeripheral,
                    didUpdateNotificationStateFor characteristic: CBCharacteristic,
                    error: Error?
    ) {

        if let error {
            print("Error changing notification state: \(error.localizedDescription)")
            return
        } else {
            guard characteristic.uuid == TransferService.characteristicUUID else {
                return
            }

            if characteristic.isNotifying {
                // 通知開始
                print("Notification began on \(characteristic)")
            } else {
                // 通知が停止してるからペリフェラルとの接続を解除
                print("Notification stopped on \(characteristic). Disconnecting")
                cleanup()
            }
        }
    }

    /// ペリフェラルがcharacteristicのアップデートを送信する準備が整ったことを通知
    func peripheralIsReady(toSendWriteWithoutResponse peripheral: CBPeripheral) {
        print("Peripheral is ready, send data")
        writeData()
    }
}

