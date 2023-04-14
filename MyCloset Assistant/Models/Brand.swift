//
//  Brand.swift
//  MyCloset Assistant
//
//  Created by Leonardo Villalobos on 4/11/23.
//

import Foundation
import ParseSwift

struct Brand: ParseObject {
    
    // Custom fields
    var name: String?
    
    // Required for ParseObject
    var originalData: Data?
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseSwift.ParseACL?

}

extension Brand {
    
    init(name: String) {
        self.name = name
    }
    
}
