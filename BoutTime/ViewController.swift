//
//  ViewController.swift
//  BoutTime
//
//  Created by Gerardo Zayas on 7/3/17.
//  Copyright © 2017 Little Yerri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: IBOulets
    
    // UILabel
    @IBOutlet weak var firstEvent:  UILabel!
    @IBOutlet weak var secondEvent: UILabel!
    @IBOutlet weak var thirdEvent:  UILabel!
    @IBOutlet weak var fourthEvent: UILabel!
    
    @IBOutlet weak var countdown:   UILabel!
    @IBOutlet weak var message:     UILabel!
    
    // UIButton
    @IBOutlet weak var firstEventDown:  UIButton!
    @IBOutlet weak var secondEventUp:   UIButton!
    @IBOutlet weak var secondEventDown: UIButton!
    @IBOutlet weak var thirdEventUp:    UIButton!
    @IBOutlet weak var thirdEventDown:  UIButton!
    @IBOutlet weak var fourthEventUp:   UIButton!
    
    @IBOutlet weak var nextRoundSucess: UIButton!
    @IBOutlet weak var nextRoundFail:   UIButton!
    
    // MARK: IBActions
    
    @IBAction func moveFirstEventDown(_ sender: Any) {
        
    }
    
    @IBAction func moveSecondEventUp(_ sender: Any) {
        
    }
    
    @IBAction func moveSecondEventDown(_ sender: Any) {
        
    }
    
    @IBAction func moveThirdEventUp(_ sender: Any) {
        
    }
    
    @IBAction func moveThirdEventDown(_ sender: Any) {
        
    }
    
    @IBAction func moveFourthEventUp(_ sender: Any) {
        
    }
    
    
    // Game Set Up
    let game: Game
    
    required init?(coder aDecoder: NSCoder) {
        do {
            let dictionaryArray = try PlistImporter.dictionary(fromFile: "Events", ofType: "plist")
            let collection = try CollectionUnarchiver.collection(from: dictionaryArray)
            
            self.game = Game(collectionOfEvents: collection)
        } catch let error {
            fatalError("\(error)")
        }
        
        super.init(coder: aDecoder)
    }
    
    func nextRound() {
        // FIXME: Add logic.
    }
    
    func endRound(answer: Bool) {
        // FIXME: Add logic.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Hide next buttons
        nextRoundSucess.isHidden = true
        nextRoundFail.isHidden   = true
        
        nextRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

