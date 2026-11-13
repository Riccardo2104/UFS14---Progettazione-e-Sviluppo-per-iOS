//
//  ValoriNutrizionali.swift
//  Progetto
//
import Foundation
import SwiftUI

struct ValoriNutrizionali: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var quantita: Double = 100
    @State private var grassi: Double = 15
    @State private var proteine: Double = 15
    @State private var fibre: Double = 16
    @State private var grassi100g : Double = 12
    @State private var proteine100g: Double = 15
    @State private var fibre100g: Double = 16
    
    func calcoloValoriNutrizionali(_ valore :Double) -> Double {
        (valore / 100) * quantita
    }
    func calcoloValori () {
        grassi = calcoloValoriNutrizionali(grassi100g)
        proteine = calcoloValoriNutrizionali(proteine100g)
        fibre = calcoloValoriNutrizionali(fibre100g)
    }
    
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
                                TextField("100", value: $quantita , format: .number)
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
                            TextField("", value: $grassi, format: .number)
                                .padding(8)
                                .background(Color(uiColor: .systemGray5))
                                .cornerRadius(4)
                            Text("g").font(.caption)
                        }
                        
                        HStack {
                            Text("Proteine:")
                                .frame(width: 90, alignment: .leading)
                            TextField("", value: $proteine, format: .number)
                                .padding(8)
                                .background(Color(uiColor: .systemGray5))
                                .cornerRadius(4)
                            Text("g").font(.caption)
                        }
                        
                        HStack {
                            Text("Fibre:")
                                .frame(width: 90, alignment: .leading)
                            TextField("", value: $fibre, format: .number)
                                .padding(8)
                                .background(Color(uiColor: .systemGray3).opacity(0.2)) // Solo etichetta o campo vuoto
                                .cornerRadius(4)
                            Text("g").font(.caption)
                        }
                        Spacer()
                        Button(action: calcoloValori){
                            
                            Text("Calcola").foregroundColor(.white).font(.headline)
                                .padding()
                                .background(Color(uiColor: .systemPurple))
                                .cornerRadius(8)
                        }
                        
                    }
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    NavigationStack {
        ValoriNutrizionali()
    }
}
