//
//  DeprecatedGame.swift
//  QuizEngine
//
//  Created by Frank Morales on 7/26/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//

import Foundation

@available(*, deprecated, message: "use QuizDelegate instead")
public protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer

    typealias AnswerCallback = (Answer) -> Void
    func routeTo(question: Question, answerCallback: @escaping AnswerCallback)
    func routeTo(result: Result<Question, Answer>)
}

@available(*, deprecated, message: "scoring won't be supported in the future")
public struct Result<Question: Hashable, Answer> {
    public let answers: [Question: Answer]
    public let score: Int
}

@available(*, deprecated, message: "use Quiz instead")
public class Game<Question, Answer, R: Router> {
    let quiz: Quiz
    
    init(quiz: Quiz) {
        self.quiz = quiz
    }
}

@available(*, deprecated, message: "use Quiz.start instead")
public func startGame<Question, Answer: Equatable, R: Router>(questions: [Question], router: R, correctAnswers: [Question: Answer]) -> Game<Question, Answer, R> where R.Question == Question, R.Answer == Answer {
    let adapter = QuizDelegateToRouterAdapter(router, correctAnswers)
    let quiz = Quiz.start(questions: questions, delegate: adapter)
    return Game(quiz: quiz)
}

@available(*, deprecated, message: "remove along with deprecated Game types")
private class QuizDelegateToRouterAdapter<R: Router>: QuizDelegate where R.Answer: Equatable {
    private let router: R
    private let correctAnswers: [R.Question: R.Answer]
    
    init(_ router: R, _ correctAnswers: [R.Question: R.Answer]) {
        self.router = router
        self.correctAnswers = correctAnswers
    }

    func answer(for question: R.Question, completion: @escaping (R.Answer) -> Void) {
        router.routeTo(question: question, answerCallback: completion)
    }
    
    func didCompleteQuiz(withAnswers answers: [(question: R.Question, answer: R.Answer)]) {
        let completedAnswers = answers.reduce([R.Question: R.Answer]()) { acc, tuple in
            var acc = acc
            acc[tuple.question] = tuple.answer
            return acc
        }
        let score = scoring(completedAnswers, correctAnswers: correctAnswers)
        let result = Result(answers: completedAnswers, score: score)
        router.routeTo(result: result)
    }
    
    private func scoring(_ answers: [R.Question: R.Answer], correctAnswers: [R.Question: R.Answer]) -> Int {
        return answers.reduce(0) { (score, tuple) in
            return score + (correctAnswers[tuple.key] == tuple.value ? 1 : 0)
        }
    }
    
}
