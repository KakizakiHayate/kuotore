//
//  HomeView.swift
//  Kuotore
//
//  Created by SeungWoo Hong on 2023/11/26.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var homeVM = HomeViewModel()
    
    @State var eTrainingTimes: [CGFloat] = [3, 4, 0, 12, 6, 0, 2]
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                ZStack {
                    Color.black.ignoresSafeArea()
                    VStack {
                        HStack {
                            HStack {
                                Image("logo-primary")
                                    .resizable()
                                    .frame(width: proxy.size.width / 12)
                                    .frame(height: proxy.size.width / 12)
                                Text("クオトレ")
                                    .font(.custom(Font.appBlack, size: proxy.size.width / 16))
                                    .foregroundStyle(Color.appPrimary)
                            }
                            Spacer()
                            NavigationLink(destination: EmptyView()) {
                                Image(systemName: "gearshape")
                                    .resizable()
                                    .frame(width: proxy.size.width / 16)
                                    .frame(height: proxy.size.width / 16)
                                    .foregroundStyle(.appPrimary)
                            }
                        }
                        HStack {
                            Text("・7日間の運動記録")
                                .font(.custom(Font.appMedium, size: proxy.size.width / 32))
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        .padding(.top)
                        
                        HStack {
                            ForEach(eTrainingTimes.indices, id: \.self) { index in
                                Spacer()
                                VStack {
                                    ZStack(alignment: .bottom) {
                                        RoundedRectangle(cornerRadius: 12)
                                            .frame(width: proxy.size.width / 32,
                                                   height: proxy.size.height / 8)
                                            .foregroundStyle(Color.appLightGray)
                                        RoundedRectangle(cornerRadius: 12)
                                            .frame(width: proxy.size.width / 32,
                                                   height: (proxy.size.height / 8) * eTrainingTimes[index] / 12)
                                            .foregroundStyle(Color.appPrimary)
                                    }
                                    Text("\(index + 1)日前")
                                        .font(.custom(Font.appMedium, size: proxy.size.width / 48))
                                }
                                Spacer()
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: proxy.size.height / 4.5)
                        .background(Color.appDarkGray)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        // 2, 3, 1, 2, 1
                        HStack {
                            Text("・今すぐ運動する")
                                .font(.custom(Font.appMedium, size: proxy.size.width / 32))
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        .padding(.top)
                        
                        ScrollView {
                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: proxy.size.width / 24) {
                                ForEach(homeVM.trainingInfos, id: \.self) { info in
                                    NavigationLink(destination: TrainingView(trainingInfo: info)) {
                                        VStack {
                                            HStack {
                                                Image(systemName: "dumbbell.fill")
                                                    .resizable()
                                                    .frame(width: proxy.size.width / 24)
                                                    .frame(height: proxy.size.width / 32)
                                                    .foregroundStyle(.appPrimary)
                                                Spacer()
                                                Text(info.isRepetitive ? "反復" : "持続")
                                                    .font(.custom(Font.appMedium, size: proxy.size.width / 36))
                                                    .foregroundStyle(.white)
                                            }
                                            Spacer()
                                            HStack {
                                                Text(info.name)
                                                    .font(.custom(Font.appBold, size: proxy.size.width / 24))
                                                    .minimumScaleFactor(0.001)
                                                Spacer()
                                                Image(systemName: "chevron.right")
                                                    .resizable()
                                                    .frame(width: proxy.size.width / 72)
                                                    .frame(height: proxy.size.width / 36)
                                                    .fontWeight(.bold)
                                            }
                                            .foregroundStyle(.white)
                                            Spacer()
                                            HStack {
                                                Spacer()
                                                Text(info.isDefault ? "デフォルト種目" : "カスタム種目")
                                                    .font(.custom(Font.appRegular, size: proxy.size.width / 48))
                                                    .foregroundStyle(.white)
                                            }
                                        }
                                        .padding()
                                        .frame(width: proxy.size.width / 2.5)
                                        .frame(height: proxy.size.width / 4)
                                        .background(Color.appLightGray)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .offset(y: 4)
                                    }
                                }
                                
                                NavigationLink(destination: AddTrainingView()) {
                                    VStack {
                                        HStack {
                                            Image(systemName: "plus")
                                                .resizable()
                                                .frame(width: proxy.size.width / 24)
                                                .frame(height: proxy.size.width / 24)
                                                .foregroundStyle(.appPrimary)
                                            Spacer()
                                        }
                                        Spacer()
                                        HStack {
                                            Text("カスタム\n種目作成")
                                                .font(.custom(Font.appBold, size: proxy.size.width / 28))
                                                .minimumScaleFactor(0.001)
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .resizable()
                                                .frame(width: proxy.size.width / 72)
                                                .frame(height: proxy.size.width / 36)
                                                .fontWeight(.bold)
                                        }
                                        .foregroundStyle(.white)
                                        Spacer()
                                    }
                                    .padding()
                                    .frame(width: proxy.size.width / 2.5)
                                    .frame(height: proxy.size.width / 4)
                                    .background(Color.appLightGray)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .offset(y: 4)
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
