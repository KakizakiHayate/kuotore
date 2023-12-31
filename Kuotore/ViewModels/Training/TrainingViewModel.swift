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
    @Published private (set) var highestCount = 0

    // MARK: - Initialize
    init() {
        // 前回の最高記録を表示
        // bluetoothを開始
        bluetoothManager.startAction()   
    }
}

extension TrainingViewModel {
    // MARK: - Methods
    func averageCount(_ distance: Int?) async {
        guard let distance else { return }
        let average = 40
        if distance <= average { trainingCount += 1 }
    }

    @MainActor
    func readHighestRecord() async {
        guard let highestCount = await RealmManager.highestRecordTraining() else {
            return
        }
        print(highestCount)
        self.highestCount = highestCount
    }
}
