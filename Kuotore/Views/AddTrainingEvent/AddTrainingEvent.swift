//
//  AddTrainingEvent.swift
//  Kuotore
//
//  Created by 柿崎逸 on 2023/11/27.
//

import SwiftUI

struct AddTrainingEvent: View {
    // MARK: - Property Wrappers
    @StateObject private var bluetoothManager = CentralViewManager()
    @StateObject private var vm = AddTrainingEventViewModel()
    // MARK: - Body
    var body: some View {
        VStack {
            TextField("種目名を入力", text: $vm.name)
                .padding()

            // TODO: - Pickerで反復か持続選択させる？

            Button {

            } label: {
                Text("スタート")
            }
        }
    } // body
} // view

// MARK: - Preview
#Preview {
    AddTrainingEvent()
}
