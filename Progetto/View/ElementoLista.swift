//
//  ElementoLista.swift
//

import Foundation

struct ElementoLista: Identifiable, Hashable {
    let id: UUID
    var nome: String
    var selezionato: Bool
    
    init(id: UUID = UUID(), nome: String, selezionato: Bool = false) {
        self.id = id
        self.nome = nome
        self.selezionato = selezionato
    }
}
