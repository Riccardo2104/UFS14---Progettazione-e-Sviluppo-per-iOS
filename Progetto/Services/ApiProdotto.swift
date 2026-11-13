import Foundation
import Combine
// Servizio che va a prendere i dati del prodotto da Open Food Facts
class ApiProdotto: ObservableObject, ServizioProdotto {
    
    @Published var prodotto: Product?
    @Published var staCaricando = false
    @Published var errore: String?
    
    // se gli passiamo il ServizioFinto non va su internet (comodo per le prove)
    private let servizio: ServizioProdotto?
    
    init(servizio: ServizioProdotto? = nil) {
        self.servizio = servizio
    }
    
    // per ora usiamo lo staging, alla consegna va messo world.openfoodfacts.org
    private let urlServizio = "https://world.openfoodfacts.net/api/v3/product/"
    private let campi = "product_name,image_front_small_url,nutriments,serving_quantity"
    
    func caricaProdotto(barcode: String, completion: @escaping (Product?) -> Void) {
        guard let url = URL(string: "\(urlServizio)\(barcode)?fields=\(campi)") else {
            print("URL non valido")
            completion(nil)
            return
        }
        
        var richiesta = URLRequest(url: url)
        // Open Food Facts vuole sapere chi fa le richieste
        richiesta.setValue("FrigoNutrient/1.0 (email-del-team@esempio.it)", forHTTPHeaderField: "User-Agent")
        // login dello staging (off/off), da togliere quando passiamo alla produzione
        let credenziali = Data("off:off".utf8).base64EncodedString()
        richiesta.setValue("Basic \(credenziali)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: richiesta) { data, response, error in
            var trovato: Product? = nil
            
            if let data = data,
               let risposta = try? JSONDecoder().decode(ProductResponse.self, from: data) {
                trovato = risposta.product
            }
            
            // la UI si aggiorna solo dal thread principale
            DispatchQueue.main.async {
                completion(trovato)
            }
        }.resume()
    }
    
    // questa è quella che chiamiamo dalla pagina Aggiungi
    func cerca(barcode: String) {
        staCaricando = true
        errore = nil
        prodotto = nil
        
        // usa il servizio finto se c'è, altrimenti quello vero
        let sorgente: ServizioProdotto = servizio ?? self
        sorgente.caricaProdotto(barcode: barcode) { prodottoTrovato in
            self.prodotto = prodottoTrovato
            self.staCaricando = false
            if prodottoTrovato == nil {
                self.errore = "Prodotto non trovato"
            }
        }
    }
}
