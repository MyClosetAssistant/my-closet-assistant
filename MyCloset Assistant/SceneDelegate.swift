//
//  SceneDelegate.swift
//  MyCloset Assistant
//
//  Created by Leonardo Villalobos on 4/10/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    private enum Constants {
        static let loginViewController = "LoginViewController"
        static let tabBarController = "TabBarController"
        static let storyboardIdentifier = "Main"
    }

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else {
            return
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name("login"), object: nil, queue: OperationQueue.main) { [weak self] _ in
            self?.login()
        }

        NotificationCenter.default.addObserver(forName: Notification.Name("logout"), object: nil, queue: OperationQueue.main) { [weak self] _ in
            self?.logOut()
        }

        if User.current != nil {
            login()
        }
    }
    
    private func login() {
        let storyboard = UIStoryboard(name: Constants.storyboardIdentifier, bundle: nil)
        self.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: Constants.tabBarController)
    }

    private func logOut() {
        User.logout { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: Constants.storyboardIdentifier, bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: Constants.loginViewController)
                    self?.window?.rootViewController = viewController
                }
            case .failure(let error):
                fatalError("\(error.localizedDescription)")
            }
        }

    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
    
}
