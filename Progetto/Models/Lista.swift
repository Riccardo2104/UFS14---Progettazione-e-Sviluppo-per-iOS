//
//  Lista.swift
//  Progetto
//
//  Created by s7 on 19/10/26.
//

import Foundation
@Model
final class Lista { //Evitare eredità altre classi
    var ID = UUID()
    var nome: String
    var temperatura: String
    var alimenti: Alimento
    


    init(barcode: String, nome: String) {
        self.barcode = barcode
        self.nome = nome
    }
}
