//
//  QuestionPresenter.swift
//  QuizApp
//
//  Created by Frank Morales on 7/31/20.
//  Copyright © 2020 Practice Swift. All rights reserved.
//

import Foundation
import QuizEngine

struct QuestionPresenter {
    let questions: [Question<String>]
    let question: Question<String>
    
    var title: String? {
        guard let index = questions.index(of: question) else { return "" }
        return "Question #\(index + 1)"
    }
    
}
