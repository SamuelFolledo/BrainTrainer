//
//  MainVC.swift
//  BrainTrainer
//
//  Created by Macbook Pro 15 on 11/20/19.
//  Copyright © 2019 SamuelFolledo. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
//MARK: Properties
    var score = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }
    
//MARK: IBOutlets
    @IBOutlet weak var topCardView: CardView!
    @IBOutlet weak var bottomCardView: CardView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    
//MARK: App LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCardColor()
    }
    
//MARK: Private Methods
    private func updateCardColor() {
        topCardView.text = Color()
        topCardView.colorLabel.textColor = .black
        bottomCardView.text = Color()
        bottomCardView.textColor = Color()
    }
    
//MARK: IBActions
    
    
    @IBAction func yesButtonTapped(_ sender: Any) {
        if topCardView.text == bottomCardView.textColor {
            score += 1
        } else {
            score -= 1
        }
        updateCardColor()
    }
    
    @IBAction func noButtonTapped(_ sender: Any) {
        if topCardView.text != bottomCardView.textColor {
            score += 1
        } else {
            score -= 1
        }
        updateCardColor()
    }
    @IBAction func pauseButtonTapped(_ sender: Any) {
    }
    
//MARK: Helper Methods
    
}
