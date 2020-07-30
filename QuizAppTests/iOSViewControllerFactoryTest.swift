//
//  iOSViewControllerFactoryTest.swift
//  QuizAppTests
//
//  Created by Frank Morales on 7/30/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//

import XCTest
@testable import QuizApp

class iOSViewControllerFactoryTest: XCTestCase {
    func test_questionVC_createsControllerWithQuestions() {
        let question = Question.singleAnswer("Q1")
        let options = ["A1", "A2"]
        let sut = iOSViewControllerFactory(options: [question: options])
        let controller = sut.questionViewController(for: Question.singleAnswer("Q1"), answerCallback: { _ in }) as? QuestionViewController
        
        XCTAssertEqual(controller?.question, "Q1")
    }
    
    func test_questionVC_createsControllerWithOptions() {
        let question = Question.singleAnswer("Q1")
        let options = ["A1", "A2"]
        let sut = iOSViewControllerFactory(options: [question: options])
        
        let controller = sut.questionViewController(for: Question.singleAnswer("Q1"), answerCallback: { _ in }) as! QuestionViewController
        
        XCTAssertEqual(controller.options, options)
    }
}
