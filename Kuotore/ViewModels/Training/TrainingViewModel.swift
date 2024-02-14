//
//  TrainingViewModel.swift
//  Kuotore
//
//  Created by 柿崎逸 on 2023/11/29.
//

import Foundation
import SwiftUI

class TrainingViewModel: ObservableObject {
    // MARK: - Property Wrappers
    @ObservedObject private var bluetoothManager = CentralViewManager.shared
    @Published private(set) var trainingCount = 0
    @Published private(set) var highestCount = 0
    @Published private(set) var calorie = Double(0)
    @Published private(set) var isCount = false
    @Published var trainingInfos: [TrainingInfo] = []
    let average: Int

    // MARK: - Initialize
    init(average: Int) {
        // 前回の最高記録を表示
        // bluetoothを開始
        trainingInfos = RealmManager.getTrainingInfos()
        self.average = average
    }
}

extension TrainingViewModel {
    // MARK: - Methods
    func averageCount(_ distance: Int?) async {
        guard let distance else { return }
        // Bluetooth通信で距離をたまに取得できないときがあり、０で返ってくるため０の場合は即終了
        guard distance != 0 else { return }
        print("averagegege\(self.average)")
        let countLine = self.average + 50
        // カウントした後に、countLine以上高く上がらないとカウントしないようにする
        if self.isCount {
            guard distance > countLine else { return }
            // カウントしてからカウントラインまで上がったことを示唆する
            self.isCount = false
        }
        if distance <= average {
            self.trainingCount += 1
            self.calorie += 0.8
            self.isCount = true
        }
    }

    @MainActor
    func readHighestRecord() async {
        guard let highestCount = await RealmManager.highestRecordTraining() else {
            return
        }
        print(highestCount)
        self.highestCount = highestCount
    }

    func trainingReset() {
        self.calorie = Double(0)
        self.trainingCount = 0
    }
}
