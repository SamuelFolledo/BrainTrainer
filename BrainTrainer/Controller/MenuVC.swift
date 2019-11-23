//
//  MenuVC.swift
//  BrainTrainer
//
//  Created by Macbook Pro 15 on 11/22/19.
//  Copyright © 2019 SamuelFolledo. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {
//MARK: Properties
    
//MARK: IBOutlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var easyButton: UIButton!
    
    @IBOutlet weak var easyScoreLabel: UILabel!
    @IBOutlet weak var mediumButton: UIButton!
    
    @IBOutlet weak var mediumScoreLabel: UILabel!
    @IBOutlet weak var hardButton: UIButton!
    
    @IBOutlet weak var hardScoreLabel: UILabel!
    
//MARK: App LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
//MARK: Private Methods
    
//MARK: IBActions
    @IBAction func easyButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: kTOGAMEVC, sender: nil)
    }
    
    @IBAction func mediumButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: kTOGAMEVC, sender: nil)
    }
    
    @IBAction func hardButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: kTOGAMEVC, sender: nil)
    }
    
//MARK: Helpers
    
}
