//
//  HomeView.swift
//  Kuotore
//
//  Created by SeungWoo Hong on 2023/11/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            Text("Hello world")
                .font(.custom(Font.bizBold, size: 24))
        }
    }
}

#Preview {
    HomeView()
}
