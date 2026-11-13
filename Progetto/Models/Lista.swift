//
//  Lista.swift
//  Progetto
//
//  Created by s7 on 19/10/26.
//

import Foundation
import SwiftData

@Model
final class Lista {
    var nome: String
    var temperatura: Temperatura
    // true per Frigorifero, Congelatore, Freezer e Dispensa, false per quelle create dall'utente
    var predefinita: Bool = false
    
    @Relationship(deleteRule: .cascade, inverse: \Alimento.lista)
    var alimenti: [Alimento] = []
    
    init(nome: String, temperatura: Temperatura, predefinita: Bool = false) {
        self.nome = nome
        self.temperatura = temperatura
        self.predefinita = predefinita
    }
}
