//
//  FlyingNumber.swift
//  Memorize
//
//  Created by Dren Uruqi on 11.10.24.
//

import SwiftUI

struct FlyingNumber: View {
    var number: Int
    @State private var offset: CGFloat = 0
    
    var body: some View {
        if number != 0 {
            Text(number, format: .number.sign(strategy: .always()))
                .font(.largeTitle)
                .foregroundStyle(number > 0 ? .green : .red)
                .shadow(color: .black, radius: 1.5, x: 1, y: 1)
                .offset(x: 0, y: offset)
                .opacity(offset != 0 ? 0 : 1)
                .onAppear {
                    withAnimation(.easeIn(duration: 2)) {
                        offset = number > 0 ? -200 : 200
                    }
                }
                .onDisappear {
                    offset = 0
                }
        }
    }
}
