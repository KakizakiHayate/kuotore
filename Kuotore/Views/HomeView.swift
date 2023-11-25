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
                    HStack(alignment: .bottom) {
                        ForEach(Constants.trainingTimes, id: \.self) { time in
                            Spacer()
                            VStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: 12, height: (CGFloat(time) + 1) * 4)
                                    .foregroundStyle(.white)
                                Text("3日前")
                                    .font(.custom(Font.bizRegular, size: 8))
                                    .padding(.top, 2)
                            }
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.appSecondary)
                    }
                }
                .padding(.top)
                
                // 種目リスト
                HStack {
                    Image(systemName: "dumbbell.fill")
                    Text("今すぐ運動を始める")
                        .font(.custom(Font.bizRegular, size: 16))
                    Spacer()
                }
                .foregroundStyle(.appSecondary)
                .padding(.top)
                
                ScrollView {
                    ForEach(Constants.trainings, id: \.self) { training in
                        NavigationLink(destination: EmptyView()) {
                            HStack {
                                Text(training)
                                    .padding(.leading, 24)
                                    .foregroundStyle(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.appSecondary)
                            }
                            .frame(maxWidth: .infinity)
                            .font(.custom(Font.bizRegular, size: 16))
                            .padding()
                            .background {
                                Image("list-item-bg")
                            }
                        }
                    }
                    
                    NavigationLink(destination: EmptyView()) {
                        HStack {
                            Text("カスタム種目生成")
                                .padding(.leading, 24)
                                .foregroundStyle(.black)
                            Spacer()
                            Image(systemName: "plus")
                                .foregroundStyle(.appSecondary)
                        }
                        .frame(maxWidth: .infinity)
                        .font(.custom(Font.bizRegular, size: 16))
                        .padding()
                        .background {
                            Image("list-item-bg")
                        }
                    }
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
