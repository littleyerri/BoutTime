//
//  ViewController.swift
//  BoutTime
//
//  Created by Gerardo Zayas on 7/3/17.
//  Copyright © 2017 Little Yerri. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GameOverDelegate {

    // MARK: IBOulets
    
    // UILabel
    @IBOutlet weak var firstEvent:  UILabel!
    @IBOutlet weak var secondEvent: UILabel!
    @IBOutlet weak var thirdEvent:  UILabel!
    @IBOutlet weak var fourthEvent: UILabel!
    
    @IBOutlet weak var countdown:   UILabel!
    @IBOutlet weak var message:     UILabel!
    
    // UIButton
    @IBOutlet weak var firstEventDown:   UIButton!
    @IBOutlet weak var secondEventUp:    UIButton!
    @IBOutlet weak var secondEventDown:  UIButton!
    @IBOutlet weak var thirdEventUp:     UIButton!
    @IBOutlet weak var thirdEventDown:   UIButton!
    @IBOutlet weak var fourthEventUp:    UIButton!
    
    @IBOutlet weak var nextRoundSuccess: UIButton!
    @IBOutlet weak var nextRoundFail:    UIButton!
    
    @IBOutlet weak var firstEventButton:  UIButton!
    @IBOutlet weak var secondEventButton: UIButton!
    @IBOutlet weak var thirdEventButton:  UIButton!
    @IBOutlet weak var fourthEventButton: UIButton!
    
    // MARK: IBActions
    @IBAction func moveFirstEventDown(_ sender: Any) {
        let eventOne = events[0]
        let eventTwo = events[1]
        
        events[0] = eventTwo
        events[1] = eventOne
        
        updateEvents()
    }
    
    @IBAction func moveSecondEventUp(_ sender: Any) {
        moveFirstEventDown(Any.self)
    }
    
    @IBAction func moveSecondEventDown(_ sender: Any) {
        let eventTwo   = events[1]
        let eventThree = events[2]
        
        events[1] = eventThree
        events[2] = eventTwo
        
        updateEvents()
    }
    
    @IBAction func moveThirdEventUp(_ sender: Any) {
        moveSecondEventDown(Any.self)
    }
    
    @IBAction func moveThirdEventDown(_ sender: Any) {
        moveFourthEventUp(Any.self)
    }
    
    @IBAction func moveFourthEventUp(_ sender: Any) {
        let eventThree = events[2]
        let eventFour  = events[3]
        
        events[2] = eventFour
        events[3] = eventThree
        
        updateEvents()
    }
    
    @IBAction func startNextRound(_ sender: UIButton) {
        if sender == nextRoundSuccess || sender == nextRoundFail {
            nextRound()
        }
    }
    
    @IBAction func webViewEvent(_ sender: UIButton!) {
        switch sender {
        case firstEventButton:
            performSegue(withIdentifier: "WebViewSegue", sender: events[0].url)
        case secondEventButton:
            performSegue(withIdentifier: "WebViewSegue", sender: events[1].url)
        case thirdEventButton:
            performSegue(withIdentifier: "WebViewSegue", sender: events[2].url)
        case fourthEventButton:
            performSegue(withIdentifier: "WebViewSegue", sender: events[3].url)
        default:
            performSegue(withIdentifier: "WebViewSegue", sender: "https://developer.apple.com/documentation/")
        }
    }
    
    // Game Set Up
    var game:   GameEvents
    var events: [Content] = []
    var timer:  Timer?
    
    required init?(coder aDecoder: NSCoder) {
        do {
            let dictionaryArray = try PlistImporter.dictionary(fromFile: "Events", ofType: "plist")
            let collection = try CollectionUnarchiver.collection(from: dictionaryArray)
            
            self.game = GameEvents(collectionOfEvents: collection)
        } catch let error {
            fatalError("\(error)")
        }
        
        super.init(coder: aDecoder)
    }
    
    // Update labels for each event.
    func updateEvents() {
        firstEvent.text  = events[0].event
        secondEvent.text = events[1].event
        thirdEvent.text  = events[2].event
        fourthEvent.text = events[3].event
    }
    
    // Sets up the next round.
    func nextRound() {
        guard game.rounds != game.numberOfRounds else {
            timer?.invalidate()
            
            performSegue(withIdentifier: "GameOverSegue", sender: game.points)
            
            return
        }
        
        webViewButtons(false)
        
        events = game.randomEvents(4)
        countdown.text = "1:00"
        
        updateEvents()
        
        game.timer  = 60
        game.rounds += 1
        
        // Hide success and fail buttons.
        nextRoundSuccess.isHidden = true
        nextRoundFail.isHidden    = true
        
        // Show countdown.
        countdown.isHidden = false
        
        // Display shake message.
        message.text = "Shake To Complete"
        
        // Create intance of timer.
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: (#selector(ViewController.ticker)), userInfo: nil, repeats: true)
    }
    
    func endRound(answer: Bool) {
        switch answer {
        case true:
            nextRoundSuccess.isHidden = false
            nextRoundFail.isHidden    = true
        case false:
            nextRoundSuccess.isHidden = true
            nextRoundFail.isHidden    = false
        break
        }
        
        webViewButtons(true)
        
        // Hide countdown.
        countdown.isHidden = true
        
        // Stop timer.
        timer?.invalidate()
        
        // Display tap events message.
        message.text = "Tap Events To Learn More"
    }
    
    // Check for shake motion
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            endRound(answer: game.checkOrder(of: events))
        }
    }
    
    // Prepare for game over segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Game view controller
        if segue.identifier == "GameOverSegue" {
            if let destination = segue.destination as? GameOverViewController {
                if let score = sender as? Int {
                    destination.score    = score
                    destination.delegate = self
                }
            }
        }
        
        // Web view view controller
        if segue.identifier == "WebViewSegue" {
            if let destination = segue.destination as? WebViewViewController {
                if let link = sender as? String {
                    destination.url = link
                }
            }
        }
    }
    
    // Ticker method for timer
    func ticker() {
        game.timer -= 1
        
        if game.timer >= 10 {
            countdown.text = "0:\(game.timer)"
        } else if game.timer < 10 {
            countdown.text = "0:0\(game.timer)"
        }
        
        if game.timer <= 0 {
            endRound(answer: game.checkOrder(of: events))
        }
    }
    
    // Delegate function for dismissing the gameover/score view.
    func playAgainPressed(_ playAgain: Bool) {
        game.points = 0
        game.rounds = 0
        
        nextRound()
    }
    
    // MARK: Helper Methods
    
    // Enable-Disable web view buttons.
    func webViewButtons(_ enable: Bool) {
        if enable == true {
            firstEventButton.isEnabled   = true
            secondEventButton.isEnabled  = true
            thirdEventButton.isEnabled   = true
            fourthEventButton.isEnabled  = true
        } else if enable == false {
            firstEventButton.isEnabled   = false
            secondEventButton.isEnabled  = false
            thirdEventButton.isEnabled   = false
            fourthEventButton.isEnabled  = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Hide next buttons
        nextRoundSuccess.isHidden = true
        nextRoundFail.isHidden    = true
        
        nextRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}









