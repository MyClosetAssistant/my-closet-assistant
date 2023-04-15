//
//  ViewController.swift
//  MyCloset Assistant
//
//  Created by Leonardo Villalobos on 4/10/23.
//

import UIKit

class LoginView: UIViewController {
    
    // MARK: Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
                
//        var user = User(username: "lobo", email: "villaleobos@gmail.com", password: "meXwov", gender: .male)
//        user.categories = ["Shirt", "Shoes", "Pants"]
//        user.brands = ["Adidas", "H&M", "True Classic"]
//        user.closet = [
//            {
//                var t = ClosetItem(name: "Green T-Shirt", image: nil, size: "M", notes: "Very sportsy")
//                t.brand = "True Classic"
//                t.categories = ["Shirt", "Activewear"]
//                return t
//            }(),
//            {
//                var t = ClosetItem(name: "Grey T-Shirt", image: nil, size: "M", notes: "A grey one")
//                t.brand = "H&M"
//                t.categories = ["Shirt"]
//                return t
//            }(),
//        ]
//
//        user.save { r in
//            switch r {
//            case .success(_):
//                print("Success")
//            case .failure(let e):
//                fatalError("error: \(e)")
//            }
//        }
//
//        User.logout { r in
//            switch r {
//            case .success():
//                print("logged out")
//            case .failure(let e):
//                fatalError("\(e)")
//            }
//        }
        
        if User.current == nil {
            print("Not logged in..")
            User.login(username: "lobo", password: "meXwov") { result in
                switch result {
                case .success(_):
                    print("Logged in")
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    return
                }
            }
        } else {
            print("Already logged in")
        }
    }
    
}
