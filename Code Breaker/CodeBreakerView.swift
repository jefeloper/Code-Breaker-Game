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
            self.codeView(for: self.game.guessCode)
            ScrollView {
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
            switch code.kind {
            case .masterCode: Circle().foregroundStyle(.clear)
            case .guessCode: self.guessButton
            case .attemptCode: MatchesView(matches: self.game.getSortedMatch(against: code))
            }
        }
    }

    var guessButton: some View {
        Button("Guess!") {
            withAnimation {
                self.game.makeGuess()
            }
        }
        .font(.system(size: 80))
        .minimumScaleFactor(0.1)
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
