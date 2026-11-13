import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Lista.nome) private var liste: [Lista]
    
    @State private var mostraCreaLista = false
    @State private var mostraAggiungi = false
    
    // prima le liste fisse nell'ordine di sempre, poi quelle create dall'utente
    private var listeOrdinate: [Lista] {
        let ordine = ["Frigorifero", "Congelatore", "Freezer", "Dispensa"]
        let fisse = liste
            .filter { $0.predefinita }
            .sorted { (ordine.firstIndex(of: $0.nome) ?? 99) < (ordine.firstIndex(of: $1.nome) ?? 99) }
        let custom = liste.filter { !$0.predefinita }
        return fisse + custom
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 2) {
                        ForEach(listeOrdinate) { lista in
                            SezioneLista(lista: lista, onElimina: { alimento in
                                modelContext.delete(alimento)
                                try? modelContext.save()

                            })
                        }
                    }
                }
                
                HStack(spacing: 12) {
                    PulsanteViola(titolo: "Crea lista Custom") {
                        mostraCreaLista = true
                    }
                    PulsanteViola(titolo: "Aggiungi alimenti") {
                        mostraAggiungi = true
                    }
                }
                .padding()
            }
            .navigationTitle("FrigoNutrient")
            .sheet(isPresented: $mostraCreaLista) {
                CreazioneLista()
            }
            .sheet(isPresented: $mostraAggiungi) {
                NavigationStack {
                    AggiungiAlimenti()
                }
            }
        }
    }
}

struct SezioneLista: View {
    let lista: Lista
    let onElimina: (Alimento) -> Void
    
    @State private var aperta = false
    
    let colonne = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack(spacing: 0) {
            Button {
                aperta.toggle()
            } label: {
                HStack {
                    Image(systemName: lista.temperatura.icona)
                    Text(lista.nome)
                    Spacer()
                    Image(systemName: aperta ? "arrow.up" : "arrow.down")
                        .font(.title2)
                }
                .foregroundColor(.primary)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray5))
            }
            
            if aperta {
                if lista.alimenti.isEmpty {
                    Text("Nessun alimento")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    LazyVGrid(columns: colonne, spacing: 12) {
                        ForEach(lista.alimenti) { alimento in
                            CardAlimento(alimento: alimento, onElimina: {
                                onElimina(alimento)
                            })
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct CardAlimento: View {
    let alimento: Alimento
    let onElimina: () -> Void
    
    @State private var selezionato = false
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Button {
                    selezionato.toggle()
                } label: {
                    Image(systemName: selezionato ? "checkmark.square.fill" : "square")
                        .font(.title2)
                }
                Spacer()
            }
            
            ImmagineProdotto(url: alimento.immagineURL)
            
            Text(alimento.nome)
                .font(.headline)
                .lineLimit(1)
            
            HStack {
                NavigationLink(destination: ValoriNutrizionali()) {
                    Image(systemName: "info.circle")
                        .font(.title2)
                }
                Spacer()
                Button(action: onElimina) {
                    Image(systemName: "trash")
                        .font(.title2)
                }
            }
        }
        .buttonStyle(.plain)
        .foregroundColor(.primary)
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray5))
        .cornerRadius(8)
    }
}

struct PulsanteViola: View {
    let titolo: String
    let azione: () -> Void
    
    var body: some View {
        Button(action: azione) {
            Text(titolo)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.purple)
                .cornerRadius(12)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Lista.self, Alimento.self], inMemory: true)
}
