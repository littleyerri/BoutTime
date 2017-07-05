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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

