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

class GameVC: UIViewController {
//MARK: Properties
    var gameState: GameState! {
        didSet {
            switch gameState {
            case .playing:
                playGame()
            case .paused:
                pauseGame()
            case .gameOver:
                gameOver()
            default:
                break
            }
        }
    }
    var gameDifficulty: GameDifficulty!
    var cardColorAsTuple:(white:Bool, black:Bool, green:Bool, red:Bool) = (true, false, false, false) //will be needed for evaluating answers depending on the Card's bg color
    var maxTime: Double!
    var timer: Timer!
    var timerCounter: Double! {
        didSet {
            timeLabel.text = "\(String(format: "%.1f", timerCounter))" //round up to 1 decimal place
            if timerCounter <= 0 {
                timeLabel.text = "0.0"
                gameState = .gameOver
            }
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
    private func setupViews() {
        pauseButton.alpha = 0
        isCorrectImageView.isHidden = true
        isCorrectImageView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        pausesLeft = 3
        maxTime = gameDifficulty.getInitialMaxTime()
        timerCounter = maxTime
        gameState = .playing
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateGameTimer), userInfo: nil, repeats: true) //Once the round is ready, start the timer
    }
    
    private func updateCardColor() {
        cardColorAsTuple = (white:true, black:false, green:false, red:false) //RESET as white being true
        topCardView.text = Color() //SET a new random color
        topCardView.colorLabel.textColor = .black //keep this black
        bottomCardView.text = Color() //setting text to a new Color will update the card's text
        bottomCardView.textColor = Color() //setting color to a new Color will update the card's textColor
        var cardColor: CardColor = CardColor.white
        switch gameDifficulty { //change background
        case .medium: //make a black or white card
            if Bool.random() { //if random Bool is true...
                cardColor = CardColor.black //make the cardBG black
            }
        case .hard: //if hard...
            cardColor = CardColor() //select random color
        default: //else keep card as white
            break
        }
        topCardView.cardColor = cardColor //assign cardColor
        bottomCardView.cardColor = cardColor
        cardColorAsTuple = cardColor.getCardColorAsTuple() //populate our cardColorAsTuple property to see which color is true
    }
    
    private func evaluateAnswer(userSelectedYes: Bool) {
        switch cardColorAsTuple {
        case (white:true, black:false, green:false, red:false): //WHITE
            if (topCardView.text == bottomCardView.textColor && userSelectedYes) || (topCardView.text != bottomCardView.textColor && !userSelectedYes) { //if text and color are the equal and user said yes OR if text and color are not equal and user said no
                correctAnswer()
                return
            }
        case (white:false, black:true, green:false, red:false): //BLACK
            if (topCardView.text == bottomCardView.textColor && !userSelectedYes) || (topCardView.text != bottomCardView.textColor && userSelectedYes) {
                correctAnswer()
                return
            }
        case (white:false, black:false, green:true, red:false): //GREEN
            if userSelectedYes { //if green card - yes answer
                correctAnswer()
                return
            }
        case (white:false, black:false, green:false, red:true): //RED
            if !userSelectedYes { //if red card - say no
                correctAnswer()
                return
            }
        default:
            print("weird card \(cardColorAsTuple)")
        }
        gameState = .gameOver
    }
    
    private func correctAnswer() {
        score += 1
        timerCounter = maxTime
        showIsCorrectImageView(isCorrect: true)
        updateCardColor()
    }
    
    private func showIsCorrectImageView(isCorrect: Bool) { //the correct or wrong indicator
        isCorrectImageView.image = isCorrect ? kCORRECTIMAGE : kWRONGIMAGE
        isCorrectImageView.isHidden = false
        isCorrectImageView.enlargeThenShrinkAnimation()
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
        pauseButton.alpha = 1
        pauseButton.setImage(kPAUSEIMAGE, for: .normal)
        topCardView.fadeIn(duration: 0.3)
        bottomCardView.fadeIn(duration: 0.3)
        yesButton.fadeIn(duration: 0.3)
        noButton.fadeIn(duration: 0.3)
        yesButton.isEnabled = true
        noButton.isEnabled = true
        pauseLabel.fadeOut(duration: 0.3)
        startTimer()
        updateCardColor()
    }
    
    private func gameOver() {
        timer.invalidate()
        showIsCorrectImageView(isCorrect: false) //user answered wrong
        yesButton.isEnabled = false
        noButton.isEnabled = false
        if score > gameDifficulty.getHighScore() {
            gameDifficulty.setHighScore(score: score) //score is now our new high score
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { //add a 1 sec delay before dismissing
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
//MARK: IBActions
    @IBAction func yesButtonTapped(_ button: UIButton) {
        evaluateAnswer(userSelectedYes: true)
    }
    
    @IBAction func noButtonTapped(_ button: UIButton) {
        evaluateAnswer(userSelectedYes: false)
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
}
