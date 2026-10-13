//
//  MatchView.swift
//  Code Breaker
//
//  Created by Jafar Khoshtabiat on 10/13/26.
//

import SwiftUI

struct MatchView: View {
    let match: Code.Match

    var body: some View {
        Circle()
            .fill(match == .exact ? Color.primary : Color.clear)
            .strokeBorder(match == .inexact ? Color.primary : Color.clear, lineWidth: 2)
    }
}

#Preview {
    MatchView(match: .exact)
    MatchView(match: .inexact)
    MatchView(match: .nomatch)
}
