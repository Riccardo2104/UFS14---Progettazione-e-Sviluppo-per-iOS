//
//  ConfermoAlimento.swift
//  Progetto
//
//  Created by s15 on 05/11/26.
//
import SwiftUI

struct ConfermoAlimento: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
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
        }
        Text("é questo il tuo prodotto?")
        Image("background")
            .resizable()
            .edgesIgnoringSafeArea(.all)
            .opacity(0.3)
            .frame(width: 400, height: 400)
        HStack {
            Spacer()
            Button(action: { dismiss() }) {
                Text("Si")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 100, height: 50)
                    .background(Color.purple)
            }
            Button(action: { dismiss() }) {
                Text("Si")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 100, height: 50)
                    .background(Color.purple)
            }
        }
        
    }
}
#Preview {
    NavigationStack {
        ConfermoAlimento()
    }
}

