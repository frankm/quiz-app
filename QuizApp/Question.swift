//
//  Question.swift
//  QuizApp
//
//  Created by Frank Morales on 7/29/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//

import Foundation

public enum Question<T: Hashable> : Hashable {
    case singleAnswer(T)
    case multipleAnswer(T)
    
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .singleAnswer(let value):
            hasher.combine(value)
        case .multipleAnswer(let value):
            hasher.combine(value)
        }
    }
}
