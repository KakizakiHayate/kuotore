//
//  HomeView.swift
//  Kuotore
//
//  Created by SeungWoo Hong on 2023/11/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    // Logo
                    HStack {
                        Image("logo")
                            .resizable()
                            .frame(width: 48, height: 48)
                        VStack(alignment: .leading) {
                            Text("\(Constants.username)の")
                                .font(.custom(Font.bizBold, size: 12))
                            Text("クオトレ")
                                .font(.custom(Font.mochiy, size: 24))
                        }
                        .foregroundStyle(.appPrimary)
                    }
                    Spacer()
                    // TODO: - 設定画面作ることになったらここから画面遷移
                    EmptyView()
                }
                
                
                
                Spacer()
            }
            .padding()
            .background(Color.BG)
        }
    }
}

#Preview {
    HomeView()
}
