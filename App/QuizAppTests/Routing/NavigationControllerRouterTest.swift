//
//  NavigationControllerRouterTest.swift
//  QuizAppTests
//
//  Created by Frank Morales on 7/29/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//

import XCTest
import QuizEngine
import UIKit
@testable import QuizApp

class NavigationControllerRouterTest: XCTestCase {
    
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let singleAnswerQuestionQ2 = Question.singleAnswer("Q2")
    let multipleAnswerQuestion = Question.multipleAnswer("Q1")

    let navigationController = NonAnimatedNavigationController()
    let factory = ViewControllerFactoryStub()
    lazy var sut: NavigationControllerRouter = {
        return NavigationControllerRouter(navigationController, factory: factory)
    }()

    func test_answerForQuestion_showsQuestionController() {
        let vc1 = UIViewController()
        let vc2 = UIViewController()
        factory.stub(question: singleAnswerQuestion, with: vc1)
        factory.stub(question: singleAnswerQuestionQ2, with: vc2)
        
        sut.answer(for: singleAnswerQuestion, completion: { _ in })
        sut.answer(for: singleAnswerQuestionQ2, completion: { _ in })

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, vc1)
        XCTAssertEqual(navigationController.viewControllers.last, vc2)
    }
    
    func test_answerForQuestion_singleAnswer_answerCallback_progressToNextQuestion() {
        var callbackWasFired = false
        sut.answer(for: singleAnswerQuestion, completion: { _ in callbackWasFired = true })
        
        factory.answerCallback[singleAnswerQuestion]!(["anything"])
        
        XCTAssertTrue(callbackWasFired)
    }
    
    func test_answerForQuestion_singleAnswer_doesNotConfiguresViewControllerWithSubmitButton() {
        let vc1 = UIViewController()
        factory.stub(question: singleAnswerQuestion, with: vc1)

        sut.answer(for: singleAnswerQuestion, completion: { _ in })
        
        XCTAssertNil(vc1.navigationItem.rightBarButtonItem)
    }
    
    func test_answerForQuestion_multipleAnswer_answerCallback_doesNotProgressToNextQuestion() {
        var callbackWasFired = false
        sut.answer(for: multipleAnswerQuestion, completion: { _ in callbackWasFired = true })
        
        factory.answerCallback[multipleAnswerQuestion]!(["anything"])
        
        XCTAssertFalse(callbackWasFired)
    }
    
    func test_answerForQuestion_multipleAnswer_configuresViewControllerWithSubmitButton() {
        let vc1 = UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: vc1)

        sut.answer(for: multipleAnswerQuestion, completion: { _ in })
        
        XCTAssertNotNil(vc1.navigationItem.rightBarButtonItem)
    }
    
    func test_answerForQuestion_multipleAnswerSubmitButton_isDisabledWhen0AnswersSelected() {
        let vc1 = UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: vc1)

        sut.answer(for: multipleAnswerQuestion, completion: { _ in })
        XCTAssertFalse(vc1.navigationItem.rightBarButtonItem!.isEnabled)
        
        factory.answerCallback[multipleAnswerQuestion]!(["A1"])
        XCTAssertTrue(vc1.navigationItem.rightBarButtonItem!.isEnabled)
        
        factory.answerCallback[multipleAnswerQuestion]!([])
        XCTAssertFalse(vc1.navigationItem.rightBarButtonItem!.isEnabled)
    }
    
    func test_answerForQuestion_multipleAnswerSubmitButton_progressesToNextQuestion() {
        let vc1 = UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: vc1)
        
        var callbackWasFired = false
        sut.answer(for: multipleAnswerQuestion, completion: { _ in callbackWasFired = true })
        
        factory.answerCallback[multipleAnswerQuestion]!(["A1"])
        vc1.navigationItem.rightBarButtonItem!.simulateTap()
        
        XCTAssertTrue(callbackWasFired)
    }
    
    func test_routeToResult_showsResultController() {
        let vc1 = UIViewController()
        let vc2 = UIViewController()
        
        let userAnswers1 =  [(singleAnswerQuestion, ["A1"])]
        let userAnswers2 = [(singleAnswerQuestionQ2, ["A2"])]

        factory.stub(resultForQuestions: [singleAnswerQuestion], with: vc1)
        factory.stub(resultForQuestions: [singleAnswerQuestionQ2], with: vc2)

        sut.didCompleteQuiz(withAnswers: userAnswers1)
        sut.didCompleteQuiz(withAnswers: userAnswers2)

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, vc1)
        XCTAssertEqual(navigationController.viewControllers.last, vc2)
    }
    
     //MARK: - Helpers
    
    class NonAnimatedNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    class ViewControllerFactoryStub: ViewControllerFactory {
        private var stubbedQuestions = Dictionary<Question<String>, UIViewController>()
        private var stubbedResults = Dictionary<[Question<String>], UIViewController>()
        
        var answerCallback = Dictionary<Question<String>, ([String]) -> Void>()

        func stub(question: Question<String>, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }
        
        func stub(resultForQuestions questions: [Question<String>], with viewController: UIViewController) {
            stubbedResults[questions] = viewController
        }
        
        func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubbedQuestions[question] ?? UIViewController()
        }
        
        func resultsViewController(for userAnswers: Answers) -> UIViewController {
            return stubbedResults[userAnswers.map { $0.question }] ?? UIViewController()
        }
    
        func resultsViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
            return UIViewController()
        }
    }
}

private extension UIBarButtonItem {
    func simulateTap() {
        target!.performSelector(onMainThread: action!, with: nil, waitUntilDone: true)

    }
}
