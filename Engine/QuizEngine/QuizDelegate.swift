//
//  QuizDelegate.swift
//  QuizEngine
//
//  Created by Frank Morales on 8/6/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//

import Foundation

public protocol QuizDelegate {
    associatedtype Question: Hashable
    associatedtype Answer

    func answer(for question: Question, completion: @escaping (Answer) -> Void)
    
    func didCompleteQuiz(withAnswers: [(question: Question, answer: Answer)])
    
    @available(*, deprecated, message: "use didCompleteQuiz(withAnswers:) instead")
    func handle(result: Result<Question, Answer>)
}

public extension QuizDelegate {
    func didCompleteQuiz(withAnswers: [(question: Question, answer: Answer)]) {}

}
