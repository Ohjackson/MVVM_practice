//
//  SceneDelegate.swift
//  MVVM_practice
//
//  Created by Jaehyun Ahn on 12/25/24.
//
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let rootVC = RootViewController() // 루트 뷰 컨트롤러
        let navigationController = UINavigationController(rootViewController: rootVC)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}
