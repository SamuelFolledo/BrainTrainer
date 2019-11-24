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
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateHighScoreLabels()
    }
    
//MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let difficulty: GameDifficulty = sender as? GameDifficulty else { return }
        let gameVC: GameVC = segue.destination as! GameVC
        gameVC.gameDifficulty = difficulty
    }
    
//MARK: Private Methods
    private func setupViews() {
        easyButton.isDifficultyButton()
        mediumButton.isDifficultyButton()
        hardButton.isDifficultyButton()
        setupLogoImageView()
    }
    
    private func setupLogoImageView() {
        UIView.animate(withDuration: 1, animations: {
//            self.logoImageView.backgroundColor = .brown
            self.logoImageView.frame.size.width += 10
            self.logoImageView.frame.size.height += 10
        }) { _ in
            UIView.animate(withDuration: 1, delay: 0.25, options: [.autoreverse, .repeat], animations: { //makes a repeating animation that goes back and forth
                self.logoImageView.frame.origin.y -= 20
            })
        }
    }
    
    private func updateHighScoreLabels() {
        easyScoreLabel.text = "Highscore: \(UserDefaults.standard.integer(forKey: kEASYHIGHSCORE))"
        mediumScoreLabel.text = "Highscore: \(UserDefaults.standard.integer(forKey: kMEDIUMHIGHSCORE))"
        hardScoreLabel.text = "Highscore: \(UserDefaults.standard.integer(forKey: kHARDHIGHSCORE))"
    }
    
//MARK: IBActions
    @IBAction func easyButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: kTOGAMEVC, sender: GameDifficulty.easy)
    }
    
    @IBAction func mediumButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: kTOGAMEVC, sender: GameDifficulty.medium)
    }
    
    @IBAction func hardButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: kTOGAMEVC, sender: GameDifficulty.hard)
    }
    
//MARK: Helpers
    
}
