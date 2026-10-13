//
//  Code.swift
//  Code Breaker
//
//  Created by Jafar Khoshtabiat on 10/11/26.
//

struct Code {
    var alphabets: [CodeAlphabet]
    let kind: Kind
}

extension Code {
    enum Kind {
        case masterCode
        case guessCode
        case attemptCode
    }

    enum Match {
        case exact
        case inexact
        case nomatch
    }
}

extension Code {
    static func createEmptyGuessCode() -> Code {
        return Code(alphabets: [
            .guessPlaceHolder,
            .guessPlaceHolder,
            .guessPlaceHolder,
            .guessPlaceHolder
        ], kind: .guessCode)
    }
}
