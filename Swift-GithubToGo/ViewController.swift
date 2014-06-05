//
//  ViewController.swift
//  Swift-GithubToGo
//
//  Created by Bradley Johnson on 6/5/14.
//  Copyright (c) 2014 Bradley Johnson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var networkController = NetworkController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController
        
            self.networkController.requestOauthAccessWithCompletion({
                println("we done playa")
            })
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

