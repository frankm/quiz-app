//
//  ResultHelper.swift
//  QuizAppTests
//
//  Created by Frank Morales on 7/30/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//

import QuizEngine

extension Result: Hashable {
    init(answers: [Question: Answer], score: Int) {
        self.answers = answers
        self.score = score
    }
    
    public var hashValue: Int {
        return 1
    }
    
    public static func ==(lhs: Result<Question, Answer>, rhs: Result<Question, Answer>) -> Bool {
        return lhs.score == rhs.score
    }
}
