//
//  CodeBreaker.swift
//  Code Breaker
//
//  Created by Jafar Khoshtabiat on 10/10/26.
//

import Foundation

struct CodeBreaker {
    let masterCode: Code
    let guessCode: Code
    let prevAttempts: [Code]
}

struct Code {
    let alphabets: [CodeAlphabet]
}

extension Code {
    enum Kind {
        case masterCode
        case guessCode
        case attemptCode
    }
}

struct CodeAlphabet {}
