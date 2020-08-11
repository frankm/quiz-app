//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Frank Morales on 7/29/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//

import UIKit
import QuizEngine

final class NavigationControllerRouter: QuizDelegate {
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    func answer(for question: Question<String>, completion: @escaping ([String]) -> Void) {
        switch question {
            case .singleAnswer:
                show(factory.questionViewController(for: question, answerCallback: completion))

            case .multipleAnswer:
                let button = UIBarButtonItem(title: "Submit", style: .done, target: nil, action: nil)
                let buttonController = SubmitButtonController(button, callback: completion)
                let controller = factory.questionViewController(for: question, answerCallback: { selection in buttonController.update(selection)})
                controller.navigationItem.rightBarButtonItem = button
                show(controller)
            }
    }
        
    func didCompleteQuiz(withAnswers answers: [(question: Question<String>, answer: [String])]) {
        show(factory.resultsViewController(for: answers.map { $0 }))
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)

    }
}
// MVC approach
private class SubmitButtonController: NSObject {
    let button: UIBarButtonItem
    let callback: ([String]) -> Void
    private var model = [String]()
    
    init(_ button: UIBarButtonItem, callback: @escaping ([String]) -> Void) {
        self.button = button
        self.callback = callback
        super.init()
        self.setup()
    }
    
    private func setup() {
        button.target = self
        button.action = #selector(fireCallback)
        updateButtonState()
    }
    
    func update(_ model: [String]) {
        self.model = model
        updateButtonState()
    }
    
    private func updateButtonState() {
        button.isEnabled =  model.count > 0
    }
    
    @objc private func fireCallback() {
        callback(model)
    }
}
