import SwiftUI

// dati di prova, poi li sostituiamo con i modelli veri
struct AlimentoFinto: Identifiable {
    let id = UUID()
    var nome: String
    var kcal100g: Double?
    var immagine: String = "placeholder"
}

struct ListaFinta: Identifiable {
    let id = UUID()
    var nome: String
    var alimenti: [AlimentoFinto]
    
    static let esempi: [ListaFinta] = [
        ListaFinta(nome: "Frigorifero", alimenti: [
            AlimentoFinto(nome: "Latte", kcal100g: 64),
            AlimentoFinto(nome: "Yogurt", kcal100g: 84)
        ]),
        ListaFinta(nome: "Congelatore", alimenti: [
            AlimentoFinto(nome: "Piselli", kcal100g: 81)
        ]),
        ListaFinta(nome: "Freezer", alimenti: []),
        ListaFinta(nome: "Dispensa", alimenti: [
            AlimentoFinto(nome: "Pasta", kcal100g: 359),
            AlimentoFinto(nome: "Biscotti")
        ]),
        ListaFinta(nome: "Lista Custom", alimenti: [
            AlimentoFinto(nome: "Alimento", kcal100g: 120)
        ])
    ]
}

struct HomeView: View {
    @State private var liste = ListaFinta.esempi
    @State private var mostraCreaLista = false
    @State private var mostraAggiungi = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 2) {
                        ForEach(liste) { lista in
                            SezioneLista(lista: lista, onElimina: { alimento in
                                elimina(alimento, da: lista)
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
                AggiungiAlimenti()
            }
        }
    }
    
    func elimina(_ alimento: AlimentoFinto, da lista: ListaFinta) {
        if let i = liste.firstIndex(where: { $0.id == lista.id }) {
            liste[i].alimenti.removeAll { $0.id == alimento.id }
        }
    }
}

struct SezioneLista: View {
    let lista: ListaFinta
    let onElimina: (AlimentoFinto) -> Void
    
    @State private var aperta = false
    
    let colonne = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack(spacing: 0) {
            Button {
                aperta.toggle()
            } label: {
                HStack {
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
    let alimento: AlimentoFinto
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
            
            Image(alimento.immagine)
                .resizable()
                .scaledToFit()
                .frame(height: 100)
            
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
    HomeView()
}
