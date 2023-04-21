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
  case other

}

extension Gender: CustomStringConvertible {

  var description: String {
    switch self {
    case .female:
      return "Female"
    case .male:
      return "Male"
    case .other:
      return "Other"
    }
  }

}
