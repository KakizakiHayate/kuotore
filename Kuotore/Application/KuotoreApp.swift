//
//  KuotoreApp.swift
//  Kuotore
//
//  Created by 柿崎逸 on 2023/11/15.
//

import SwiftUI
import RealmSwift

@main
struct KuotoreApp: SwiftUI.App {

    // MARK: Initialize
    init() {
        let config = Realm.Configuration(schemaVersion: Migration.migrationVersion)
        Realm.Configuration.defaultConfiguration = config
    }

    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    } // body
} // app
