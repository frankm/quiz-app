//
//  SceneDelegate.swift
//  QuizApp
//
//  Created by Frank Morales on 7/21/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let viewController = QuestionViewController(question: "A question?", options: ["Option 1", "Option 2"]) { print($0)
        }
        _ = viewController.view
        viewController.tableView.allowsMultipleSelection = false
        window.rootViewController = viewController
        
        window.makeKeyAndVisible()
        self.window = window
    }
}

