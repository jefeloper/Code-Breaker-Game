//
//  CodeAlphabet.swift
//  Code Breaker
//
//  Created by Jafar Khoshtabiat on 10/11/26.
//

struct CodeAlphabet: Hashable {
    let kind: Kind
}

extension CodeAlphabet {
    static let green = CodeAlphabet(kind: .color(CodeBreakerColor.green))
    static let blue = CodeAlphabet(kind: .color(CodeBreakerColor.blue))
    static let yellow = CodeAlphabet(kind: .color(CodeBreakerColor.yellow))
    static let orange = CodeAlphabet(kind: .color(CodeBreakerColor.orange))
    static let purple = CodeAlphabet(kind: .color(CodeBreakerColor.purple))
    static let red = CodeAlphabet(kind: .color(CodeBreakerColor.red))
    static let guessPlaceHolder = CodeAlphabet(kind: .toGuess)
}

extension CodeAlphabet {
    enum Kind: Equatable, Hashable {
        case letter(String)
        case color(String)
        case toGuess
    }
}
