//
//  ProductProtocol.swift
//  Progetto
//
//  Created by d9 on 05/11/26.
//

protocol ServizioProdotto {
    func caricaProdotto(barcode: String, completion: @escaping (Product?) -> Void)
}
