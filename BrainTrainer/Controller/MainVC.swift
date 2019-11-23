//
//  MainVC.swift
//  BrainTrainer
//
//  Created by Macbook Pro 15 on 11/20/19.
//  Copyright © 2019 SamuelFolledo. All rights reserved.
//

import UIKit

enum GameState {
    case title, playing, paused, gameOver
}

enum GameDifficulty {
    case easy, medium, hard
}

class MainVC: UIViewController {
//MARK: Properties
    var gameState: GameState = .playing
    var gameDifficulty: GameDifficulty = .easy
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
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
    @IBOutlet weak var isCorrectImageView: UIImageView!
    
    
//MARK: App LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateCardColor()
    }
    
//MARK: Private Methods
    private func showIsCorrectImageView(isCorrect: Bool) {
        isCorrectImageView.image = isCorrect ? UIImage(named: "correct") : UIImage(named: "wrong")
        isCorrectImageView.isHidden = false
        
    }
    
    private func updateCardColor() {
        topCardView.text = Color()
        topCardView.colorLabel.textColor = .black
        bottomCardView.text = Color()
        bottomCardView.color = Color()
    }
    
    private func setupViews() {
        isCorrectImageView.isHidden = true
    }
    
//MARK: IBActions
    @IBAction func yesButtonTapped(_ sender: Any) {
        if topCardView.text == bottomCardView.color {
            score += 1
            showIsCorrectImageView(isCorrect: true)
        } else {
            score -= 1
            showIsCorrectImageView(isCorrect: false)
        }
        updateCardColor()
    }
    
    @IBAction func noButtonTapped(_ sender: Any) {
        if topCardView.text != bottomCardView.color {
            score += 1
            showIsCorrectImageView(isCorrect: true)
        } else {
            score -= 1
            showIsCorrectImageView(isCorrect: false)
        }
        updateCardColor()
    }
    @IBAction func pauseButtonTapped(_ sender: Any) {
        if gameState == .playing {
            pauseButton.isHidden = false
            pauseButton.setImage(UIImage(named: "pause"), for: .normal)
            gameState = .paused
        } else if gameState == .paused {
            pauseButton.setImage(UIImage(named: "play"), for: .normal)
            gameState = .playing
        } else {
            pauseButton.isHidden = true
        }
    }
    
//MARK: Helper Methods
    
}
