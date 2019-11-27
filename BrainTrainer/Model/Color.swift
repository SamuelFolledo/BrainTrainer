//
//  Color.swift
//  BrainTrainer
//
//  Created by Macbook Pro 15 on 11/20/19.
//  Copyright © 2019 SamuelFolledo. All rights reserved.
//

import UIKit

protocol ColorProtocol {
    
}

enum Color {
    case red, orange, yellow, green, blue, purple
    
    var textColor: UIColor {
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
    
    var text: String {
        switch self {
        case .red:
            return "red"
        case .orange:
            return "orange"
        case .yellow:
            return "yellow"
        case .green:
            return "green"
        case .blue:
            return "blue"
        case .purple:
            return "purple"
        }
    }
    
    init() {
        self = Color.allCases[Int(arc4random_uniform(UInt32(Color.allCases.count)))]
    }
}

extension Color: CaseIterable {
    mutating func getRandomColor() { //updates color to a random Color from all Color cases //CaseIterable allows me to use the allCases typeProperty
        self = Color.allCases[Int(arc4random_uniform(UInt32(Color.allCases.count)))]
    }
}

//extension Color: Equatable {
//    static func ==(lhs: Color, rhs: Color) -> Bool { //checks if Colors instances are the same
//        return lhs.text == rhs.text
//    }
//}
