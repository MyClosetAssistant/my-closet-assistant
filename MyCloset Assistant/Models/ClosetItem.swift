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
  var imageFile: ParseFile?
  var brand: String?
  var size: String?
  var notes: String?
  var categories: [String]?

  // Required for ParseObject
  var originalData: Data?
  var objectId: String?
  var createdAt: Date?
  var updatedAt: Date?
  var ACL: ParseSwift.ParseACL?

}

extension ClosetItem {

  init(name: String, image: ParseFile?, size: String, notes: String?) {
    self.name = name
    self.imageFile = image
    self.size = size
    self.notes = notes
  }

}
