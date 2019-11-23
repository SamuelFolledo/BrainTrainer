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
    var timer: Timer?
    var timerCounter: Int = 5 {
        didSet {
            timeLabel.text = "0\(timerCounter)"
            if timerCounter == 0 {
                timer?.invalidate()
                self.dismiss(animated: true, completion: nil)
            }
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
    
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
    
//MARK: Private Methods
    private func evaluateAnswer(isYes: Bool) {
        if (topCardView.text == bottomCardView.color && isYes) || (topCardView.text != bottomCardView.color && !isYes) {
            score += 1
            showIsCorrectImageView(isCorrect: true)
            timerCounter = 5
        } else {
            score -= 1
            showIsCorrectImageView(isCorrect: false)
            self.dismiss(animated: true, completion: nil)
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
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateGameTimer), userInfo: nil, repeats: true) //Once the round is ready, start the timer
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
    @objc func updateGameTimer() {
        timerCounter -= 1
    }
}
