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

    typealias AnswerCallback = (Answer) -> Void
    func answer(for question: Question, completion: @escaping AnswerCallback)
    func handle(result: Result<Question, Answer>)
}
