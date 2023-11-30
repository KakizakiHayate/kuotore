//
//  SetTargetDistenceView.swift
//  Kuotore
//
//  Created by SeungWoo Hong on 2023/11/30.
//

import SwiftUI

struct SetTargetDistenceView: View {
    
    @State var isSet = false
    @State var isSettingStart = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                VStack {
                    HStack {
                        Image("logo-primary")
                            .resizable()
                            .frame(width: proxy.size.width / 8)
                            .frame(height: proxy.size.width / 8)
                        Text("距離を設定します")
                            .font(.custom(Font.appBold, size: proxy.size.width / 16))
                            .foregroundStyle(.appPrimary)
                    }
                    .frame(maxWidth: .infinity)
                    Text("距離を測りたい場所にセンサーを置いて\n音が鳴るまで耐えてください")
                        .font(.custom(Font.appMedium, size: proxy.size.width / 24))
                        .padding(.top)
                        .multilineTextAlignment(.center)
                    
                    Group {
                        if isSet && isSettingStart {
                            Text("測定完了")
                        } else if !isSet && isSettingStart {
                            Text("測定中")
                        }
                    }
                    .font(.custom(Font.appBlack, size: proxy.size.width / 12))
                    .padding(.top, proxy.size.height / 8)
                    
                    if isSet {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Text("登録")
                                .font(.custom(Font.appMedium, size: proxy.size.width / 24))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, proxy.size.height / 80)
                                .background(.appPrimary)
                                .foregroundStyle(.black)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        })
                        .padding(.top, proxy.size.height / 8)
                    } else if !isSet && !isSettingStart {
                        Button(action: {
                            withAnimation {
                                isSettingStart = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                isSet = true
                            }
                        }, label: {
                            Text("測定開始")
                                .font(.custom(Font.appMedium, size: proxy.size.width / 24))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, proxy.size.height / 80)
                                .background(.appPrimary)
                                .foregroundStyle(.black)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        })
                        .padding(.top, proxy.size.height / 8)
                    } else {
                        Button(action: {
                            withAnimation {
                                isSettingStart = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                isSet = true
                            }
                        }, label: {
                            Text("距離を測っています...")
                                .font(.custom(Font.appMedium, size: proxy.size.width / 24))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, proxy.size.height / 80)
                                .background(.appDarkGray)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        })
                        .padding(.top, proxy.size.height / 8)
                    }
                }
                .padding()
                .toolbar(.hidden)
            }
        }
    }
}

#Preview {
    SetTargetDistenceView()
}
