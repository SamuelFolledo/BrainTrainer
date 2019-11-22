//
//  CardView.swift
//  BrainTrainer
//
//  Created by Macbook Pro 15 on 11/20/19.
//  Copyright © 2019 SamuelFolledo. All rights reserved.
//

import UIKit

class CardView: UIView {
    var color: Color
    
    @IBOutlet weak var colorLabel: UILabel!
    
    override init(frame: CGRect) { //for programmatically
        color = Color.init()
        super.init(frame: frame)
        initializeXibFile()
        setupView() //idk why it is required
    }

    required init?(coder aDecoder: NSCoder) {
        color = Color.init()
        super.init(coder: aDecoder)
        initializeXibFile()
        setupView() //required or it won't update colorLabel
    }
    
    func setupView() {
        colorLabel.text = color.text
        colorLabel.textColor = color.textColor
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
