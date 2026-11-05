//
//  prodottoDTO.swift
//  Progetto
//
//  Created by s7 on 05/11/26.
//

import Foundation

struct ProductResponse: Codable {
    let product: Product?
    let code: String
    let status: String
}

struct Product: Codable {
    let productName: String?
    let imageFrontSmallUrl: String?
    // questi sono i grammi a porzione
    let servingQuantity: Double?
    let nutriments: Nutriments?

    enum CodingKeys: String, CodingKey {
        case productName = "product_name"
        case imageFrontSmallUrl = "image_front_small_url"
        case servingQuantity = "serving_quantity"
        case nutriments
    }
}

struct Nutriments: Codable {
    private let energyKcal100g: Double?
    private let energyKcalPrepared100g: Double?
    
    private let fat100g: Double?
    private let fatPrepared100g: Double?
    
    private let proteins100g: Double?
    private let proteinsPrepared100g: Double?
    
    private let fiber100g: Double?
    private let fiberPrepared100g: Double?
    init(calories: Double?, fat: Double?, proteins: Double?, fiber: Double?) {
        energyKcal100g = calories
        fat100g = fat
        proteins100g = proteins
        fiber100g = fiber
        energyKcalPrepared100g = nil
        fatPrepared100g = nil
        proteinsPrepared100g = nil
        fiberPrepared100g = nil
    }
    enum CodingKeys: String, CodingKey {
        case energyKcal100g = "energy-kcal_100g"
        case energyKcalPrepared100g = "energy-kcal_prepared_100g"
        case fat100g = "fat_100g"
        case fatPrepared100g = "fat_prepared_100g"
        case proteins100g = "proteins_100g"
        case proteinsPrepared100g = "proteins_prepared_100g"
        case fiber100g = "fiber_100g"
        case fiberPrepared100g = "fiber_prepared_100g"
    }
    // teniamo in inglese per facilità con i campi del json
    // ho tolto gli zeri perchè potrebbe essere missleading
    var calories: Double? { energyKcalPrepared100g ?? energyKcal100g }
    var fat: Double?      { fatPrepared100g ?? fat100g }
    var proteins: Double? { proteinsPrepared100g ?? proteins100g }
    // ho tolto gli zer
    var fiber: Double?    { fiberPrepared100g ?? fiber100g }
}
