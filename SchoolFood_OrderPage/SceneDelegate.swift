//
//  SceneDelegate.swift
//  SchoolFood_OrderPage
//
//  Created by 김현준 on 2022/08/11.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScen = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScen)
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
    }

}

