//
//  ClothingItem.swift
//  MyCloset Assistant
//
//  Created by Leonardo Villalobos on 4/11/23.
//

import Foundation
import ParseSwift

struct ClosetItem: ParseObject {
    
    // Custom fields
    var name: String?
    var categories: [Category]?
    var imageFile: ParseFile?
    var brand: Brand?
    var size: String?
    var notes: String?
    
    // Required for ParseObject
    var originalData: Data?
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseSwift.ParseACL?
    
}
