//
//  HomeView.swift
//  Kuotore
//
//  Created by SeungWoo Hong on 2023/11/26.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var homeVM = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if homeVM.trainingInfos.isEmpty {
                    Text("保存されている種目なし")
                } else {
                    ForEach(homeVM.trainingInfos, id: \.self) { trainingInfo in
                        NavigationLink(destination: EmptyView()) {
                            Text(trainingInfo.name)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
