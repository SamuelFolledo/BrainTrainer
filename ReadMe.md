# Brain Trainer
Brain Training Game for iOS written in Swift that trains your brain and hand-eye coordination as my Final Project for my Mobile Development 1.1 course in Make School. It follows best practices in Model View Controller pattern to avoid massive view controllers. Separation of concerns, using __enumaration__ to keep track of game's current state and difficulty, __[protocols](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html)__ like [CaseIterable](https://www.hackingwithswift.com/example-code/language/how-to-list-all-cases-in-an-enum-using-caseiterable) be able to use allCases method to select a random case for Color, [String](https://swiftdoc.org/v4.2/protocol/stringprotocol/) for case's rawValue, and some custom protocols

## Features
- Different game difficulties
- High score functionality for each difficulties
- Basic animations
- Transition animations

## Game Play
### MenuVC: User can select from 3 difficulties:
- Easy: White Cards
- Medium: White and Black Cards
- Hard: Green, Red, Black, and White Cards
<img src="https://github.com/SamuelFolledo/BrainTrainer/blob/master/static/gif/menu.gif" width="563" height="1000">

### Easy: Top card TEXT must match the bottom card's TEXTCOLOR
<img src="https://github.com/SamuelFolledo/BrainTrainer/blob/master/static/gif/easy.gif" width="563" height="1000">

### Medium: Black cards's answer is opposite of white's answer
<img src="https://github.com/SamuelFolledo/BrainTrainer/blob/master/static/gif/medium.gif" width="563" height="1000">

### Hard: Green means yes, and red means no, with black and white cards rules
<img src="https://github.com/SamuelFolledo/BrainTrainer/blob/master/static/gif/hard.gif" width="563" height="1000">

-----

## App Inspiration
<img src="https://github.com/SamuelFolledo/BrainTrainer/blob/master/static/screenshots/sampleGame.png" width="450" height="609">

## Important Links
- [Requirements](https://make-school-courses.github.io/MOB-1.1-Introduction-to-Swift/#/Assignments/FinalProject)
- [Stroop Effect](https://en.wikipedia.org/wiki/Stroop_effect)
- Sample Implementation: [Color Match](https://www.lumosity.com/en/brain-games/color-match/)
