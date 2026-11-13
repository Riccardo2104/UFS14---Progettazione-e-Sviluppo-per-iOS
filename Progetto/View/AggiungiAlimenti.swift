import SwiftUI
import SwiftData

struct AggiungiAlimenti: View {
    @Environment(\.dismiss) private var dismiss
    @State private var barcode: String = ""
    @State private var dataScadenza: Date = Date()
    // le liste vere salvate nel database, e quella scelta dall'utente
    @Query(sort: \Lista.nome) private var liste: [Lista]
    @State private var listaScelta: Lista?
    
    @State private var mostraConferma: Bool = false
    @StateObject private var api = ApiProdotto()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                Spacer()
                Text("Aggiungi Barcode")
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
            .background(Color.purple)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Barcode:")
                            .font(.title3)
                            .bold()
                        
                        TextField("Es. 8012666041459", text: $barcode)
                            .keyboardType(.numberPad)
                            .padding(12)
                            .background(Color.purple)
                            .cornerRadius(8)
                            .foregroundColor(.white) // sistemare il fatto che il placeholder è scuro
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Lista:")
                            .font(.title3)
                            .bold()
                        
                        // un alimento sta in una lista sola: toccandone una si seleziona quella
                        ForEach(liste) { lista in
                            Button(action: {
                                listaScelta = lista
                            }) {
                                HStack(spacing: 12) {
                                    Image(systemName: listaScelta == lista ? "checkmark.square.fill" : "square")
                                        .foregroundColor(.purple)
                                    Image(systemName: lista.temperatura.icona)
                                        .foregroundColor(.secondary)
                                    Text(lista.nome)
                                        .foregroundColor(.primary)
                                }
                            }
                        }
                    }
                    
                    HStack {
                        Text("Data Scadenza:")
                            .font(.title3)
                            .bold()
                        
                        Spacer()
                        
                        DatePicker("", selection: $dataScadenza, displayedComponents: .date)
                            .labelsHidden()
                    }
                }
                .padding()
            }
            
            // parte la ricerca e intanto apriamo la pagina di conferma,
            // che mostra la rotella finché l'API non risponde
            Button(action: {
                api.cerca(barcode: barcode.trimmed)
                mostraConferma = true
            }) {
                Text("Cerca prodotto")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(barcode.trimmed.isEmpty || listaScelta == nil ? Color.purple.opacity(0.4) : Color.purple)
                    .cornerRadius(12)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 20)
            }
            .disabled(barcode.trimmed.isEmpty || listaScelta == nil)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            // di default la prima lista, così l'utente non deve sceglierla ogni volta
            if listaScelta == nil {
                listaScelta = liste.first
            }
        }
        .navigationDestination(isPresented: $mostraConferma) {
            ConfermoAlimento(
                api: api,
                barcode: barcode.trimmed,
                scadenza: dataScadenza,
                lista: listaScelta,
                onSalvato: {
                    resetForm()
                }
            )
        }
    }
    
    private func resetForm() {
        barcode = ""
        dataScadenza = Date()
        // la lista scelta la teniamo: di solito si aggiungono più cose nello stesso posto
    }
}

extension String {
    var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

#Preview {
    NavigationStack {
        AggiungiAlimenti()
    }
    .modelContainer(for: [Lista.self, Alimento.self], inMemory: true)
}
