//
//  ContentView.swift
//  Kuotore
//
//  Created by 柿崎逸 on 2023/11/15.
//

import SwiftUI

// TODO: View名は、適宜変更する
struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: CentralView()) {
                    Text("Central")
                }
                .buttonStyle(.borderedProminent)
                .padding()

                NavigationLink(destination: PeripheralView()) {
                    Text("Peripharal")
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}

struct CentralView: View {
    @StateObject var central = CentralViewManager.shared

    var body: some View {

        Text(central.message)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(20)
        .onDisappear {
        central.stopAction()
        }
    }
}

struct PeripheralView: View {
    @StateObject var peripheral: PeripheralViewModel = PeripheralViewModel()

    var body: some View {

        VStack {
            TextEditor(text: $peripheral.message)
                .padding(20)

            Toggle("Advertising", isOn: $peripheral.toggleFrag)
                .padding(20)
                .onChange(of: peripheral.toggleFrag) { _ in
                    peripheral.switchChanged()
                }
        }
    .onDisappear {
        peripheral.stopAction()
        }
    }
}
