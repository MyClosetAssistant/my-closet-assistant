//
//  Brand.swift
//  MyCloset Assistant
//
//  Created by Leonardo Villalobos on 4/11/23.
//

import Foundation

enum Brand: Encodable, Decodable, Equatable, CaseIterable {

    static var allCases: [Brand] {
        return [.adidas, .hAndM, .levis]
    }
    
    case adidas
    case hAndM
    case levis
    
    // TODO: Add more brands
    
    case other(brand: String)
}

extension Brand: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .adidas:
            return "Adidas"
        case .hAndM:
            return "H&M"
        case .levis:
            return "Levi's"
        case .other(let brand):
            guard !brand.isEmpty else {
                return ""
            }
            return brand
        }
    }
    
}
