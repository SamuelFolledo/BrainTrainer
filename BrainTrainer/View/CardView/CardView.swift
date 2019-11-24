//
//  CardView.swift
//  BrainTrainer
//
//  Created by Macbook Pro 15 on 11/20/19.
//  Copyright © 2019 SamuelFolledo. All rights reserved.
//

import UIKit

class CardView: UIView {
    var color: Color {
        didSet {
            colorLabel.textColor = color.textColor
        }
    }
    
    var text: Color {
        didSet {
            colorLabel.text = text.text
        }
    }
    
    
    @IBOutlet weak var colorLabel: UILabel!
    
    override init(frame: CGRect) { //for programmatically
        color = Color()
        text = Color()
        super.init(frame: frame)
        initializeXibFile()
        setupView() //idk why it is required
    }

    required init?(coder aDecoder: NSCoder) {
        color = Color()
        text = Color()
        super.init(coder: aDecoder)
        initializeXibFile()
        setupView() //required or it won't update colorLabel
    }
    
    func setupView() {
        colorLabel.text = text.text
        colorLabel.textColor = color.textColor
        colorLabel.shadowColor = .none
        self.applyShadow()
    }

    func initializeXibFile() {
        let bundle = Bundle.init(for: CardView.self)
        if let viewsToAdd = bundle.loadNibNamed("CardView", owner: self, options: nil), let contentView = viewsToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleHeight,
                                            .flexibleWidth]
        }
    }
}
