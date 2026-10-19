
import SwiftUI

struct ConfermaAggiuntaView: View {
    @Environment(\.dismiss) private var dismiss
    
    let nomeAlimento: String
    let opzioniLista: [ElementoLista]
    
    var onContinuare: () -> Void
    var onNo: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                Spacer()
                Text("Aggiungi alimenti")
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
                    
                   
                    VStack(alignment: .leading, spacing: 24) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Nome Alimento:")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.gray)
                            Text(nomeAlimento)
                                .padding(12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color .gray)
                                .cornerRadius(8)
                                .foregroundColor(.gray)
                        }
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Lista:")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.gray)
                            ForEach(opzioniLista) { elemento in
                                HStack(spacing: 12) {
                                    Image(systemName: elemento.selezionato ? "checkmark.square.fill" : "square")
                                        .foregroundColor(.gray)
                                    Text(elemento.nome)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .disabled(true)
                    VStack(spacing: 16) {
                        Text("Continuare ?")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.primary)
                        
                        Text("premere continuare se vuoi aggiungere altri alimenti")
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                        
                        HStack(spacing: 20) {
                            Button(action: {
                                onNo()
                            }) {
                                Text("No")
                                    .font(.headline)
                                    .bold()
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 48)
                                    .background(Color.purple)
                                    .cornerRadius(10)
                            }
                            
                            Button(action: {
                                onContinuare()
                                dismiss()
                            }) {
                                Text("Continuare")
                                    .font(.headline)
                                    .bold()
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 48)
                                    .background(Color.purple)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.top, 8)
                    }
                    .padding(.vertical, 24)
                    .padding(.horizontal, 16)
                    .background(Color .gray)
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color .gray, lineWidth: 1))
                }
                .padding()
            }
            
            Button(action: {}) {
                Text("Aggiungi Elemento")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.purple.opacity(0.4))
                    .cornerRadius(12)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 20)
            }
            .disabled(true)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        AggiungiAlimenti()
    }
}
