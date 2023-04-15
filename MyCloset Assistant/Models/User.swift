//
//  User.swift
//  MyCloset Assistant
//
//  Created by Leonardo Villalobos on 4/11/23.
//

import Foundation
import ParseSwift

struct User: ParseUser {
    
    // Custom fields
    var gender: Gender?
    var closet: [ClosetItem]?
    var categories: [String]?
    var brands: [String]?
    
    // Required for ParseUser
    var username: String?
    var email: String?
    var emailVerified: Bool?
    var password: String?
    var authData: [String : [String : String]?]?
    var originalData: Data?
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseSwift.ParseACL?
    
}

extension User {
    init(username: String, email: String, password: String, gender: Gender) {
        self.username = username
        self.email = email
        self.password = password
        self.gender = gender
    }
}
