//
//  DelegateSpy.swift
//  QuizEngineTests
//
//  Created by Frank Morales on 8/8/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//

import Foundation
import QuizEngine

class DelegateSpy: QuizDelegate {
    var questionsAsked = [String]()
    var answerCompletions: [(String) -> Void] = []
    
    var completedQuizzes = [[(String, String)]]()
    
    func answer(for question: String, completion: @escaping (String) -> Void) {
        questionsAsked.append(question)
        self.answerCompletions.append(completion)
    }
    
    func didCompleteQuiz(withAnswers answers: [(question: String, answer: String)]) {
        completedQuizzes.append(answers)
    }
}
