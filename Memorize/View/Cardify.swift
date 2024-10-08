//
//  Cardify.swift
//  Memorize
//
//  Created by Dren Uruqi on 3.10.24.
//

import SwiftUI

struct Cardify: ViewModifier {
    let isFacedUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let rectangle = RoundedRectangle(cornerRadius: Constants.cornerRadius)
                rectangle.strokeBorder(lineWidth: Constants.lineWidth)
                .background(rectangle.fill(.white))
                .overlay(content)
                .opacity(isFacedUp ? 1 : 0)
            rectangle.fill()
                .opacity(isFacedUp ? 0 : 1)
        }
    }
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
    }
}

extension View {
    func cardify(isFacedUp: Bool) -> some View {
        modifier(Cardify(isFacedUp: isFacedUp))
    }
}
