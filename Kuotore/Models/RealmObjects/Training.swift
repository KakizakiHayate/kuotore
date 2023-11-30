//
//  Training.swift
//  Kuotore
//
//  Created by SeungWoo Hong on 2023/11/26.
//

import RealmSwift

/*
 １回筋トレを行った時のモデル
 */
class Training: Object {
    @Persisted var trainingInfo: TrainingInfo?
    /// 回数 or 持続時間
    @Persisted var repeatCount: Int = 0
    /// 行った時間
    @Persisted var elapsedTime: Int = 0
    /// 消費カロリー
    @Persisted var consumedCalorie: Float
    // TODO: これ何に使うんだっけ？
    @Persisted var distances: RealmSwift.List<Int> = RealmSwift.List<Int>()
}
