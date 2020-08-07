//
//  QuizTest.swift
//  QuizEngineTests
//
//  Created by Frank Morales on 8/7/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//


import XCTest
@testable import QuizEngine

final class Quiz {
    private let flow: Any
    
    init(flow: Any) {
        self.flow = flow
    }
    
    static func start<Question, Answer: Equatable, Delegate: QuizDelegate>(questions: [Question], delegate: Delegate, correctAnswers: [Question: Answer]) -> Quiz where Delegate.Question == Question, Delegate.Answer == Answer {
        let flow = Flow(questions: questions, delegate: delegate,  scoring: { scoring($0, correctAnswers: correctAnswers)})
        flow.start()
        return Quiz(flow: flow)
    }
}

 class QuizTest: XCTestCase {
    
    private let delegate = DelegateSpy()
    private var quiz: Quiz!
    
    override func setUp() {
        super.setUp()
        quiz = Quiz.start(questions: ["Q1", "Q2"], delegate: delegate, correctAnswers:  ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_startQuiz_answer0OutOf2Correctly_scores0() {
        delegate.answerCallback("wrong")
        delegate.answerCallback("wrong")
        
        XCTAssertEqual(delegate.handledResult!.score,  0)
    }
    
    func test_startQuiz_answer1OutOf2Correctly_scores1() {
        delegate.answerCallback("A1")
        delegate.answerCallback("wrong")
        
        XCTAssertEqual(delegate.handledResult!.score,  1)
    }
    
    func test_startQuiz_answer2OutOf2Correctly_scores2() {
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")
        
        XCTAssertEqual(delegate.handledResult!.score,  2)
    }
    
    private class DelegateSpy: Router, QuizDelegate {
        var handledResult:  Result<String, String>?
        var answerCallback: (String) -> Void = { _ in }

        func handle(question: String, answerCallback: @escaping (String) -> Void) {
            self.answerCallback = answerCallback
        }
        
        func handle(result: Result<String, String>) {
            handledResult = result
        }
        
        func routeTo(question: String, answerCallback: @escaping AnswerCallback) {
            handle(question: question, answerCallback: answerCallback)
        }
        
        func routeTo(result: Result<String, String>) {
            handle(result: result)
        }
     }
}


