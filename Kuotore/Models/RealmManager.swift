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
        
        // スクアット
        let squat = TrainingInfo()
        squat.name = "スクアット"
        
        // プランク
        let plank = TrainingInfo()
        plank.name = "プランク"
        plank.isRepetitive = false
        
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

    ///  種目生成で追加する
    static func addTrainingEvent(_ trainingName: String,
                                 _ isRepetitive: Bool?,
                                 _ distance: Int
    ) async {
        let trainingInfo = TrainingInfo()
        trainingInfo.name = trainingName
        trainingInfo.targetDistance = distance
        if let isRepetitive {
            trainingInfo.isRepetitive = isRepetitive // falseの場合のみ
        }

        do {
            try realm.write {
                realm.add(trainingInfo)
            }
        } catch {
            Logger.standard.error("\(error)")
        }
    }
}
