//
//  iOSViewControllerFactoryTest.swift
//  QuizAppTests
//
//  Created by Frank Morales on 7/30/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//

import XCTest
import QuizEngine
@testable import QuizApp

class iOSViewControllerFactoryTest: XCTestCase {
    
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q1")

    let options = ["A1", "A2"]
    
    func test_questionVC_singleAnswer_createsControllerWithTitle() {
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: singleAnswerQuestion)
        XCTAssertEqual(makeQuestionController(question: singleAnswerQuestion).title, presenter.title)
    }
    
    func test_questionVC_singleAnswer_createsControllerWithQuestions() {
        XCTAssertEqual(makeQuestionController(question: singleAnswerQuestion).question, "Q1")
    }
    
    func test_questionVC_singleAnswer_createsControllerWithOptions() {
        XCTAssertEqual(makeQuestionController().options, options)
    }
    
    func test_questionVC_singleAnswer_createsControllerWithSingleSelection() {
        XCTAssertFalse(makeQuestionController().allowsMultipleSelection)
    }
    
    func test_questionVC_multipleAnswer_createsControllerWithTitle() {
         let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: multipleAnswerQuestion)
         XCTAssertEqual(makeQuestionController(question: multipleAnswerQuestion).title, presenter.title)
     }
    
    func test_questionVC_multipleAnswer_createsControllerWithQuestions() {
        XCTAssertEqual(makeQuestionController(question: multipleAnswerQuestion).question, "Q1")
    }
    
    func test_questionVC_multipleAnswer_createsControllerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: multipleAnswerQuestion).options, options)
    }
    
    func test_questionVC_multipleAnswer_createsControllerWithSingleSelection() {
        XCTAssertTrue(makeQuestionController(question: multipleAnswerQuestion).allowsMultipleSelection)
    }
    
    func test_resultsVC_createsControllerWithTitle() {
        let results = makeResults()
        
        XCTAssertEqual(results.controller.title, results.presenter.title)
    }
    
    func test_resultsVC_createsControllerWithSummary() {
        let results = makeResults()
        
        XCTAssertEqual(results.controller.summary, results.presenter.summary)
    }
    
    func test_resultsVC_createsControllerWithPresentableAnswers() {
        let results = makeResults()
        
        XCTAssertEqual(results.controller.answers.count, results.presenter.presentableAnswers.count)
    }
    
    //MARK: - Helpers
    
    func makeSUT(options: Dictionary<Question<String>, [String]> = [:], correctAnswers: Dictionary<Question<String>, [String]> = [:]) -> iOSViewControllerFactory {
        return  iOSViewControllerFactory(questions: [singleAnswerQuestion, multipleAnswerQuestion], options: options, correctAnswers: correctAnswers)
    }
    
    func makeQuestionController(question: Question<String> = Question.singleAnswer("")) -> QuestionViewController {
        return makeSUT(options: [question: options]).questionViewController(for: question, answerCallback: { _ in }) as! QuestionViewController
    }
    
    func makeResults() -> (controller: ResultsViewController, presenter: ResultsPresenter) {
        let userAnswers = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A1", "A2"]]
        let correctAnswers = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A1", "A2"]]
        let questions = [singleAnswerQuestion, multipleAnswerQuestion]
        let result = Result(answers: userAnswers, score: 2)
        
        let presenter = ResultsPresenter(result: result, questions: questions, correctAnswers: correctAnswers)
        let sut = makeSUT(correctAnswers: correctAnswers)
        
        let controller = sut.resultsViewController(for: result) as! ResultsViewController
        return (controller, presenter)
    }
}
