//
//  CodeBreaker.swift
//  Code Breaker
//
//  Created by Jafar Khoshtabiat on 10/10/26.
//

import Foundation

struct CodeBreaker {
    let masterCode: Code = .init(alphabets: [
        .purple,
        .green,
        .orange,
        .purple
    ], kind: .masterCode)
    var guessCode: Code = .init(alphabets: [
        .guessPlaceHolder,
        .guessPlaceHolder,
        .guessPlaceHolder,
        .guessPlaceHolder
    ], kind: .guessCode)
    let prevAttempts: [Code] = []

    let alphabet: Set<CodeAlphabet> = [
        .green,
        .blue,
        .yellow,
        .orange,
        .purple,
        .red
    ]

    lazy var arrayAlphabet: [CodeAlphabet] = Array(self.alphabet)

    mutating func getShfitedCodeAlphabet(for codeAlphabet: CodeAlphabet) -> CodeAlphabet {
        guard let index = arrayAlphabet.firstIndex(of: codeAlphabet) else { return arrayAlphabet.first ?? CodeAlphabet.guessPlaceHolder }
        let shiftedIndex = (index + 1) % alphabet.count
        return arrayAlphabet[shiftedIndex]
    }

    mutating func changeGuessAlphabet(at index: Int) {
        guessCode.alphabets[index] = getShfitedCodeAlphabet(for: guessCode.alphabets[index])
    }
}
