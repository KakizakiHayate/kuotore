//
//  UserInfo.swift
//  Kuotore
//
//  Created by SeungWoo Hong on 2023/11/26.
//

import RealmSwift

class UserInfo: Object {
    @Persisted var name: String?
    @Persisted var height: Float?
    @Persisted var weight: Float?
}
