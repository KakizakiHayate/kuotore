//
//  TransferService.swift
//  Kuotore
//
//  Created by 柿崎逸 on 2023/11/23.
//

import Foundation
import CoreBluetooth

struct TransferService {
    static let serviceUUID = CBUUID(string: "ea7a61ea-2acc-49dd-885a-d97f09c56c8f")
    static let characteristicUUID = CBUUID(string: "c8c38119-0948-4e26-9288-13fcce4f03df")
}
