//
//  AddTrainingView.swift
//  Kuotore
//
//  Created by SeungWoo Hong on 2023/11/30.
//

import SwiftUI

struct AddTrainingView: View {
    
    @State var name = ""
    @State var isRepetitive = true
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                VStack {
                    HStack {
                        Image("logo-primary")
                            .resizable()
                            .frame(width: proxy.size.width / 8)
                            .frame(height: proxy.size.width / 8)
                        Text("新しい種目を登録します")
                            .font(.custom(Font.appBold, size: proxy.size.width / 16))
                            .foregroundStyle(.appPrimary)
                    }
                    Text("登録する種目の情報を入力してください")
                        .font(.custom(Font.appMedium, size: proxy.size.width / 24))
                        .padding(.top)
                    
                    VStack {
                        HStack {
                            Text("種目名")
                                .font(.custom(Font.appMedium, size: proxy.size.width / 28))
                            Spacer()
                        }
                        TextField("", text: $name)
                            .font(.custom(Font.appMedium, size: proxy.size.width / 24))
                            .foregroundStyle(.black)
                            .padding(.vertical, proxy.size.height / 80)
                            .padding(.horizontal)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay {
                                RoundedRectangle(cornerRadius: 12).stroke(.appPrimary, lineWidth: 2)
                            }
                    }
                    .padding(.top)
                    
                    VStack {
                        HStack {
                            Text("タイプ")
                                .font(.custom(Font.appMedium, size: proxy.size.width / 28))
                            Spacer()
                        }
                        HStack {
                            Button(action: {
                                isRepetitive = true
                            }, label: {
                                Text("反復")
                                    .padding(.vertical, proxy.size.height / 80)
                                    .frame(maxWidth: .infinity)
                            })
                            .background(.appLightGray)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay {
                                if isRepetitive {
                                    RoundedRectangle(cornerRadius: 12).stroke(.appPrimary, lineWidth: 2)
                                }
                            }
                            
                            Button(action: {
                                isRepetitive = false
                            }, label: {
                                Text("持続")
                                    .padding(.vertical, proxy.size.height / 80)
                                    .frame(maxWidth: .infinity)
                            })
                            .background(.appLightGray)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay {
                                if !isRepetitive {
                                    RoundedRectangle(cornerRadius: 12).stroke(.appPrimary, lineWidth: 2)
                                }
                            }
                        }
                        .font(.custom(Font.appMedium, size: proxy.size.width / 28))
                        .foregroundStyle(.white)
                    }
                    .padding(.top)
                    
                    NavigationLink(destination: SetTargetDistenceView()) {
                        Text("次へ")
                            .font(.custom(Font.appMedium, size: proxy.size.width / 24))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, proxy.size.height / 80)
                            .background(.appPrimary)
                            .foregroundStyle(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.top, proxy.size.height / 8)
                }
                .padding()
                .toolbar(.hidden)
            }
        }
    }
}

#Preview {
    AddTrainingView()
}
