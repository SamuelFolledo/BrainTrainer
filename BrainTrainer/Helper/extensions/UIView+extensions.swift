//
//  UIView+extensions.swift
//  BrainTrainer
//
//  Created by Macbook Pro 15 on 11/23/19.
//  Copyright © 2019 SamuelFolledo. All rights reserved.
//

import UIKit

extension UIView {
    func applyShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 10
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
