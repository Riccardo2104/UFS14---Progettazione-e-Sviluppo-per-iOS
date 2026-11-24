//
//  CreazioneLista.swift
//  Progetto
//
//  Created by s15 on 15/10/26.
//
import SwiftUI
import SwiftData

struct PulsanteCerchio: View {
    let icona: String
    let nome: String
    @Binding var attivo: Bool
    
    var body: some View {
        Button {
            attivo.toggle()
        } label: {
            VStack(spacing: 8) {
                Image(systemName: icona)
                    .font(.title2)
                    .frame(width: 56, height: 56)
                    .foregroundColor(attivo ? .white : .purple)
                    .background(attivo ? Color.purple : Color.clear)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.purple, lineWidth: 2))
                
                Text(nome)
                    .font(.caption)
                    .foregroundColor(attivo ? .purple : .black)
                    .fontWeight(attivo ? .bold : .regular)
            }
        }
        .buttonStyle(.plain)
    }
}


struct CreazioneLista: View {
    @State private var nomeLista = ""
    @State private var scelta: Temperatura? = nil
    @Environment(\.dismiss) private var dismiss // variabile di contesto che usiamo per chiudere la pagina all'interno della vista
    @Environment(\.modelContext) private var modelContext
    
    var onSalvata: () -> Void = {}
    // si può salvare solo con un nome e una temperatura
    private var puoSalvare: Bool {
        !nomeLista.trimmed.isEmpty && scelta != nil
    }
    
    // icone a termometro usate solo in questa pagina
    private func iconaTermometro(_ t: Temperatura) -> String {
        switch t {
        case .ambiente:  return "thermometer.sun"
        case .fresco:    return "thermometer.low"
        case .congelato: return "thermometer.snowflake"
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // HEADER
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                }
                
                Text("Creazione Lista")
                
                Spacer()
                
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.purple.ignoresSafeArea(edges: .top)) // il viola arriva fino in cima allo schermo
            
            // CONTENUTO
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Nome nuova lista:")
                        .foregroundColor(.black)
                    HStack {
                        TextField("", text: $nomeLista)
                        Image(systemName: "arrow.right")
                    }
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Temperatura di Conservazione:")
                        .foregroundColor(.black)
                    
                    // i tre pulsanti occupano ciascuno un terzo della larghezza
                    HStack {
                        ForEach(Temperatura.allCases, id: \.self) { t in
                            PulsanteCerchio(
                                icona: iconaTermometro(t),
                                nome: String(describing: t).capitalized,
                                attivo: Binding(
                                    get: { scelta == t },
                                    set: { _ in scelta = t }
                                )
                            )
                            .frame(maxWidth: .infinity)
                        }
                    }
                    
                    Button(action: {
                        salvaLista()
                        onSalvata()  
                        dismiss()
                    }) {
                        Text("Salva")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    .padding(16)
                    .background(puoSalvare ? Color.purple : Color.purple.opacity(0.4))
                    .cornerRadius(10)
                    .disabled(!puoSalvare)
                }
                
                Spacer()
            }
            .padding() // stesso margine per tutti gli elementi
        }
    }
    
    private func salvaLista() {
        guard let temperatura = scelta else { return }
        let nuova = Lista(nome: nomeLista.trimmed, temperatura: temperatura)
        modelContext.insert(nuova)
    }
}

#Preview {
    CreazioneLista()
        .modelContainer(for: [Lista.self, Alimento.self], inMemory: true)
}
