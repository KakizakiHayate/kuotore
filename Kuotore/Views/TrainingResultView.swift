//
//  TrainingResultView.swift
//  Kuotore
//
//  Created by SeungWoo Hong on 2023/12/01.
//

import SwiftUI
import Charts

struct LineData: Identifiable {
    var id = UUID()
    var week: String
    var sales: Int
    var category: String
}





struct TrainingResultView: View {
    let lineData: [LineData] = [
            .init(week: "1回目", sales: 20, category: "ラーメン"),
            .init(week: "2回目", sales: 10, category: "ラーメン"),
            .init(week: "3回目", sales: 40, category: "ラーメン"),
            .init(week: "4回目", sales: 60, category: "ラーメン"),
            .init(week: "5回目", sales: 80, category: "ラーメン"),
            .init(week: "6回目", sales: 90, category: "ラーメン"),
            .init(week: "7回目", sales: 30, category: "ラーメン"),
            .init(week: "8回目", sales: 20, category: "ラーメン")
        ]
    
    var body: some View {
        NavigationStack {
            GeometryReader(content: { proxy in
                VStack {
                    HStack {
                        Image("logo-primary")
                            .resizable()
                            .frame(width: proxy.size.width / 12)
                            .frame(height: proxy.size.width / 12)
                        Text("お疲れ様でした")
                            .font(.custom(Font.appBold, size: proxy.size.width / 16))
                        Spacer()
                    }
                    
                    HStack {
                        Text("結果を確認してください")
                            .font(.custom(Font.appBold, size: proxy.size.width / 24))
                        Spacer()
                    }
                    .padding(.top)
                    
                    HStack {
                        VStack {
                            Text("消費カロリー")
                                .font(.custom(Font.appBold, size: proxy.size.width / 24))
                            RoundedRectangle(cornerRadius: 4)
                                .frame(maxWidth: .infinity)
                                .frame(maxHeight: 2)
                                .foregroundStyle(.appPrimary)
                            HStack(alignment: .bottom) {
                                Text("177")
                                    .font(.custom(Font.appBlack, size: proxy.size.width / 16))
                                Text("kcal")
                                    .font(.custom(Font.appBold, size: proxy.size.width / 24))
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.appDarkGray)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        VStack {
                            Text("運動量")
                                .font(.custom(Font.appBold, size: proxy.size.width / 24))
                            RoundedRectangle(cornerRadius: 4)
                                .frame(maxWidth: .infinity)
                                .frame(maxHeight: 2)
                                .foregroundStyle(.appPrimary)
                            HStack(alignment: .bottom) {
                                Text("47")
                                    .font(.custom(Font.appBlack, size: proxy.size.width / 16))
                                Text("回")
                                    .font(.custom(Font.appBold, size: proxy.size.width / 24))
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.appDarkGray)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.top)
                    
                    Chart(lineData) { dataRow in
                        LineMark(x: .value("Week", dataRow.week),
                                  y: .value("Sales", dataRow.sales)
                        ).foregroundStyle(Color.white)

                        PointMark(x: .value("Week", dataRow.week),
                                  y: .value("Sales", dataRow.sales)
                        ).foregroundStyle(Color.appPrimary)
                    }
                    .padding()
                    .background(Color.appDarkGray)
                    .frame(height: proxy.size.height / 4)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    HStack {
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("・横　動いた距離")
                            Text("・縦　経過時間")
                        }
                        .font(.custom(Font.appMedium, size: proxy.size.width / 32))
                    }
                    
                    NavigationLink(destination: SetTargetDistenceView()) {
                        Text("ホームに戻る")
                            .font(.custom(Font.appMedium, size: proxy.size.width / 24))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, proxy.size.height / 80)
                            .background(.appPrimary)
                            .foregroundStyle(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.top, proxy.size.height / 8)
                }
                .frame(maxWidth: .infinity)
                .padding()
                
                
            })
        }
    }
}

#Preview {
    TrainingResultView()
}
