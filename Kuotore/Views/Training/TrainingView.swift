//
//  TrainingView.swift
//  Kuotore
//
//  Created by 柿崎逸 on 2023/11/29.
//

import SwiftUI

struct TrainingView: View {
    // MARK: - Property Wrappers
    @StateObject private var bluetoothManager = CentralViewManager.shared
    @StateObject private var vm = TrainingViewModel()

    // MARK: - Body
    var body: some View {
        VStack {
            Text("回数: \(vm.trainingCount)")
                .onChangeInteractivelyAvailable(bluetoothManager.distance) { _, newValue in
                    Task {
                        await vm.averageCount(newValue)
                    }
                }
            Button {
                bluetoothManager.stopAction()
            } label: {
                Text("運動を終了する")
            }
        }
    } // body
} // view

// MARK: - Preview
#Preview {
    TrainingView()
}
