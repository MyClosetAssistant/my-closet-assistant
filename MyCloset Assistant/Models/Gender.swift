//
//  Gender.swift
//  MyCloset Assistant
//
//  Created by Leonardo Villalobos on 4/11/23.
//

import Foundation

enum Gender: Encodable, Decodable, Equatable {
    
    case female
    case male
    case other(gender: String)
    
}

extension Gender: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .female:
            return "Female"
        case .male:
            return "Male"
        case .other(let gender):
            guard !gender.lowercased().isEmpty else {
                return ""
            }
            var result = gender.lowercased()
            let firstCharacter = result.removeFirst()
            return firstCharacter.uppercased() + result
        }
    }
    
}
