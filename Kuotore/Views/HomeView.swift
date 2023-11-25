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
                // ヘッダー
                HStack {
                    // ロゴ
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
                
                // 運動時間グラフ
                VStack {
                    HStack {
                        Image(systemName: "chart.xyaxis.line")
                        Text("運動時間記録")
                            .font(.custom(Font.bizRegular, size: 16))
                        Spacer()
                    }
                    .foregroundStyle(.appSecondary)
                    GeometryReader(content: { proxy in
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(.appSecondary)
                                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                            HStack {
                                ForEach(Constants.trainingTimes, id: \.self) { time in
                                    Spacer()
                                    VStack {
                                        RoundedRectangle(cornerRadius: 12)
                                            .frame(width: 12)
                                            .frame(height: proxy.size.height / 5)
                                            .foregroundStyle(.white)
                                        Text("1日前")
                                            .font(.custom(Font.bizRegular, size: 8))
                                    }
                                    Spacer()
                                }
                            }
                            .frame(maxWidth: proxy.size.width / 1.2)
                        }
                        .frame(maxHeight: proxy.size.height / 3.5)
                    })
                }
                .padding(.top)
                
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
