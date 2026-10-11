//
//  Code.swift
//  Code Breaker
//
//  Created by Jafar Khoshtabiat on 10/11/26.
//

struct Code {
    let alphabets: [CodeAlphabet]
    let kind: Kind
}

extension Code {
    enum Kind {
        case masterCode
        case guessCode
        case attemptCode
    }
}
