//
//  SceneDelegate.swift
//  RxSwiftPractice
//
//  Created by 김성민 on 7/30/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let vc = SimpleTableViewExampleViewController()
        window?.rootViewController = vc
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
    }
}
