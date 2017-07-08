//
//  WebViewViewController.swift
//  BoutTime
//
//  Created by Gerardo Zayas on 7/8/17.
//  Copyright © 2017 Little Yerri. All rights reserved.
//

import UIKit

class WebViewViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let link    = URL(string: url)
        let request = URLRequest(url: link!)
        
        webView.loadRequest(request)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}









