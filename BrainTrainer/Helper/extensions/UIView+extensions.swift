//
//  UIView+extensions.swift
//  BrainTrainer
//
//  Created by Macbook Pro 15 on 11/23/19.
//  Copyright © 2019 SamuelFolledo. All rights reserved.
//

import UIKit

extension UIView {
    func applyUpAndDownAnimation() {
        UIView.animate(withDuration: 1, animations: {
//            self.backgroundColor = .brown
            self.frame.size.width += 10
            self.frame.size.height += 10
        }) { _ in
            UIView.animate(withDuration: 1, delay: 0.25, options: [.autoreverse, .repeat], animations: { //makes a repeating animation that goes back and forth
                self.frame.origin.y -= 20
            })
        }
    }
    
    func fadeIn(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
          self.alpha = 1.0
      })
    }
    func fadeOut(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
          self.alpha = 0.0
      })
    }
    
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
