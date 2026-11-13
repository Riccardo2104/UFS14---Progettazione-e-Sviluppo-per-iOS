//
//  ConfermoAlimento.swift
//  Progetto
//
//  Created by s15 on 05/11/26.
//
import SwiftUI
import SwiftData

struct ConfermoAlimento: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    // lo stesso servizio della pagina Aggiungi: qui leggiamo la risposta
    @ObservedObject var api: ApiProdotto
    let barcode: String
    let scadenza: Date
    var lista: Lista? = nil
    var onSalvato: () -> Void = {}
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                Spacer()
                Text("Conferma prodotto")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .opacity(0)
            }
            .padding()
            .frame(height: 60)
            .background(Color.purple.ignoresSafeArea(edges: .top))
            Spacer()
            
            if api.staCaricando {
                ProgressView("Cerco il prodotto…")
                
            } else if let prodotto = api.prodotto {
                VStack(spacing: 16) {
                    Text("È questo il tuo prodotto?")
                        .font(.title2)
                        .bold()
                    
                    ImmagineProdotto(url: prodotto.imageFrontSmallUrl, altezza: 220)
                        .padding(.horizontal, 40)
                    
                    Text(prodotto.productName ?? "Senza nome")
                        .font(.title3)
                        .bold()
                        .multilineTextAlignment(.center)
                    
                    if let kcal = prodotto.nutriments?.calories {
                        Text("\(Int(kcal)) kcal per 100 g")
                            .foregroundColor(.secondary)
                    } else {
                        Text("Calorie non disponibili")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            salva(prodotto)
                            onSalvato()
                            dismiss()
                        }) {
                            Text("Sì")
                                .font(.title2)
                                .foregroundColor(.white)
                                .frame(width: 100, height: 50)
                                .background(Color.purple)
                                .cornerRadius(12)
                        }
                        Button(action: { dismiss() }) {
                            Text("No")
                                .font(.title2)
                                .foregroundColor(.white)
                                .frame(width: 100, height: 50)
                                .background(Color.purple)
                                .cornerRadius(12)
                        }
                    }
                }
                .padding()
                

            } else {
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundColor(.purple)
                    Text(api.errore ?? "Prodotto non trovato")
                        .font(.title3)
                    Text("Controlla il barcode e riprova")
                        .foregroundColor(.secondary)
                    Button(action: { dismiss() }) {
                        Text("Torna indietro")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 180, height: 50)
                            .background(Color.purple)
                            .cornerRadius(12)
                    }
                }
                .padding()
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar) 
    }
    
    // trasforma la risposta dell'API in un Alimento e lo salva nel database
    private func salva(_ prodotto: Product) {
        let nuovo = Alimento(
            barcode: barcode,
            nome: prodotto.productName ?? "Senza nome",
            immagineURL: prodotto.imageFrontSmallUrl,
            kcal100g: prodotto.nutriments?.calories,
            grassi100g: prodotto.nutriments?.fat,
            proteine100g: prodotto.nutriments?.proteins,
            fibre100g: prodotto.nutriments?.fiber,
            grammi: prodotto.servingQuantity ?? 100,
            scadenza: scadenza
        )
        modelContext.insert(nuovo)
        // dopo l'insert lo colleghiamo alla lista: SwiftData aggiorna anche lista.alimenti
        nuovo.lista = lista
        try? modelContext.save()

    }
}

#Preview {
    let api = ApiProdotto()
    NavigationStack {
        ConfermoAlimento(api: api, barcode: "8012666041459", scadenza: Date())
    }
    .modelContainer(for: [Lista.self, Alimento.self], inMemory: true)
    .onAppear {
        api.cerca(barcode: "8012666041459")
    }
}
