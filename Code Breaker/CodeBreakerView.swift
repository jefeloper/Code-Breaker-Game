//
//  CodeBreakerView.swift
//  Code Breaker
//
//  Created by Jafar Khoshtabiat on 10/8/26.
//

import SwiftUI

struct CodeBreakerView: View {
    @State var game = CodeBreaker()

    var body: some View {
        VStack {
            self.codeView(for: self.game.masterCode)
            ScrollView {
                self.codeView(for: self.game.guessCode)
                ForEach(self.game.prevAttempts.indices.reversed(), id: \.self) {
                    self.codeView(for: self.game.prevAttempts[$0])
                }
            }
        }
        .padding()
    }

    @ViewBuilder
    func codeView(for code: Code) -> some View {
        let colors = code.alphabets.map { $0.getColor() }
        HStack {
            ForEach(colors.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 15)
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(colors[index])
                    .onTapGesture {
                        guard code.kind == .guessCode else { return }
                        self.game.changeGuessAlphabet(at: index)
                    }
            }
            if code.kind == .guessCode {
                Button("Guess!") {
                    withAnimation {
                        self.game.makeGuess()
                    }
                }
            } else if code.kind == .attemptCode {
                MatchesView(matches: self.game.masterCode.getSortedMatch(against: code))
            }
        }
    }
}

#Preview {
    CodeBreakerView()
}

extension CodeAlphabet {
    func getColor() -> Color {
        switch self.kind {
        case .color(let colorString):
            guard let color = Color(hex: colorString) else { fatalError() }
            return color
        case .toGuess: return Color.gray
        default: fatalError()
        }
    }
}
