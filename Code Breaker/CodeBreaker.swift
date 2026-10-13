//
//  CodeBreaker.swift
//  Code Breaker
//
//  Created by Jafar Khoshtabiat on 10/10/26.
//

import Foundation

struct CodeBreaker {
    let masterCode = Code(alphabets: [
        .purple,
        .green,
        .orange,
        .purple
    ], kind: .masterCode)
    var guessCode = Code.createEmptyGuessCode()
    var prevAttempts: [Code] = []

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

    mutating func makeGuess() {
        prevAttempts.append(Code(alphabets: guessCode.alphabets, kind: .attemptCode))
        guessCode = Code.createEmptyGuessCode()
    }

    func getMatch(against code: Code) -> [Code.Match] {
        guard code.kind == .attemptCode else { return [] }
        var result = [Code.Match](repeating: .nomatch, count: masterCode.alphabets.count)
        var pegsToMatch = code.alphabets
        for (index, item) in masterCode.alphabets.enumerated().reversed() {
            if pegsToMatch.count > index, pegsToMatch[index] == item {
                result[index] = .exact
                pegsToMatch.remove(at: index)
            }
        }
        for (index, item) in result.enumerated() where item != .exact {
            if let inexactIndex = pegsToMatch.firstIndex(of: self.masterCode.alphabets[index]) {
                result[index] = .inexact
                pegsToMatch.remove(at: inexactIndex)
            }
        }
        return result
    }

    func getSortedMatch(against otherCode: Code) -> [Code.Match] {
        let result = getMatch(against: otherCode)

        return result.sorted {
            switch ($0, $1) {
            case (.exact, _): return true
            case (_, .nomatch): return true
            case (.nomatch, _): return false
            case (_, .exact): return false
            default: return true
            }
        }
    }
}
