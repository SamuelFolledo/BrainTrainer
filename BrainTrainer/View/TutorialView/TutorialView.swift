//
//  TutorialView.swift
//  BrainTrainer
//
//  Created by Macbook Pro 15 on 11/28/19.
//  Copyright © 2019 SamuelFolledo. All rights reserved.
//

import UIKit

class TutorialView: UIView {
    
    
//MARK: IBOutlets
    @IBOutlet weak var easyInstructionLabel: UILabel!
    @IBOutlet weak var mediumInstructionLabel: UILabel!
    @IBOutlet weak var hardInstructionLabel: UILabel!
    @IBOutlet weak var easyStackView: UIStackView!
    @IBOutlet weak var mediumStackView: UIStackView!
    @IBOutlet weak var hardStackView: UIStackView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    
    override init(frame: CGRect) { //for programmatically
        super.init(frame: frame)
        initializeXibFile()
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeXibFile()
        setupView() //required or it won't update colorLabel
    }
    
    func setupView() {
        easyInstructionLabel.text = "Easy"
        mediumInstructionLabel.text = "Medium"
        hardInstructionLabel.text = "Hard"
        startButton.setTitle("Start", for: .normal)
        startButton.isMenuButton()
        backButton.setTitle("Back", for: .normal)
        backButton.isMenuButton()
        
        self.isOpaque = false
        self.applyShadow()
    }

    func initializeXibFile() {
        let bundle = Bundle.init(for: CardView.self)
        if let viewsToAdd = bundle.loadNibNamed("TutorialView", owner: self, options: nil), let contentView = viewsToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleHeight,
                                            .flexibleWidth]
        }
    }
}

