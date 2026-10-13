//
//  Code.swift
//  Code Breaker
//
//  Created by Jafar Khoshtabiat on 10/11/26.
//

struct Code {
    var alphabets: [CodeAlphabet]
    let kind: Kind

    func getMatch(against otherCode: Code) -> [Match] {
        var result = [Match](repeating: .nomatch, count: self.alphabets.count)
        var pegsToMatch = otherCode.alphabets
        for (index, item) in self.alphabets.enumerated().reversed() {
            if pegsToMatch.count > index, pegsToMatch[index] == item {
                result[index] = .exact
                pegsToMatch.remove(at: index)
            }
        }
        for (index, item) in result.enumerated() where item != .exact {
            if let inexactIndex = pegsToMatch.firstIndex(of: self.alphabets[index]) {
                result[index] = .inexact
                pegsToMatch.remove(at: inexactIndex)
            }
        }
        return result
    }

    func getSortedMatch(against otherCode: Code) -> [Match] {
        let result = self.getMatch(against: otherCode)

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
