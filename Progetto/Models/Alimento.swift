//
//  Lista.swift
//  Progetto
//
//  Created by s7 on 19/10/26.
//

import Foundation
class Alimento {
    var barcode: String
    var nome: String
    var immagineURL: String?
    var kcal100g: Double?
    var grassi100g: Double?
    var proteine100g: Double?
    var fibre100g: Double?
    var grammi: Double = 100
    var scadenza: Date?
    var lista: Lista?


    init(
        barcode: String,
        nome: String,
        immagineURL: String? = nil,
        kcal100g: Double? = nil,
        grassi100g: Double? = nil,
        proteine100g: Double? = nil,
        fibre100g: Double? = nil,
        grammi: Double,
        scadenza: Date? = nil,
        lista: Lista? = nil
    ) {
        self.barcode = barcode
        self.nome = nome
        self.immagineURL = immagineURL
        self.kcal100g = kcal100g
        self.grassi100g = grassi100g
        self.proteine100g = proteine100g
        self.fibre100g = fibre100g
        self.grammi = grammi
        self.scadenza = scadenza
        self.lista = lista
    }
}
