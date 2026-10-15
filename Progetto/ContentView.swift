//
//  ContentView.swift
//  Progetto
//
//  Created by d9 on 12/10/26.
//

import SwiftUI
import SwiftData



struct ContentView: View {
   

    var body: some View {
            HomeView()

    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
