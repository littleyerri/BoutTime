//
//  GameOverViewController.swift
//  BoutTime
//
//  Created by Gerardo Zayas on 7/4/17.
//  Copyright © 2017 Little Yerri. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func playAgainButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
        delegate.playAgainPressed(true)
    }
    
    var delegate: GameOverDelegate! = nil
    var score:    Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scoreLabel.text = "\(score)/6"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}









