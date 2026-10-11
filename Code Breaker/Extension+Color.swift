//
//  Extension+Color.swift
//  Code Breaker
//
//  Created by Jafar Khoshtabiat on 10/11/26.
//

import SwiftUI

extension Color {
    init?(hex: String) {
        let hex = hex
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")

        guard hex.count == 6 || hex.count == 8,
              let value = UInt64(hex, radix: 16)
        else {
            return nil
        }

        let red: Double
        let green: Double
        let blue: Double
        let alpha: Double

        if hex.count == 6 {
            red = Double((value >> 16) & 0xFF) / 255
            green = Double((value >> 8) & 0xFF) / 255
            blue = Double(value & 0xFF) / 255
            alpha = 1
        } else { // RRGGBBAA
            red = Double((value >> 24) & 0xFF) / 255
            green = Double((value >> 16) & 0xFF) / 255
            blue = Double((value >> 8) & 0xFF) / 255
            alpha = Double(value & 0xFF) / 255
        }

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }

    func hexString(
        includeAlpha: Bool = false,
        traits: UITraitCollection = .current
    ) -> String? {
        let color = UIColor(self).resolvedColor(with: traits)

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        guard color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }

        func byte(_ value: CGFloat) -> Int {
            Int((min(max(value, 0), 1) * 255).rounded())
        }

        if includeAlpha {
            return String(
                format: "#%02X%02X%02X%02X",
                byte(red), byte(green), byte(blue), byte(alpha)
            )
        }

        return String(format: "#%02X%02X%02X", byte(red), byte(green), byte(blue))
    }
}
