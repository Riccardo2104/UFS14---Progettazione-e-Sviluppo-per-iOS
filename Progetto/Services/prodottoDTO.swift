//
//  prodottoDTO.swift
//  Progetto
//
//  Created by s7 on 05/11/26.
//

import Foundation

struct ProductResponse: Codable {
    let product: Product
}

struct Product: Codable {
    let productName: String?
    let imageFrontSmallUrl: String?
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

    var kcal: Double {
        energyKcalPrepared100g ?? energyKcal100g ?? 0.0
    }
    
    var grassi: Double {
        fatPrepared100g ?? fat100g ?? 0.0
    }
    
    var proteine: Double {
        proteinsPrepared100g ?? proteins100g ?? 0.0
    }
    
    var fibre: Double {
        fiberPrepared100g ?? fiber100g ?? 0.0
    }
}
