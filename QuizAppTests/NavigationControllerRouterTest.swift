//
//  NavigationControllerRouterTest.swift
//  QuizAppTests
//
//  Created by Frank Morales on 7/29/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//

import XCTest
import QuizEngine
@testable import QuizApp

class NavigationControllerRouterTest: XCTestCase {
    
    let navigationController = NonAnimatedNavigationController()
    let factory = ViewControllerFactoryStub()
    lazy var sut: NavigationControllerRouter = {
        return NavigationControllerRouter(navigationController, factory: factory)
    }()

    func test_routeTo2Question_showsQuestionController() {
        let vc1 = UIViewController()
        let vc2 = UIViewController()
        factory.stub(question: Question.singleAnswer("Q1"), with: vc1)
        factory.stub(question: Question.singleAnswer("Q2"), with: vc2)
        
        sut.routeTo(question: Question.singleAnswer("Q1"), answerCallback: { _ in })
        sut.routeTo(question: Question.singleAnswer("Q2"), answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, vc1)
        XCTAssertEqual(navigationController.viewControllers.last, vc2)
    }
    
    func test_routeToQuestion_presentsQuestionControllerWithRightCallback() {
        var callbackWasFired = false
        sut.routeTo(question: Question.singleAnswer("Q1"), answerCallback: { _ in callbackWasFired = true })
        
        factory.answerCallback[Question.singleAnswer("Q1")]!(["anything"])
        
        XCTAssertTrue(callbackWasFired)
    }
    
    func test_routeToResult_showsResultController() {
        let vc1 = UIViewController()
        let vc2 = UIViewController()
        let result1 = Result(answers: [Question.singleAnswer("Q1"): ["A1"]], score: 10)
        let result2 = Result(answers: [Question.singleAnswer("Q2"): ["A2"]], score: 20)

        factory.stub(result: result1, with: vc1)
        factory.stub(result: result2, with: vc2)

        sut.routeTo(result: result1)
        sut.routeTo(result: result2)

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
        private var stubbedResults = Dictionary<Result<Question<String>, [String]>, UIViewController>()
        var answerCallback = Dictionary<Question<String>, ([String]) -> Void>()

        func stub(question: Question<String>, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }
        
        func stub(result: Result<Question<String>, [String]>, with viewController: UIViewController) {
            stubbedResults[result] = viewController
        }
        
        func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubbedQuestions[question] ?? UIViewController()
        }
        
        func resultsViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
            return stubbedResults[result] ?? UIViewController()
        }
    }
}

extension Result: Hashable {
    init(answers: [Question: Answer], score: Int) {
        self.answers = answers
        self.score = score
    }
    
    public var hashValue: Int {
        return 1
    }
    
    public static func ==(lhs: Result<Question, Answer>, rhs: Result<Question, Answer>) -> Bool {
        return lhs.score == rhs.score
    }
}
