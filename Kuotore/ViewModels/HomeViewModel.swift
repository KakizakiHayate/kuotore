//
//  HomeViewModel.swift
//  Kuotore
//
//  Created by SeungWoo Hong on 2023/11/26.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var trainingInfos: [TrainingInfo] = []
    
    @AppStorage("isFirstTimeToLaunchApp") var isFirstTimeToLaunchApp: Bool = true
    
    init() {
        if isFirstTimeToLaunchApp {
            RealmManager.initializeTrainingInfo()
            isFirstTimeToLaunchApp = false
        }
        
        trainingInfos = RealmManager.getTrainingInfos()
    }
}
