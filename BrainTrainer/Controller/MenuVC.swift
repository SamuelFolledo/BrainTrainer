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
    var tutorial_leftCache: CGFloat!
//MARK: IBOutlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var selectDifficultyLabel: UILabel!
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var easyScoreLabel: UILabel!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var mediumScoreLabel: UILabel!
    @IBOutlet weak var hardButton: UIButton!
    @IBOutlet weak var hardScoreLabel: UILabel!
    @IBOutlet weak var tutorialView: TutorialView!
    @IBOutlet weak var tutorial_left: NSLayoutConstraint!
    
    //MARK: App LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateHighScoreLabels()
        setupLogoImageView()
    }
    
//MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let difficulty: GameDifficulty = sender as? GameDifficulty else { return }
        let gameVC: GameVC = segue.destination as! GameVC
        gameVC.gameDifficulty = difficulty
    }
    
//MARK: Private Methods
    private func setupViews() {
        easyButton.isMenuButton()
        mediumButton.isMenuButton()
        hardButton.isMenuButton()
        tutorial_leftCache = tutorial_left.constant //cache our left constraint
        tutorialView.startButton.addTarget(self, action: #selector(startGame), for: .touchUpInside) //add start method to start button
        tutorialView.backButton.addTarget(self, action: #selector(hideTutorialView), for: .touchUpInside) //add back
    }
    
    private func setupLogoImageView() {
        logoImageView.applyUpAndDownAnimation()
    }
    
    private func updateHighScoreLabels() {
        easyScoreLabel.text = "Highscore: \(UserDefaults.standard.integer(forKey: kEASYHIGHSCORE))"
        mediumScoreLabel.text = "Highscore: \(UserDefaults.standard.integer(forKey: kMEDIUMHIGHSCORE))"
        hardScoreLabel.text = "Highscore: \(UserDefaults.standard.integer(forKey: kHARDHIGHSCORE))"
    }
    
//MARK: IBActions
    @IBAction func easyButtonTapped(_ sender: Any) {
        tutorialView.gameDifficulty = .easy
        showTutorialView()
    }
    
    @IBAction func mediumButtonTapped(_ sender: Any) {
        tutorialView.gameDifficulty = .medium
        showTutorialView()
    }
    
    @IBAction func hardButtonTapped(_ sender: Any) {
        tutorialView.gameDifficulty = .hard
        showTutorialView()
    }
    
//MARK: Helpers
    func showTutorialView() {
        let width = self.view.frame.width
        tutorial_left.constant -= (width - (width / 9)) //subtracting will go left //divided by 9 because its width is safeArea's width / 8
        UIView.animate(withDuration: 0.5) {
            self.configureDifficultyViews(toHide: true)
            self.view.layoutIfNeeded() //Lays out the subviews immediately, if layout updates are pending.
        }
    }
    
    @objc func hideTutorialView() { //so we can addTarget to a view's button
        tutorial_left.constant = tutorial_leftCache //subtracting will go left //divided by 9 because its width is safeArea's width / 8
        UIView.animate(withDuration: 0.5) {
            self.configureDifficultyViews(toHide: false)
            self.view.layoutIfNeeded() //Lays out the subviews immediately, if layout updates are pending.
        }
    }
    
    @objc func startGame() { //so we can addTarget to a view's button
        performSegue(withIdentifier: kTOGAMEVC, sender: tutorialView.gameDifficulty)
    }
    
    func configureDifficultyViews(toHide: Bool) {
        if toHide { //will hide
            selectDifficultyLabel.alpha = 0
            easyButton.alpha = 0
            easyScoreLabel.alpha = 0
            mediumButton.alpha = 0
            mediumScoreLabel.alpha = 0
            hardButton.alpha = 0
            hardScoreLabel.alpha = 0
        } else {
            selectDifficultyLabel.alpha = 1
            easyButton.alpha = 1
            easyScoreLabel.alpha = 1
            mediumButton.alpha = 1
            mediumScoreLabel.alpha = 1
            hardButton.alpha = 1
            hardScoreLabel.alpha = 1
        }
    }
}
