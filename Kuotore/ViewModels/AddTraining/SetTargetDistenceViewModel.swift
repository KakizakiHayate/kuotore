//
//  SetTargetDistenceViewModel.swift
//  Kuotore
//
//  Created by 柿崎逸 on 2024/02/14.
//

import Foundation
import SwiftUI

class SetTargetDistenceViewModel: ObservableObject {
    @ObservedObject private var bluetoothManager = CentralViewManager.shared
    @Published var distances = [Int]()
    @Published var isSet = false
    private(set) var average: Int?
}

extension SetTargetDistenceViewModel {
    // MARK: - Methods
    func averageDistance(_ distance: Int) async {
        // Bluetooth通信で距離をたまに取得できないときがあり、０で返ってくるため０の場合は即終了
        guard distance != 0 else { return }
        if distances.count < 15 {
            distances.append(distance)
        } else {
            self.bluetoothManager.stopAction()
            print("配列です。\(distances)")
            // 平均を求める
            let sum = distances.reduce(0, +)
            let average = sum / distances.count
            // 以下をrealmに保存
            print("\(average)")
            self.average = average
            self.isSet = true
        }
    }

    func addTrainingData(
        name: String,
        isRepetitive: Bool,
        average: Int
    ) async {
        print("nameです\(name)")
        print("isRepetitive\(isRepetitive)")
        print("average: \(average)")
        await RealmManager.addTrainingEvent(name, isRepetitive, average)
    }
}
