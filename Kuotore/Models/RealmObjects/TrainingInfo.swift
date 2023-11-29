//
//  TrainingInfo.swift
//  Kuotore
//
//  Created by SeungWoo Hong on 2023/11/26.
//

import RealmSwift

/*
 筋トレ種目のモデル
 */
class TrainingInfo: Object {
    @Persisted var name: String
    
    // 反復する運動 = true, 持続する運動 = false
    @Persisted var isRepetitive = true
    // targetDistanceの値が０だったらまだ設定されてない状態
    // 設定画面に飛ぶ
    @Persisted var targetDistance: Int = 0
    
    // Defaultで生成される種目
    @Persisted var isDefault = false
    
    // TODO: - あとでまた追加
    // 反復する運動
    
    // 持続する運動
    
}
