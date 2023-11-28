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
                                    .font(.custom(Font.appBlack, size: 24))
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
