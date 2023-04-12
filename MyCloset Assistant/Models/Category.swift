//
//  Category.swift
//  MyCloset Assistant
//
//  Created by Leonardo Villalobos on 4/11/23.
//

import Foundation

enum Category: Encodable, Decodable, Equatable, CaseIterable {
    
    static var allCases: [Category] {
        return [.top, .bottom, .shoe, .accessory]
    }
    
    case top
    case bottom
    case shoe
    case accessory
    case other(category: String)
    
}

extension Category: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .top:
            return "Top"
        case .bottom:
            return "Bottom"
        case .shoe:
            return "Shoe"
        case .accessory:
            return "Accessory"
        case .other(category: let category):
            guard !category.lowercased().isEmpty else {
                return ""
            }
            var result = category.lowercased()
            let firstCharacter = result.removeFirst()
            return firstCharacter.uppercased() + result
        }
    }
    
}
