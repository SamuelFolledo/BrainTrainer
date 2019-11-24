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
    var gameDifficulty: GameDifficulty! {
        didSet {
            switch gameDifficulty {
            case .easy:
                maxTime = 5
            case .medium:
                maxTime = 3
            case .hard:
                maxTime = 3
            case .none:
                break
            }
        }
    }
    var maxTime: Double!
    var timer: Timer!
    var timerCounter: Double = 0 {
        didSet {
            timeLabel.text = "\(String(format: "%.1f", timerCounter))" //round up to 1 decimal place
            if timerCounter <= 0 {
                timer?.invalidate()
                gameOver()
            }
        }
    }
    var currentHighScore: Int! {
        didSet {
            switch gameDifficulty {
            case .easy:
                UserDefaults.standard.set(self.currentHighScore, forKey: kEASYHIGHSCORE)
            case .medium:
                UserDefaults.standard.set(self.currentHighScore, forKey: kMEDIUMHIGHSCORE)
            case .hard:
                UserDefaults.standard.set(self.currentHighScore, forKey: kHARDHIGHSCORE)
            case .none:
                break
            }
            UserDefaults.standard.synchronize() //refresh UserDefaults
        }
    }
    var highScore: Int! {
        get {
            switch gameDifficulty {
            case .easy:
                return UserDefaults.standard.integer(forKey: kEASYHIGHSCORE)
            case .medium:
                return UserDefaults.standard.integer(forKey: kMEDIUMHIGHSCORE)
            case .hard:
                return UserDefaults.standard.integer(forKey: kHARDHIGHSCORE)
            case .none:
                break
            }
            return 0
        }
    }
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
            if score % 3 == 0 && maxTime > 1 { //everytime user scores 3 points, reduce the time. maxTime will not go lower than 1 seconds
                maxTime -= 0.1
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
        if score > highScore {
            currentHighScore = score //score is now our new high score
        }
        dismiss(animated: true, completion: nil)
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
