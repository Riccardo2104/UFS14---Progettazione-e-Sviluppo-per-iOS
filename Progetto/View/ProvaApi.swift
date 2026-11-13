//
//  ProvaApi.swift
//  Progetto
//
//  Created by d9 on 05/11/26.
//
import SwiftUI

// pagina solo per provare l'API, da cancellare prima della consegna
struct ProvaApi: View {
    @StateObject private var api = ApiProdotto()
    @State private var barcode = "8012666041459"
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Barcode", text: $barcode)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
            
            Button("Cerca") {
                api.cerca(barcode: barcode)
            }
            
            if api.staCaricando {
                ProgressView()
            } else if let errore = api.errore {
                Text(errore).foregroundColor(.red)
            } else if let p = api.prodotto {
                Text(p.productName ?? "senza nome").font(.title2)
                Text("Kcal: \(p.nutriments?.calories ?? -1)")
                Text("Grassi: \(p.nutriments?.fat ?? -1)")
                Text("Proteine: \(p.nutriments?.proteins ?? -1)")
                Text("Fibre: \(p.nutriments?.fiber ?? -1)")
                Text("Porzione: \(p.servingQuantity ?? -1) g")
                Text(p.imageFrontSmallUrl ?? "nessuna immagine").font(.caption)
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ProvaApi()
}
