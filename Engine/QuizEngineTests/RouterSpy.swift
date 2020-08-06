//
//  RouterSpy.swift
//  QuizEngineTests
//
//  Created by Frank Morales on 7/26/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//

import Foundation
import QuizEngine

class RouterSpy: Router {
    var routedQuestions = [String]()
    var routedResult:  Result<String, String>?
    var answerCallback: (String) -> Void = { _ in }

    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        routedQuestions.append(question)
        self.answerCallback = answerCallback
    }
    
    func routeTo(result: Result<String, String>) {
        routedResult = result
    }
}
