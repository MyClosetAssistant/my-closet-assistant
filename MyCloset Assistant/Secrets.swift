//
//  Secrets.swift
//  MyCloset Assistant
//
//  Created by Leonardo Villalobos on 4/11/23.
//

import Foundation

class SecretManager {
    
    static let shared = SecretManager()
    
    var fileName: String = "Secrets"
    var fileExtension: String = "plist"
    private var map: NSDictionary
    
    /// Keys as they appear in the plist file
    public enum Key: String {
        typealias RawValue = String
        
        case applicationId = "applicationId"
        case clientKey = "clientKey"
    }
    
    private init() {
        if let path = Bundle.main.path(
            forResource: self.fileName,
            ofType: self.fileExtension
        ) {
            self.map = NSDictionary(contentsOfFile: path)!
        } else {
            let file = "\(fileName).\(fileExtension)"
            fatalError("Could not find \(file). This file is neeeded to load secret keys.")
        }
    }
    
    /// Returns the value associated with the key specified in the plist file.
    /// If key is not in plist file, returns an emptry string.
    func getValue(for key: Key) -> String {
        guard let key = map[key.rawValue] as? String else { return "" }
        return key
    }
    
}
