//
//  ResultHelper.swift
//  QuizAppTests
//
//  Created by Frank Morales on 7/30/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//

@testable import QuizEngine

extension Result {
    init(answers: [Question: Answer], score: Int) {
        self.answers = answers
        self.score = score
    }
}
 
extension Result: Equatable where Answer: Equatable {
    public static func ==(lhs: Result<Question, Answer>, rhs: Result<Question, Answer>) -> Bool {
        return lhs.score == rhs.score && lhs.answers == rhs.answers
    }
}

extension Result: Hashable where Answer: Equatable {
    public var hashValue: Int {
        return 1
    }
}
 

