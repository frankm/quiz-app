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
//        let vc = QuestionViewController(question: "A question?", options: ["Option 1", "Option 2"]) { print($0)
//        }
//        _ = vc.view
//        vc.tableView.allowsMultipleSelection = false
        
        let vc = ResultsViewController(summary: "You got 1/2 correct", answers: [
            PresentableAnswer(question: "Question?? Question?? Question?? Question?? Question?? ", answer: "Yeah! Yeah! Yeah! Yeah! Yeah! Yeah! Yeah! Yeah! Yeah! Yeah! ", wrongAnswer: nil),
            PresentableAnswer(question: "Another Question??", answer: "Hell yeah!", wrongAnswer: "Hell no!")
        ])
        

        window.rootViewController = vc
        window.makeKeyAndVisible()
        self.window = window
    }
}

