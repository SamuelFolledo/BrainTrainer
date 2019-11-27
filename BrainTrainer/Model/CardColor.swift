//
//  CardColor.swift
//  BrainTrainer
//
//  Created by Macbook Pro 15 on 11/25/19.
//  Copyright © 2019 SamuelFolledo. All rights reserved.
//

import UIKit

enum CardColor {
    case white, black, green, red
    
    var color: UIColor {
        switch self {
        case .white:
            return .white
        case .black:
            return .black
        case .green:
            return .green
        case .red:
            return .red
        }
    }
    
    init() {
        self = CardColor.allCases[Int(arc4random_uniform(UInt32(CardColor.allCases.count)))]
    }
    
    func getCardColorAsTuple() -> (white:Bool, black:Bool, green:Bool, red:Bool) {
        switch self {
        case .white:
            return (white:true, black:false, green:false, red:false)
        case .black:
            return (white:false, black:true, green:false, red:false)
        case .green:
            return (white:false, black:false, green:true, red:false)
        case .red:
            return (white:false, black:false, green:false, red:true)
        }
    }
}

extension CardColor: CaseIterable {
    mutating func getRandomColor() { //updates color to a random Color from all Color cases //CaseIterable allows me to use the allCases typeProperty
        self = CardColor.allCases[Int(arc4random_uniform(UInt32(CardColor.allCases.count)))]
    }
}
