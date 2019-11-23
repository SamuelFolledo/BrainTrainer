//
//  GameVC.swift
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

class GameVC: UIViewController {
//MARK: Properties
    var gameState: GameState = .playing
    var gameDifficulty: GameDifficulty!
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    let correctImage: UIImage = UIImage(named: "correct")!
    let wrongImage: UIImage = UIImage(named: "wrong")!
    let pauseImage: UIImage = UIImage(named: "pause")!
    let playImage: UIImage = UIImage(named: "play")!
    
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
        print(gameDifficulty)
    }
    
//MARK: Private Methods
    private func evaluateAnswer(isYes: Bool) {
        if (topCardView.text == bottomCardView.color && isYes) || (topCardView.text != bottomCardView.color && !isYes) {
            score += 1
            showIsCorrectImageView(isCorrect: true)
        } else {
            score -= 1
            showIsCorrectImageView(isCorrect: false)
        }
        updateCardColor()
    }
    
    private func showIsCorrectImageView(isCorrect: Bool) {
        isCorrectImageView.image = isCorrect ? correctImage : wrongImage
        isCorrectImageView.isHidden = false
        isCorrectImageView.enlargeThenShrinkAnimation()
    }
    
    private func updateCardColor() {
        topCardView.text = Color()
        topCardView.colorLabel.textColor = .black
        bottomCardView.text = Color()
        bottomCardView.color = Color()
    }
    
    private func setupViews() {
        isCorrectImageView.isHidden = true
        isCorrectImageView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
    }
    
//MARK: IBActions
    @IBAction func yesButtonTapped(_ sender: Any) {
        evaluateAnswer(isYes: true)
    }
    
    @IBAction func noButtonTapped(_ sender: Any) {
        evaluateAnswer(isYes: false)
    }
    @IBAction func pauseButtonTapped(_ sender: Any) {
        if pauseButton.image(for: .normal) == playImage {
            pauseButton.setImage(pauseImage, for: .normal)
            gameState = .playing
        } else {
            pauseButton.setImage(playImage, for: .normal)
            gameState = .paused
        }
    }
    
//MARK: Helper Methods
    
}
