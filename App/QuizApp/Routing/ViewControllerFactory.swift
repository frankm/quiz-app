//
//  ViewControllerFactory.swift
//  QuizApp
//
//  Created by Frank Morales on 7/30/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
    typealias Answers = [(question: Question<String>, answer: [String])]
    
    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController
    
    func resultsViewController(for userAnswers: Answers) -> UIViewController

    func resultsViewController(for result: Result<Question<String>, [String]>) -> UIViewController
}

