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
        topCardView.color.getRandomColor()
        bottomCardView.color.getRandomColor()
        // Do any additional setup after loading the view.
    }
    
//MARK: Private Methods
    private func updateColor() {
        topCardView.color = Color.init()
        
        bottomCardView.color = Color.init()
    }
    
//MARK: IBActions
    
    
    @IBAction func yesButtonTapped(_ sender: Any) {
        updateColor()
    }
    
    @IBAction func noButtonTapped(_ sender: Any) {
        updateColor()
    }
    @IBAction func pauseButtonTapped(_ sender: Any) {
    }
    
//MARK: Helper Methods
    
}
