//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Frank Morales on 7/19/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//

import Foundation
import XCTest
@testable import QuizEngine

class FlowTest: XCTestCase {
    
    func test_start_withNoQuestions_doesNotDelegateQuestionHandling() {
        makeSUT(questions: []).start()
        
        XCTAssertTrue(delegate.handledQuestions.isEmpty)
    }
    
    func test_start_with1Question_delegatesQuestionHandling() {
        makeSUT(questions: ["Q1"]).start()
        
        XCTAssertEqual(delegate.handledQuestions,["Q1"])
    }
    
    func test_start_with1Question_delegatesAnotherQuestionHandling() {
        makeSUT(questions: ["Q2"]).start()
        
        XCTAssertEqual(delegate.handledQuestions, ["Q2"])
    }
    
    func test_start_with2Question_delegatesFirstQuestionHandling() {
        makeSUT(questions: ["Q1", "Q2"]).start()
        
        XCTAssertEqual(delegate.handledQuestions, ["Q1"])
    }
    
    func test_startTwice_with2Question_delegatesFirstQuestionHandlingTwice() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        sut.start()
        
        XCTAssertEqual(delegate.handledQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswer1And2Question_with3Questions_delegatesSecondAndThirdQuestionHandling() {
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        
        sut.start()
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")
        
        XCTAssertEqual(delegate.handledQuestions, ["Q1", "Q2", "Q3"])
    }
    
    func test_startAndAnswer1Question_with1Question_doesNotDelegateAnotherQuestionHandling() {
        let sut = makeSUT(questions: ["Q1"])
        
        sut.start()
        delegate.answerCallback("A1")
        
        XCTAssertEqual(delegate.handledQuestions, ["Q1"])
    }
    
    func test_start_withNoQuestions_delegatesResultHandling() {
        makeSUT(questions: []).start()
        
        XCTAssertEqual(delegate.handledResult!.answers, [:])
    }
    
    func test_start_with1Question_doesNotDelegateResultHandling() {
        makeSUT(questions: ["Q1"]).start()
        
        XCTAssertNil(delegate.handledResult)
    }
    
    func test_startAndAnswer1Question_with2Question_doesNotDelegateResultHandling() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        
        delegate.answerCallback("A1")
        
        XCTAssertNil(delegate.handledResult)
    }
    
    func test_startAndAnswer2Questions_with2Questions_delegatesResultHandling() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")

        XCTAssertEqual(delegate.handledResult!.answers, ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_startAndAnswer2Question_with2Questions_scores() {
        let sut = makeSUT(questions: ["Q1", "Q2"], scoring: {_ in 10})
        sut.start()
        
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")
        
        XCTAssertEqual(delegate.handledResult!.score, 10)
    }
    
    func test_startAndAnswer2Question_with2Questions_scoresWithRightAnswers() {
        var receivedAnswers = [String: String]()
        let sut = makeSUT(questions: ["Q1", "Q2"], scoring: { answers in
            receivedAnswers = answers
            return 20
        })
        sut.start()
        
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")
        
        XCTAssertEqual(receivedAnswers, ["Q1": "A1", "Q2": "A2"])
    }
    
    //MARK: - Helpers
    
    private let delegate = DelegateSpy()
    private weak var weakSUT: Flow<DelegateSpy>?

    override func tearDown() {
        super.tearDown()
        
        XCTAssertNil(weakSUT, "Memory leak detected. Weak reference to the SUT instance is not nil.")
    }
    
    private func makeSUT(questions: [String],
                         scoring: @escaping ([String: String]) -> Int = {_ in 0 }) -> Flow<DelegateSpy> {
        let sut = Flow(questions: questions, delegate: delegate, scoring: scoring)
        weakSUT = sut
        return sut
    }
    
     private class DelegateSpy: QuizDelegate {
        var handledQuestions = [String]()
        var handledResult:  Result<String, String>?
        var answerCallback: (String) -> Void = { _ in }

        func handle(question: String, answerCallback: @escaping (String) -> Void) {
            handledQuestions.append(question)
            self.answerCallback = answerCallback
        }
        
        func handle(result: Result<String, String>) {
            handledResult = result
        }
    }
}
