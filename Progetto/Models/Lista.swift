//
//  Lista.swift
//  Progetto
//
//  Created by s7 on 19/10/26.
//

import Foundation

 class Lista { //Evitare eredità altre classi
    var ID = UUID()
    var nome: String
    var temperatura: String
    var alimenti: Alimento
    


     init(
        ID: UUID = UUID(),
        nome: String,
        temperatura: String,
        alimenti: Alimento
     ) {
         self.ID = ID
         self.nome = nome
         self.temperatura = temperatura
         self.alimenti = alimenti
     }
}
