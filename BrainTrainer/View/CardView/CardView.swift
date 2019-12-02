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
    var cardColor: CardColor {
        didSet {
            backgroundView.backgroundColor = cardColor.color
            switch cardColor {
            case .white, .green, .red:
                while colorLabel.textColor == cardColor.color { //Error check: we dont want the colorLabel's textColor to be the same as the background, so we will update color to a new Color which will update the colorLabel's textColor
                    color = Color()
                }
            case .black:
                if colorLabel.textColor == cardColor.color { //we need this check because we do not want to change bottom card's textColor to be white
                    colorLabel.textColor = .white
                }
            }
        }
    }
//MARK: IBOutlets
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var colorLabel: UILabel!
    
    override init(frame: CGRect) { //for programmatically
        cardColor = CardColor.white
        color = Color()
        text = Color()
        super.init(frame: frame)
        initializeXibFile()
        setupView() //idk why it is required
    }

    required init?(coder aDecoder: NSCoder) {
        cardColor = CardColor.white
        color = Color()
        text = Color()
        super.init(coder: aDecoder)
        initializeXibFile()
        setupView() //required or it won't update colorLabel
    }
    
    func setupView() {
        backgroundView.backgroundColor = cardColor.color
        colorLabel.text = text.text
        colorLabel.textColor = color.textColor
        self.isOpaque = false
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
