//
//  InitializeTrainingView.swift
//  Kuotore
//
//  Created by SeungWoo Hong on 2023/11/29.
//

import SwiftUI

struct InitializeTrainingView: View {
    
    let trainingInfo: TrainingInfo
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                VStack {
                    Image("logo-primary")
                        .resizable()
                        .frame(width: proxy.size.width / 4)
                        .frame(height: proxy.size.width / 4)
                    HStack(spacing: 0) {
                        Text("スクアット")
                            .font(.custom(Font.appExtraBold, size: proxy.size.width / 12))
                            .foregroundStyle(.appPrimary)
                        Text("の")
                            .font(.custom(Font.appBold, size: proxy.size.width / 20))
                    }
                    .padding(.top)
                    Text("初期設定を行います")
                        .font(.custom(Font.appBold, size: proxy.size.width / 20))
                        .frame(maxWidth: .infinity)
                        
                }
                .padding()
            }
        }
    }
}

#Preview {
    InitializeTrainingView(trainingInfo: TrainingInfo())
}
