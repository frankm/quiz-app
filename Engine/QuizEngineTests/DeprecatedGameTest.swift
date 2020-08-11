//
//  DeprecatedGameTest.swift
//  QuizEngineTests
//
//  Created by Frank Morales on 7/26/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//

import XCTest
import QuizEngine

@available(*, deprecated)
class DeprecatedGameTest: XCTestCase {
    
    private let router = RouterSpy()
    private var game: Game<String, String, RouterSpy>!
    
    override func setUp() {
        super.setUp()
        game = startGame(questions: ["Q1", "Q2"], router: router, correctAnswers:  ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_startGame_answer0OutOf2Correctly_scores0() {
        router.answerCallback("wrong")
        router.answerCallback("wrong")
        
        XCTAssertEqual(router.routedResult!.score,  0)
    }
    
    func test_startGame_answer1OutOf2Correctly_scores1() {
        router.answerCallback("A1")
        router.answerCallback("wrong")
        
        XCTAssertEqual(router.routedResult!.score,  1)
    }
    
    func test_startGame_answer2OutOf2Correctly_scores2() {
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedResult!.score,  2)
    }
    
    private class RouterSpy: Router {
        var routedResult:  Result<String, String>?
        var answerCallback: (String) -> Void = { _ in }

        func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
            self.answerCallback = answerCallback
        }
        
        func routeTo(result: Result<String, String>) {
            routedResult = result
        }
     }
}


