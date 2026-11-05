import SwiftUI

struct AggiungiAlimenti: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var barcode: String = ""
    @State private var dataScadenza: Date = Date()
    @State private var opzioniLista: [ElementoLista] = [
        ElementoLista(nome: "Lista 1", selezionato: true),
        ElementoLista(nome: "Lista 2", selezionato: false)
    ]
    
    @State private var mostraConferma: Bool = false

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
                        Text("Nome Alimento:")
                            .font(.title3)
                            .bold()

                        TextField("Es. Mela", text: $barcode)
                            .padding(12)
                            .background(Color .purple)
                            .cornerRadius(8)
                            .foregroundColor(.white) //sistemare il fatto che il placeholder text è scuro
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Lista:")
                            .font(.title3)
                            .bold()
                        
                        ForEach($opzioniLista) { $elemento in
                            Button(action: {
                                elemento.selezionato.toggle()
                            }) {
                                HStack(spacing: 12) {
                                    Image(systemName: elemento.selezionato ? "checkmark.square.fill" : "square")
                                        .foregroundColor(.purple)
                                    Text(elemento.nome)
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
            NavigationStack {
                Button(action: {
                    mostraConferma = true
                    salvaElemento()
                    
                }) {
                    Text("Aggiungi Elemento")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(barcode.trimmed.isEmpty ? Color.purple.opacity(0.4) : Color.purple)
                        .cornerRadius(12)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 20)
                }
            }.navigationDestination(isPresented: $mostraConferma){
                ConfermoAlimento()
            }
            
            .disabled(barcode.trimmed.isEmpty)
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $mostraConferma) {
            ConfermaAggiuntaView(
                nomeAlimento: barcode,
                opzioniLista: opzioniLista,
                onContinuare: {
                    salvaElemento()
                    resetForm()
                },
                onNo: {
                    salvaElemento()
                    dismiss()
                }
            )
        }
    }
    
    private func salvaElemento() {
        print("Salvataggio nel DB: \(barcode)")
        
    }
    
    private func resetForm() {
        barcode = ""
        for i in opzioniLista.indices {
            opzioniLista[i].selezionato = false
        }
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
}
