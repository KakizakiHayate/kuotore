//
//  AddTrainingEvent.swift
//  Kuotore
//
//  Created by 柿崎逸 on 2023/11/27.
//

import SwiftUI

struct AddTrainingEventView: View {
    // MARK: - Property Wrappers
    @StateObject private var bluetoothManager = CentralViewManager.shared
    @StateObject private var vm = AddTrainingEventViewModel()
    
    // MARK: - Body
    var body: some View {
        VStack {
            TextField("種目名を入力", text: $vm.name)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            // TODO: - Pickerで反復か持続選択させる？

            Button {
                vm.startReserveCountdown(bluetoothManager)
            } label: {
                Text("スタート")
            }
            Text("カウントダウン：\(vm.preparationTime)")
            Text("距離：\(bluetoothManager.distance ?? 0)")
                .onChangeInteractivelyAvailable(bluetoothManager.distance ?? -1) {
                    vm.distances.append($1)
                }
            Button {
                bluetoothManager.stopAction()
            } label: {
                Text("キャンセル")
            }
        }
    } // body
} // view

// MARK: - Preview
#Preview {
    AddTrainingEventView()
}
