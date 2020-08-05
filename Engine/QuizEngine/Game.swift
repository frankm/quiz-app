//
//  Game.swift
//  QuizEngine
//
//  Created by Frank Morales on 7/26/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//

import Foundation

public class Game<Question, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    let flow: Flow<Question, Answer, R>
    
    init(flow: Flow<Question, Answer, R>) {
        self.flow = flow
    }
}

public func startGame<Question, Answer: Equatable, R: Router>(questions: [Question], router: R, correctAnswers: [Question: Answer]) -> Game<Question, Answer, R> {
    
    let flow = Flow(questions: questions, router: router,  scoring: { scoring($0, correctAnswers: correctAnswers)})
    flow.start()
    return Game(flow: flow)
}

private func scoring<Question, Answer:Equatable>(_ answers: [Question: Answer], correctAnswers: [Question: Answer]) -> Int {
    
    return answers.reduce(0) { (score, tuple) in
        return score + (correctAnswers[tuple.key] == tuple.value ? 1 : 0)
    }
}
