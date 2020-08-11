//
//  Quiz.swift
//  QuizEngine
//
//  Created by Frank Morales on 8/7/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//

import Foundation

public final class Quiz {
    private let flow: Any
    
    init(flow: Any) {
        self.flow = flow
    }
    
    public static func start<Delegate: QuizDelegate>(
        questions: [Delegate.Question],
        delegate: Delegate) -> Quiz where Delegate.Answer: Equatable {
        let flow = Flow(questions: questions, delegate: delegate)
        flow.start()
        return Quiz(flow: flow)
    }
}

