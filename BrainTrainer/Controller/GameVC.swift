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
    var maxTime: Int!
    var timer: Timer!
    var timerCounter: Int = 0 {
        didSet {
            timeLabel.text = "0\(timerCounter)"
            if timerCounter == 0 {
                timer?.invalidate()
                gameOver()
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
            timerCounter = maxTime
            updateCardColor()
        } else {
//            score -= 1
            showIsCorrectImageView(isCorrect: false)
            gameOver()
        }
    }
    
    private func gameOver() {
        checkHighScore() {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func checkHighScore(completion: @escaping () -> Void) {
        switch gameDifficulty {
        case .easy:
            let highScore = UserDefaults.standard.integer(forKey: kEASYHIGHSCORE)
            if self.score > highScore {
                UserDefaults.standard.set(self.score, forKey: kEASYHIGHSCORE)
            }
        case .medium:
            let highScore = UserDefaults.standard.integer(forKey: kMEDIUMHIGHSCORE)
            if self.score > highScore {
                UserDefaults.standard.set(self.score, forKey: kMEDIUMHIGHSCORE)
            }
        case .hard:
            let highScore = UserDefaults.standard.integer(forKey: kHARDHIGHSCORE)
            if self.score > highScore {
               UserDefaults.standard.set(self.score, forKey: kHARDHIGHSCORE)
            }
        case .none:
            break
        }
        UserDefaults.standard.synchronize() //set the high score
        completion()
    }
    
    private func showIsCorrectImageView(isCorrect: Bool) {
        isCorrectImageView.image = isCorrect ? kCORRECTIMAGE : kWRONGIMAGE
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
        switch gameDifficulty {
        case .easy:
            maxTime = 5
        case .medium:
            maxTime = 3
        case .hard:
            maxTime = 2
        case .none:
            break
        }
        pauseButton.applyShadow()
        timerCounter = maxTime
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
        if pauseButton.image(for: .normal) == kPLAYIMAGE {
            pauseButton.setImage(kPAUSEIMAGE, for: .normal)
            gameState = .playing
        } else {
            pauseButton.setImage(kPLAYIMAGE, for: .normal)
            gameState = .paused
        }
    }
    
//MARK: Helper Methods
    @objc func updateGameTimer() {
        timerCounter -= 1
    }
}
