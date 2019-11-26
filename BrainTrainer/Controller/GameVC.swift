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
    var gameState: GameState! {
        didSet {
            switch gameState {
            case .title:
                gameTitle()
            case .playing:
                playGame()
            case .paused:
                pauseGame()
            case .gameOver:
                gameOver()
            case .none:
                break
            }
        }
    }
    var gameDifficulty: GameDifficulty! {
        didSet {
            switch gameDifficulty {
            case .easy:
                maxTime = 5
            case .medium:
                maxTime = 5
            case .hard:
                maxTime = 3
            case .none:
                break
            }
        }
    }
    var isBlackCard: Bool = false //can only be true when gameDifficulty is medium and hard and the card is black
    var isRedCard: Bool = false //can only be true at hard difficulty
    var isGreenCard: Bool = false //can only be true at hard difficulty
    var cardBackgroundColor:(white:Bool, black:Bool, green:Bool, red:Bool) = (true, false, false, false)
    var maxTime: Double!
    var timer: Timer!
    var timerCounter: Double = 4 {
        didSet {
            timeLabel.text = "\(String(format: "%.1f", timerCounter))" //round up to 1 decimal place
            if timerCounter <= 0 {
                timer?.invalidate()
                gameState = .gameOver
            }
        }
    }
    var titleTimer: Timer!
    var titleTimerCounter: Int = 3 {
        didSet {
            switch titleTimerCounter {
            case _ where titleTimerCounter == 1 && gameDifficulty == .easy: //if timer is 1 and difficulty is easy
                timeLabel.text = "\(String(titleTimerCounter))"
                pauseLabel.text = "Go!"
            case 0:
                titleTimer?.invalidate()
                timerCounter = maxTime
                pauseButton.alpha = 1
                gameState = .playing
            default:
                timeLabel.text = "\(String(titleTimerCounter))" //round up to 1 decimal place
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
            if score % 3 == 0 && maxTime > 1 { //everytime user scores 3 points, reduce the time. But maxTime will not go lower than 1 seconds
                maxTime -= 0.1
            }
        }
    }
    var pausesLeft: Int! {
        didSet {
            switch pausesLeft { //different ways to compare switch values
            case let num where num == 0:
                pauseLabel.text = "Warning! This is your last pause"
                pauseLabel.fadeIn(duration: 0.5)
            case _ where pausesLeft < 0:
                gameState = .gameOver
            default:
                pauseLabel.text = "\(String(pausesLeft))x pauses remaining"
                pauseLabel.fadeIn(duration: 0.5)
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
    @IBOutlet weak var pauseLabel: UILabel!
    
//MARK: App LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
//MARK: Private Methods
    private func evaluateAnswer(isYes: Bool) {
        if !isBlackCard && !isRedCard { //white card - normal answer
            if (topCardView.text == bottomCardView.color && isYes) || (topCardView.text != bottomCardView.color && !isYes) {
                correctAnswer()
                return
            }
        } else if isBlackCard { //if black card - reverse answer
            if (topCardView.text == bottomCardView.color && !isYes) || (topCardView.text != bottomCardView.color && isYes) {
                correctAnswer()
                return
            }
        } else if isRedCard { //if red card - do not answer
            if !isYes { //if red card - say no
                correctAnswer()
                return
            }
        } else if isGreenCard {
            if isYes {
                correctAnswer()
                return
            }
        }
        showIsCorrectImageView(isCorrect: false) //wrong
        gameState = .gameOver
    }
    
    private func updateCardColor() {
        isBlackCard = false //RESET and go to default view of the card first
        isRedCard = false
        topCardView.backgroundView.backgroundColor = .white
        bottomCardView.backgroundView.backgroundColor = .white
        topCardView.text = Color() //SET new colors
        topCardView.colorLabel.textColor = .black //keep this guy black
        bottomCardView.text = Color() //setting text to a new Color will update the card's text
        bottomCardView.color = Color() //setting color to a new Color will update the card's textColor
        switch gameDifficulty { //add the random background depending on difficulty
        case .medium: //isBlackCard can only be true if we are in hard mode
            isBlackCard = Bool.random()
            topCardView.addBlackBackground()
            bottomCardView.addBlackBackground()
        case .hard:
            isBlackCard = Bool.random()
            if isBlackCard { //if black = true
                topCardView.addBlackBackground()
                bottomCardView.addBlackBackground()
            } else { //if black = false, then let's give a chance for the card to be red
                isRedCard = Bool.random()
                if isRedCard { //if red = true then apply the red bg
                    topCardView.addRedBackground()
                    bottomCardView.addRedBackground()
                }
            }
        default: //else keep it the way it is
            break
        }
    }
    
    private func showIsCorrectImageView(isCorrect: Bool) { //the correct or wrong indicator
        isCorrectImageView.image = isCorrect ? kCORRECTIMAGE : kWRONGIMAGE
        isCorrectImageView.isHidden = false
        isCorrectImageView.enlargeThenShrinkAnimation()
    }
    
    private func setupViews() {
        pauseButton.alpha = 0
        isCorrectImageView.isHidden = true
        isCorrectImageView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        pausesLeft = 3
        gameState = .title
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateGameTimer), userInfo: nil, repeats: true) //Once the round is ready, start the timer
    }
    
    private func correctAnswer() {
        score += 1
        timerCounter = maxTime
        showIsCorrectImageView(isCorrect: true)
        updateCardColor()
    }
    
    private func gameOver() {
        if score > highScore {
            currentHighScore = score //score is now our new high score
        }
        timer.invalidate()
        dismiss(animated: true, completion: nil)
    }
    
    private func gameTitle() {
        topCardView.alpha = 0
        bottomCardView.alpha = 0
        yesButton.alpha = 0
        noButton.alpha = 0
        switch gameDifficulty {
        case .medium, .hard:
            pauseLabel.font = UIFont.init(name: "Chalkduster", size: 30) //resize
            pauseLabel.text = "If the cards are black, choose the opposite answer"
        default:
            pauseLabel.text = "Ready?"
        }
        titleTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTitleTimer), userInfo: nil, repeats: true) //Once the round is ready, start the timer
    }
    
    private func pauseGame() {
        pauseButton.setImage(kPLAYIMAGE, for: .normal)
        timer.invalidate() //pause the timer
        topCardView.fadeOut(duration: 0.3)
        bottomCardView.fadeOut(duration: 0.3)
        yesButton.fadeOut(duration: 0.3)
        noButton.fadeOut(duration: 0.3)
        yesButton.isEnabled = false
        noButton.isEnabled = false
        pausesLeft -= 1
    }
    
    private func playGame() {
        pauseButton.setImage(kPAUSEIMAGE, for: .normal)
        topCardView.fadeIn(duration: 0.3)
        bottomCardView.fadeIn(duration: 0.3)
        yesButton.fadeIn(duration: 0.3)
        noButton.fadeIn(duration: 0.3)
        yesButton.isEnabled = true
        noButton.isEnabled = true
        pauseLabel.fadeOut(duration: 0.3)
        startTimer()
    }
    
//MARK: IBActions
    @IBAction func yesButtonTapped(_ button: UIButton) {
        evaluateAnswer(isYes: true)
    }
    
    @IBAction func noButtonTapped(_ button: UIButton) {
        evaluateAnswer(isYes: false)
    }
    @IBAction func pauseButtonTapped(_ button: UIButton) {
        if button.image(for: .normal) == kPLAYIMAGE {
            gameState = .playing //setting gameState will pause or play the game
        } else {
            gameState = .paused
        }
    }
    
//MARK: Helper Methods
    @objc func updateGameTimer() {
        timerCounter -= 0.1
    }
    
    @objc func updateTitleTimer() {
        titleTimerCounter -= 1
    }
}
