//
//  TrainingView.swift
//  Kuotore
//
//  Created by SeungWoo Hong on 2023/11/29.
//

import SwiftUI

struct TrainingView: View {
    // MARK: - Property Wrappers
    @StateObject private var bluetoothManager = CentralViewManager.shared
    @StateObject private var vm = TrainingViewModel()
    @State var flag = false
    @State private var countdown: Int = 0
    // MARK: - Properties
    let trainingInfo: TrainingInfo

    // MARK: - Body
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                VStack {
                    if countdown > 0 {
                        Spacer()
                        HStack(alignment: .bottom) {
                            Spacer()
                            Text("\(countdown)")
                                .font(.custom(Font.appBlack, size: proxy.size.width / 4))
                                .foregroundStyle(.appPrimary)
                            Text("秒後")
                                .font(.custom(Font.appBold, size: proxy.size.width / 16))
                                .offset(y: proxy.size.height / -20)
                            Spacer()
                        }
                        Text("\(trainingInfo.name)を始めます")
                            .font(.custom(Font.appBold, size: proxy.size.width / 16))
                        Text("準備してください")
                            .font(.custom(Font.appBold, size: proxy.size.width / 16))
                        Spacer()
                    } else {
                        HStack {
                            Spacer()
                            Image("logo-primary")
                                .resizable()
                                .frame(width: proxy.size.width / 12)
                                .frame(height: proxy.size.width / 12)
                            Text("\(trainingInfo.name)中...")
                                .font(.custom(Font.appBold, size: proxy.size.width / 16))
                            Spacer()
                        }
                        HStack {
                            Text("\(vm.trainingCount)")
                                .font(.custom(Font.appBlack, size: proxy.size.width / 4))
                                .foregroundStyle(.black)
                                .frame(width: proxy.size.width / 3)
                                .frame(height: proxy.size.width / 3)
                                .background(Color.appPrimary)
                                .clipShape(Circle())
                                .padding(.horizontal)
                                .minimumScaleFactor(0.0001)
                                .onChangeInteractivelyAvailable(bluetoothManager.distance) { _, newValue in
                                    Task {
                                        await vm.averageCount(newValue)
                                    }
                                }

                            Text("回")
                                .font(.custom(Font.appBlack, size: proxy.size.width / 8))
                        }
                        .padding(.top)
                        
//                        HStack {
////                            RoundedRectangle(cornerRadius: 12)
////                                .frame(width: proxy.size.width / 2)
////                                .frame(height: proxy.size.height / 48)
////                                .offset(x: proxy.size.width / 12)
////                                .
////                                .rotationEffect(.degrees(-20))
//                            Spacer()
////                            Text("\(trainingInfo.name)の最高記録")
//                            VStack(alignment: .trailing) {
//                                Text("最高記録")
//                                    .font(.custom(Font.appBold, size: proxy.size.width / 20))
//                                    .padding(.trailing, proxy.size.width / 6)
//                                Text("34回")
//                                    .font(.custom(Font.appBold, size: proxy.size.width / 20))
//                                    .padding(.trailing, proxy.size.width / 6)
//                            }
//                        }
//                        
//                        HStack {
//                            Text("予想消費カロリー")
//                            Spacer()
//                            Text("46kcal")
//                        }
//                        .font(.custom(Font.appBold, size: proxy.size.width / 20))
//                        .padding(.top)
                        
                        HStack {
                            VStack {
                                Text("予想消費カロリー")
                                    .font(.custom(Font.appBold, size: proxy.size.width / 24))
                                HStack(alignment: .bottom) {
                                    Text("177")
                                        .font(.custom(Font.appBlack, size: proxy.size.width / 16))
                                    Text("kcal")
                                        .font(.custom(Font.appBold, size: proxy.size.width / 24))
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical)
                            .background(Color.appDarkGray)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            VStack {
                                Text("最高記録")
                                    .font(.custom(Font.appBold, size: proxy.size.width / 24))
                                HStack(alignment: .bottom) {
                                    Text("34")
                                        .font(.custom(Font.appBlack, size: proxy.size.width / 16))
                                    Text("回")
                                        .font(.custom(Font.appBold, size: proxy.size.width / 24))
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical)
                            .background(Color.appDarkGray)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
//                        .padding(.top, proxy.size.height / 240)
                        
                        ScrollView {
                            Button(action: {}, label: {
                                Text("やり直す")
                                    .font(.custom(Font.appBold, size: proxy.size.width / 24))
                                    .foregroundStyle(.black)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, proxy.size.height / 60)
                                    .background(Color.appPrimary)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            })
                            .padding(.top)

                            Button {
                                bluetoothManager.stopAction()
                            } label: {
                                Text("トレーニングを終わる")
                                    .font(.custom(Font.appBold, size: proxy.size.width / 24))
                                    .foregroundStyle(.black)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, proxy.size.height / 60)
                                    .background(Color.appPrimary)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            }.padding(.vertical)
                            
                            Button {} label: {
                                Text("ホームに戻る")
                                    .font(.custom(Font.appBold, size: proxy.size.width / 24))
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, proxy.size.height / 60)
                                    .background(Color.red)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            }.padding(.top)
                            HStack {
                                Spacer()
                                Text("* 記録されません")
                                    .font(.custom(Font.appBold, size: proxy.size.width / 32))
                                    .foregroundStyle(.red)
                            }
                        }
                        .padding(.top)
                        Spacer()
                    }
                }
                .padding()
            }
            .onAppear {
                if !trainingInfo.isExecuted {
                    flag.toggle()
                } else {
                    let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                        if self.countdown > 0 {
                            self.countdown -= 1
                        } else {
                            timer.invalidate()
                        }
                    }
                    RunLoop.main.add(timer, forMode: .common)
                }
            }
            .fullScreenCover(isPresented: $flag, onDismiss: {
                RealmManager.setExecutedStatus(training: trainingInfo)
            }, content: {
                InitializeTrainingView(trainingInfo: trainingInfo)
            })
            .toolbar(.hidden)
        }
    }
}

#Preview {
    TrainingView(trainingInfo: TrainingInfo())
}
