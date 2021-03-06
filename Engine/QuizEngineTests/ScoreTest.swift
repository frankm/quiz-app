//
//  ScoreTest.swift
//  QuizEngineTests
//
//  Created by Frank Morales on 8/8/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//

import XCTest
@testable import QuizApp

class ScoreTest: XCTestCase {
    
    func test_noAnswers_scoresZero() {
        XCTAssertEqual(BasicScore.score(for: [String](), comparingTo: [String]()), 0)
    }
    
    func test_oneNonMatchingAnswer_scoresZero() {
        XCTAssertEqual(BasicScore.score(for: ["not a match"], comparingTo: ["answer"]), 0)

    }
    
    func test_oneMatchingAnswer_scoresOne() {
        XCTAssertEqual(BasicScore.score(for: ["answer"], comparingTo: ["answer"]), 1)

    }
  
    func test_1MatchingAnswer1NonMatchingAnswer_scoresOne() {
        let score = BasicScore.score(for: ["answer1", "not a match"], comparingTo: ["answer1", "answer2"])
        
        XCTAssertEqual(score, 1)
    }
    
    func test_2MatchingAnswers_scores2() {
         let score = BasicScore.score(for: ["answer1", "answer2"], comparingTo: ["answer1", "answer2"])
         
         XCTAssertEqual(score, 2)
     }
    
    func test_withTooManyAnswers_2MatchingAnswers_scores2() {
         let score = BasicScore.score(for: ["answer1", "answer2", "extra answer"], comparingTo: ["answer1", "answer2"])
         
         XCTAssertEqual(score, 2)
     }
    
    func test_tooManyCorrectAnswers_1MatchingAnswer_scores1() {
         let score = BasicScore.score(for: ["not a match", "answer2"], comparingTo: ["answer1", "answer2", "answer3"])
         
         XCTAssertEqual(score, 1)
     }
}
 
