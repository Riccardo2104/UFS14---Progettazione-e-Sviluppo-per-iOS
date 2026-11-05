//
//  ValoriNutrizionali.swift
//  Progetto
//

import SwiftUI

struct ValoriNutrizionali: View {
   
    @Environment(\.dismiss) private var dismiss
    
    @State private var quantita: String = "100"
    @State private var grassi: String = ""
    @State private var proteine: String = ""
    @State private var fibre: String = ""
    
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text("Nome alimento")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .opacity(0)
            }
            .padding()
            .frame(height: 60)
            .background(Color(uiColor: .systemPurple))
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Valori nutrizionali")
                                .font(.title2)
                                .bold()
                            HStack {
                                TextField("100", text: $quantita)
                                    .padding(10)
                                    .frame(width: 180)
                                    .background(Color(uiColor: .systemGray5))
                                    .cornerRadius(4)
                                Text("g")
                                    .font(.caption)
                            }
                        }
                        
                        Spacer()
                        
                    }
                    .padding(.top, 10)
                    
                    VStack(spacing: 12) {
                        HStack {
                            Text("Grassi:")
                                .frame(width: 90, alignment: .leading)
                            TextField("", text: $grassi)
                                .padding(8)
                                .background(Color(uiColor: .systemGray5))
                                .cornerRadius(4)
                            Text("g").font(.caption)
                        }
                        
                        HStack {
                            Text("Proteine:")
                                .frame(width: 90, alignment: .leading)
                            TextField("", text: $proteine)
                                .padding(8)
                                .background(Color(uiColor: .systemGray5))
                                .cornerRadius(4)
                            Text("g").font(.caption)
                        }
                        
                        HStack {
                            Text("Fibre:")
                                .frame(width: 90, alignment: .leading)
                            TextField("", text: $fibre)
                                .padding(8)
                                .background(Color(uiColor: .systemGray3).opacity(0.2)) // Solo etichetta o campo vuoto
                                .cornerRadius(4)
                            Text("g").font(.caption)
                        }
                    }
                    
                    // Data di Scadenza
                    
                    
                    
                }
                .padding()
            }
        }
       
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        ValoriNutrizionali()
    }
}
