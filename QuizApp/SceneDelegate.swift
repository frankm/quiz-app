//
//  SceneDelegate.swift
//  QuizApp
//
//  Created by Frank Morales on 7/21/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//

import UIKit
import QuizEngine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var game: Game<Question<String>, [String], NavigationControllerRouter>?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

//        let question1 = Question.singleAnswer("What is Mike's nationality?")
//        let question2 = Question.multipleAnswer("What are Caio's nationality?")
//        let questions = [question1, question2]
//
//        let option1 = "Canadian"
//        let option2 = "American"
//        let option3 = "Greek"
//        let options1 = [option1, option2, option3]
//        
//        let option4 = "Portuguese"
//        let option5 = "American"
//        let option6 = "Brazilian"
//        let options2 = [option4, option5, option6]
//        
//        let correctAnswers = [question1: [option3], question2: [option4, option6]]
//
//        let navigationController = UINavigationController()
//        let factory = iOSViewControllerFactory(questions: questions, options: [question1: options1, question2: options2], correctAnswers: correctAnswers)
//        let router = NavigationControllerRouter(navigationController, factory: factory)
//        
//        game = startGame(questions: questions, router: router, correctAnswers: correctAnswers)
//                
//
//        window.rootViewController = navigationController
//        window.makeKeyAndVisible()
//        self.window = window
    }
}

