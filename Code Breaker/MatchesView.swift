//
//  MatchesView.swift
//  Code Breaker
//
//  Created by Jafar Khoshtabiat on 10/13/26.
//

import SwiftUI

struct MatchesView: View {
    let matches: [Code.Match]

    var body: some View {
        VStack {
            HStack {
                MatchView(match: self.matches[0])
                MatchView(match: self.matches[1])
            }
            HStack {
                MatchView(match: self.matches[2])
                MatchView(match: self.matches[3])
            }
        }
    }
}

#Preview {
    MatchesView(matches: [
        .exact, .exact, .inexact, .nomatch
    ])
}
