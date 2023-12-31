//
//  AddTrainingEventViewModel.swift
//  Kuotore
//
//  Created by 柿崎逸 on 2023/11/27.
//

import Foundation
import SwiftUI

class AddTrainingEventViewModel: ObservableObject {
    // MARK: - Property Wrappers
    @Published var name = ""
    @Published var distances = [Int]()
    @Published var preparationTime = 5
    @Published var distanceTime = 3
    // MARK: - Properties
    private var startButtonTimer: Timer?
    private var distanceTimer: Timer?

    // MARK: - Count
    enum Count {
        // MARK: - Finish
        enum Finish: Int {
            case finish = 0
        }
        // MARK: - Time
        enum Time: Int {
            case preparationMaxTime = 5
            case distanceMaxTime = 3
        }
    }
}

extension AddTrainingEventViewModel {
    // MARK: - Methods
    // TODO: - 後でメソッド名変更
    /// 測定準備
    func startReserveCountdown(_ bluetoothManager: CentralViewManager) async {
        self.startButtonTimer?.invalidate()

        self.startButtonTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }
            if preparationTime > Count.Finish.finish.rawValue {
                preparationTime -= 1 // 1秒ずつ減らしていく
            } else {
                startButtonTimer?.invalidate()
                Task {
                    await self.finishDistanceMeasureCountDown(bluetoothManager)
                }
                self.preparationTime = Count.Time.preparationMaxTime.rawValue // 初期値に戻す
            }
        }
    }

    // TODO: - 後でメソッド名変更
    /// 測定開始
    func finishDistanceMeasureCountDown(_ bluetoothManager: CentralViewManager) async {
        self.distanceTimer?.invalidate()

        self.distanceTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }
            if distanceTime > Count.Finish.finish.rawValue {
                bluetoothManager.startAction()
                distanceTime -= 1
            } else {
                distanceTimer?.invalidate()
                bluetoothManager.stopAction()
                distanceTime = Count.Time.distanceMaxTime.rawValue // 初期値に戻す
                Task {
                    await self.averageDistance()
                }
            }
        }
    }

    func averageDistance() async {
        if distances.isEmpty { return }

        let sum = distances.reduce(0, +)
        let average = sum / distances.count

        Logger.standard.notice("\(average)")

        // 平均求めたらrealmに保存
        await RealmManager.addTrainingEvent("種目テスト", nil, average)
    }
}
