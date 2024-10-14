//
//  FlyingNumber.swift
//  Memorize
//
//  Created by Dren Uruqi on 11.10.24.
//

import SwiftUI

struct FlyingNumber: View {
    var number: Int
    
    var body: some View {
        if number != 0 {
            Text(number, format: .number)
        }
    }
}
