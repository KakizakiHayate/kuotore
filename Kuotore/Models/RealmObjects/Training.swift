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
    @Persisted var name: String
    @Persisted var repeatCount: Int = 0
    @Persisted var elapsedTime: Int = 0
    @Persisted var consumedCalorie: Float
    @Persisted var distances: RealmSwift.List<Int> = RealmSwift.List<Int>()
}
