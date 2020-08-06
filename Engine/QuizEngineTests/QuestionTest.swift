//
//  QuestionTest.swift
//  QuizAppTests
//
//  Created by Frank Morales on 7/29/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//

import XCTest
@testable import QuizEngine

class QuestionTest: XCTestCase {
  
    func test_hashValue_withSameWrappedValue_isDifferentForSingleAndMultipleAnswer() {
        let aValue = UUID()
        
        XCTAssertNotEqual(Question.singleAnswer(aValue).hashValue, Question.multipleAnswer(aValue).hashValue)
    }
    
    func test_hashValue_singleAnswer_forSingleAnswer() {
        let aValue = UUID()
        let anotherValue = UUID()
        
        XCTAssertEqual(Question.singleAnswer(aValue).hashValue, Question.singleAnswer(aValue).hashValue)
        XCTAssertNotEqual(Question.singleAnswer(aValue).hashValue, Question.singleAnswer(anotherValue).hashValue)
    }
    
    func test_hashValue_singleAnswer_forMultipleAnswer() {
        let aValue = UUID()
        let anotherValue = UUID()
        
        XCTAssertEqual(Question.multipleAnswer(aValue).hashValue, Question.multipleAnswer(aValue).hashValue)
        XCTAssertNotEqual(Question.multipleAnswer(aValue).hashValue, Question.multipleAnswer(anotherValue).hashValue)
    }
    
}
