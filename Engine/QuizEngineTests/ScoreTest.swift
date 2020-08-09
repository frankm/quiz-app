//
//  ScoreTest.swift
//  QuizEngineTests
//
//  Created by Frank Morales on 8/8/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//

import Foundation
import XCTest

class ScoreTest: XCTestCase {
    
    func test_noAnswers_scoresZero() {
        XCTAssertEqual(BasicScore.score(for: [], comparingTo: []), 0)
    }
    
    func test_oneWrongAnswer_scoresZero() {
        XCTAssertEqual(BasicScore.score(for: ["wrong"], comparingTo: ["correct"]), 0)

    }
    
    func test_oneCorrectAnswer_scoresOne() {
        XCTAssertEqual(BasicScore.score(for: ["correct"], comparingTo: ["correct"]), 1)

    }
  
    func test_1CorrectAnswer1WrongAnswer_scoresOne() {
        let score = BasicScore.score(for: ["correct1", "wrong"], comparingTo: ["correct1", "correct2"])
        
        XCTAssertEqual(score, 1)
    }
    
    
    private class BasicScore {
        static func score(for answers: [String], comparingTo correctAnswers: [String] = []) -> Int {
            if answers.isEmpty { return 0 }
            var score = 0
            for (index, answer) in answers.enumerated() {
                if answers[index] == correctAnswers[index] {
                    score += 1
                }
            }
            return score
        }
    }
}
 
