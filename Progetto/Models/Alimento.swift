//
//  Lista.swift
//  Progetto
//
//  Created by s7 on 19/10/26.
//
import Lista
import Foundation
@Model
final class Alimento {
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


    init(barcode: String, nome: String) {
        self.barcode = barcode
        self.nome = nome
    }
}
