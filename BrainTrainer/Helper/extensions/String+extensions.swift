//
//  String+extensions.swift
//  BrainTrainer
//
//  Created by Macbook Pro 15 on 12/1/19.
//  Copyright © 2019 SamuelFolledo. All rights reserved.
//

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
