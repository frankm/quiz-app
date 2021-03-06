//
//  QuestionViewControllerTest.swift
//  QuizAppTests
//
//  Created by Frank Morales on 7/21/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//

import XCTest
@testable import QuizApp

class QuestionViewControllerTest: XCTestCase {

    func test_viewDidLoad_rendersQuestionHeaderText() {
        XCTAssertEqual(makeSUT(question: "Q1").headerLabel.text, "Q1")
    }

    func test_viewDidLoad_rendersOptions() {
        XCTAssertEqual(makeSUT().tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(options: ["A1"]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.numberOfRows(inSection: 0), 2)
    }

    func test_viewDidLoad_rendersOptionsText() {
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 0), "A1")
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 1), "A2")
    }
    
    func test_viewDidLoad_withSingleSelection_configuresTableView() {
        XCTAssertFalse(makeSUT(options: ["A1", "A2"], isMultipleSelection: false).tableView.allowsMultipleSelection)
    }
    
    func test_viewDidLoad_withMultiplelection_configuresTableView() {
        XCTAssertTrue(makeSUT(options: ["A1", "A2"], isMultipleSelection: true).tableView.allowsMultipleSelection)
    }
    
    func test_optionsSelected_withSingleSelection_notifiesDelegateWithLastSelection() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"], isMultipleSelection: false) { receivedAnswer = $0 }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer, ["A2"])
    }
    
    func test_optionsDeselected_withSingleSelection_doesNotNotifyDelegateWithEmptySelection() {
        var callbackCount = 0
        let sut = makeSUT(options: ["A1", "A2"], isMultipleSelection: false) { _ in callbackCount += 1 }
        
        // does not happen via UI; only programmatically
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(callbackCount, 0)
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(callbackCount, 1)
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(callbackCount, 1)
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(callbackCount, 2)
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(callbackCount, 2)
    }
    
    func test_optionsSelected_withMultipleSelectionEnabled_notifiesDelegateSelection() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"], isMultipleSelection: true) { receivedAnswer = $0 }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer, ["A1","A2"])
    }
    
    func test_optionsDeselected_withMultipleSelectionEnabled_notifiesDelegate() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"], isMultipleSelection: true) { receivedAnswer = $0 }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(receivedAnswer, [])
    }
    
    //MARK: - Helpers
    
    func makeSUT(question: String = "",
                 options: [String] = [],
                 isMultipleSelection: Bool = false,
                 selection: @escaping ([String]) -> Void = { _ in }
                 ) -> QuestionViewController {
        //        let questionType = Question.singleAnswer(question)
        //        let factory = iOSViewControllerFactory(options: [questionType: options])
        //        let sut = factory.questionViewController(for: questionType, answerCallback: selection) as! QuestionViewController
        let sut = QuestionViewController(question: question, options: options, allowsMultipleSelection: isMultipleSelection, selection: selection)
        _ = sut.view
//        sut.tableView.allowsMultipleSelection = isMultipleSelection
        return sut
    }
}
