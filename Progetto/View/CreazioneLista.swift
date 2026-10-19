//
//  CreazioneLista.swift
//  Progetto
//
//  Created by s15 on 15/10/26.
//
import SwiftUI

struct PulsanteCerchio: View {
    let icona: String
    @Binding var attivo: Bool

    var body: some View {
        Button {
            attivo.toggle()
        } label: {
            Image(systemName: icona)
                .font(.title2)
                .frame(width: 56, height: 56)
                .foregroundColor(attivo ? .white : .purple)
                .background(attivo ? Color.purple : Color.clear)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.purple, lineWidth: 2))
        }
        .buttonStyle(.plain)
    }
}


struct CreazioneLista: View {
    @State private var nomeLista = ""
    @State private var scelta: Temperatura? = nil
    @Environment(\.dismiss) private var dismiss // variabile di contesto che usiamo per chiudere la pagina all'interno della vista

    var body: some View {
        VStack(spacing: 0) {
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
            .background(Color.purple)
            
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
                    Text("Temperatura:")
                        .foregroundColor(.black)
                    HStack(spacing: 90) {
                        ForEach(Temperatura.allCases, id: \.self) { t in
                            PulsanteCerchio(
                                icona: t.icona,
                                attivo: Binding(
                                    get: { scelta == t },
                                    set: { _ in scelta = t }
                                )
                            )
                        }
                    }
                    HStack(alignment: VerticalAlignment.bottom, spacing:100) {
                        Button (action:{}){ //Da implementare
                            Text("Salva")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        .padding(16)
                        .background(Color.purple)
                        .cornerRadius(10)
                    }
                }
                .padding()
                
                Spacer()
            }
        }
    }
}
#Preview {
    CreazioneLista()
}
