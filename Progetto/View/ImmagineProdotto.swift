//
//  ImmagineProdotto.swift
//  Progetto
//

import SwiftUI

// Scarica la foto del prodotto dall'indirizzo che arriva da Open Food Facts.
// Mentre carica mostra la rotella, se l'indirizzo manca o il download fallisce
// mostra il placeholder che abbiamo in Assets.
struct ImmagineProdotto: View {
    let url: String?
    var altezza: CGFloat = 100
    
    var body: some View {
        Group {
            if let url = url, let indirizzo = URL(string: url) {
                AsyncImage(url: indirizzo) { fase in
                    switch fase {
                    case .empty:
                        ProgressView()
                    case .success(let immagine):
                        immagine
                            .resizable()
                            .scaledToFit()
                    case .failure:
                        segnaposto
                    @unknown default:
                        segnaposto
                    }
                }
            } else {
                segnaposto
            }
        }
        .frame(height: altezza)
        .frame(maxWidth: .infinity)
        // le foto di Open Food Facts hanno lo sfondo, il riquadro bianco lo fa sembrare voluto
        .padding(6)
        .background(Color.white)
        .cornerRadius(8)
    }
    
    private var segnaposto: some View {
        Image("placeholder")
            .resizable()
            .scaledToFit()
    }
}

#Preview {
    VStack(spacing: 20) {
        ImmagineProdotto(url: "https://images.openfoodfacts.org/images/products/801/266/604/1459/front_it.16.200.jpg", altezza: 200)
        ImmagineProdotto(url: nil)
    }
    .padding()
    .background(Color(.systemGray5))
}
