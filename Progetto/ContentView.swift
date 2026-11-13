//
//  ContentView.swift
//  Progetto
//
//  Created by d9 on 12/10/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        HomeView()
            .onAppear {
                creaListePredefinite()
            }
    }
    
    // al primo avvio il database è vuoto: creiamo le 4 liste fisse
    private func creaListePredefinite() {
        let richiesta = FetchDescriptor<Lista>(predicate: #Predicate { $0.predefinita })
        let quante = (try? modelContext.fetchCount(richiesta)) ?? 0
        guard quante == 0 else { return }
        
        modelContext.insert(Lista(nome: "Frigorifero", temperatura: .fresco, predefinita: true))
        modelContext.insert(Lista(nome: "Congelatore", temperatura: .congelato, predefinita: true))
        modelContext.insert(Lista(nome: "Freezer", temperatura: .congelato, predefinita: true))
        modelContext.insert(Lista(nome: "Dispensa", temperatura: .ambiente, predefinita: true))
        try? modelContext.save()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Lista.self, Alimento.self])
}
