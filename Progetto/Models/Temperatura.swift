//
//  Temperatura.swift
//  Progetto
//
//  Created by s7 on 19/10/26.
//

import Foundation
enum Temperatura: Int, CaseIterable {
    case ambiente = 1
    case fresco = 2
    case congelato = 3

    var icona: String {
        switch self {
        case .ambiente: return "house"
        case .fresco:   return "refrigerator"
        case .congelato:    return "snowflake"
        }
    }
}
