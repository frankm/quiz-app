//
//  QuizDelegate.swift
//  QuizEngine
//
//  Created by Frank Morales on 8/6/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//

import Foundation

public protocol QuizDelegate {
    associatedtype Question
    associatedtype Answer

    func answer(for question: Question, completion: @escaping (Answer) -> Void)
    
    func didCompleteQuiz(withAnswers answers: [(question: Question, answer: Answer)])
}
