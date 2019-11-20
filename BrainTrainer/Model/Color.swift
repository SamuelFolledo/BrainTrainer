//
//  Color.swift
//  BrainTrainer
//
//  Created by Macbook Pro 15 on 11/20/19.
//  Copyright © 2019 SamuelFolledo. All rights reserved.
//

import UIKit

enum Color {
    case red, orange, yellow, green, blue, purple
    
    var currentColor: UIColor {
        switch self {
        case .red:
            return .red
        case .orange:
            return .orange
        case .yellow:
            return .yellow
        case .green:
            return .green
        case .blue:
            return .blue
        case .purple:
            return .purple
        }
    }
}

extension Color: CaseIterable {
    mutating func updateAsRandomColor() { //updates color to a random Color from all Color cases //CaseIterable allows me to use the allCases typeProperty
        self = Color.allCases[Int(arc4random_uniform(UInt32(Color.allCases.count)))]
    }
}
