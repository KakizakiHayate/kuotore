//
//  UserInfo.swift
//  Kuotore
//
//  Created by SeungWoo Hong on 2023/11/26.
//

import RealmSwift

/*
 アプリを初めて起動する時に
 受け取るプロフィール情報
 */
class UserInfo: Object {
    @Persisted var name: String
    @Persisted var height: Float
    @Persisted var weight: Float
}
