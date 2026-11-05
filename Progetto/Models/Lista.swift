//
//  Lista.swift
//  Progetto
//
//  Created by s7 on 19/10/26.
//

import Foundation
import SwiftData
@Model
 class Lista { //Evitare eredità altre classi
    var ID = UUID()
    var nome: String
    var temperatura: Temperatura
    var alimenti: Alimento
    


     init(
        ID: UUID = UUID(),
        nome: String,
        temperatura: Temperatura,
        alimenti: Alimento
     ) {
         self.ID = ID
         self.nome = nome
         self.temperatura = temperatura
         self.alimenti = alimenti
     }
}
