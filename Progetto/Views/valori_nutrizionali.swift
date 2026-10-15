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
    @State private var dataScadenza: Date = Date()
    
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
                            
                            TextField("100", text: $quantita)
                                .padding(10)
                                .frame(width: 180)
                                .background(Color(uiColor: .systemGray5))
                                .cornerRadius(4)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                           
                        }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 36, weight: .light))
                                .foregroundColor(.black)
                        }
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
                        }
                        
                        HStack {
                            Text("Proteine:")
                                .frame(width: 90, alignment: .leading)
                            TextField("", text: $proteine)
                                .padding(8)
                                .background(Color(uiColor: .systemGray5))
                                .cornerRadius(4)
                        }
                        
                        HStack {
                            Text("Fibre:")
                                .frame(width: 90, alignment: .leading)
                            TextField("", text: $fibre)
                                .padding(8)
                                .background(Color(uiColor: .systemGray3).opacity(0.2)) // Solo etichetta o campo vuoto
                                .cornerRadius(4)
                        }
                    }
                    
                    // Data di Scadenza
                    HStack {
                        Text("Data Scadenza:")
                            .font(.title3)
                            .bold()
                        
                        Spacer()
        
                        DatePicker("", selection: $dataScadenza, displayedComponents: .date)
                            .labelsHidden()
                    }
                    
                    VStack(spacing: 12) {
                        Image("orco_cervello")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 120)
                            .cornerRadius(4)
                        
                        Text("Nome")
                            .font(.headline)
                            .bold()
                        
                        HStack {
                            Image(systemName: "info.circle")
                            Spacer()
                            Image(systemName: "info.circle")
                        }
                        .font(.title3)
                        .padding(.horizontal, 10)
                    }
                    .padding()
                    .frame(width: 160)
                    .background(Color(uiColor: .systemGray4))
                    .cornerRadius(4)

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
