import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Lista.nome) private var liste: [Lista]
    
    @State private var mostraCreaLista = false
    @State private var mostraAggiungi = false
    @State private var mostraSnackbar = false
    // modalità eliminazione liste (pulsante "Elimina liste" / "Fatto")
    @State private var modalitaElimina = false
    // lista in attesa di conferma per l'eliminazione
    @State private var listaDaEliminare: Lista?
    
    // prima le liste fisse nell'ordine di sempre, poi quelle create dall'utente
    private var numeroListeCustom: Int {
        liste.filter { !$0.predefinita }.count
    }
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
                HStack {
                    Text("FrigoNutrient")
                        .font(.title)
                    Spacer()
                    if numeroListeCustom > 0 {
                        Button(action: {
                            withAnimation { modalitaElimina.toggle() }
                        }) {
                            Text(modalitaElimina ? "Fatto" : "Elimina liste")
                                .font(.caption)
                                .foregroundColor(Color.purple)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                                .cornerRadius(10)
                            .border(Color.purple)                        }
                    }
                    
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
                
                ScrollView {
                    VStack(spacing: 2) {
                        ForEach(listeOrdinate) { lista in
                            SezioneLista(
                                lista: lista,
                                modalitaElimina: modalitaElimina,
                                onEliminaLista: {
                                    listaDaEliminare = lista
                                },
                                onElimina: { alimento in
                                    modelContext.delete(alimento)
                                    try? modelContext.save()
                                }
                            )
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
            .fullScreenCover(isPresented: $mostraCreaLista) {
                CreazioneLista(onSalvata: { mostraSnackbar = true })
            }
            .snackbar("Lista creata", isPresented: $mostraSnackbar, distanzaDalBasso: 90)
            .fullScreenCover(isPresented: $mostraAggiungi) {
                NavigationStack {
                    AggiungiAlimenti()
                }
            }
            .confirmationDialog(
                "Eliminare la lista?",
                isPresented: Binding(
                    get: { listaDaEliminare != nil },
                    set: { if !$0 { listaDaEliminare = nil } }
                ),
                titleVisibility: .visible,
                presenting: listaDaEliminare
            ){ lista in
                Button("Elimina \"\(lista.nome)\"", role: .destructive) {
                    withAnimation {
                        modelContext.delete(lista)
                        try? modelContext.save()
                    }
                    listaDaEliminare = nil
                }
                Button("Annulla", role: .cancel) {
                    listaDaEliminare = nil
                }
            } message: { lista in
                if lista.alimenti.isEmpty {
                    Text("Questa azione non può essere annullata.")
                } else {
                    Text("Verranno eliminati anche i \(lista.alimenti.count) alimenti al suo interno. Questa azione non può essere annullata.")
                }
            }
            .onChange(of: numeroListeCustom) {
                if numeroListeCustom == 0 {
                    withAnimation { modalitaElimina = false }
                }
            }
        }
    }
    
    struct SezioneLista: View {
        let lista: Lista
        let modalitaElimina: Bool
        let onEliminaLista: () -> Void
        let onElimina: (Alimento) -> Void
        
        @State private var aperta = false
        
        let colonne = [GridItem(.flexible()), GridItem(.flexible())]
        
        var body: some View {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    // il meno compare solo sulle liste non predefinite
                    if modalitaElimina && !lista.predefinita {
                        Button(action: onEliminaLista) {
                            Image(systemName: "minus.circle.fill")
                                .font(.title2)
                                .foregroundColor(.red)
                        }
                        .padding(.leading)
                        .transition(.move(edge: .leading).combined(with: .opacity))
                    }
                    
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
                    }
                }
                .background(Color(.systemGray5))
                
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
                    NavigationLink(destination: ValoriNutrizionali(alimento: alimento)) {
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
