//
//  RealmManager.swift
//  Kuotore
//
//  Created by SeungWoo Hong on 2023/11/26.
//

import RealmSwift
import SwiftUI

enum RealmManager {
    
    private static var realm: Realm {
        try! Realm()
    }
    
    // 腕立て伏せ、スクアット、プランクを入れる
    static func initializeTrainingInfo() {
        // 腕立て伏せ
        let pushUp = TrainingInfo()
        pushUp.name = "腕立て伏せ"
        pushUp.isDefault = true
        
        // スクアット
        let squat = TrainingInfo()
        squat.name = "スクアット"
        squat.isDefault = true
        
        // プランク
        let plank = TrainingInfo()
        plank.name = "プランク"
        plank.isRepetitive = false
        plank.isDefault = true
        
        try! realm.write {
            realm.add(pushUp)
            realm.add(squat)
            realm.add(plank)
        }
    }
    
    // 種目を全部読み込む
    static func getTrainingInfos() -> [TrainingInfo] {
        return Array(realm.objects(TrainingInfo.self))
    }
    
    // 初期設定完了
    static func setExecutedStatus(training: TrainingInfo) {
        try! realm.write {
            training.isExecuted = true
        }
    }
}
