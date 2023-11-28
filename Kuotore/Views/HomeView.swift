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
                            ForEach(eTrainingTimes, id: \.self) { time in
                                Spacer()
                                VStack {
                                    ZStack(alignment: .bottom) {
                                        RoundedRectangle(cornerRadius: 12)
                                            .frame(width: proxy.size.width / 32,
                                                   height: proxy.size.height / 8)
                                            .foregroundStyle(Color.appLightGray)
                                        RoundedRectangle(cornerRadius: 12)
                                            .frame(width: proxy.size.width / 32,
                                                   height: (proxy.size.height / 8) * time / 12)
                                            .foregroundStyle(Color.appPrimary)
                                    }
                                    Text("1日前")
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
