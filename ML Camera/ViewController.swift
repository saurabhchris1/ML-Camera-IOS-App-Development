//
//  ViewController.swift
//  ML Camera
//
//  Created by Saurabh Jaiswal on 4/24/19.
//  Copyright © 2019 Saurabh Jaiswal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//This is home view
    
    @IBOutlet weak var textRecognizationTapped: UIButton!
    
    @IBOutlet weak var savedTextTapped: UIButton!
    
    @IBOutlet weak var objectRecognizationTapped: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        textRecognizationTapped.layer.cornerRadius = 7
        savedTextTapped.layer.cornerRadius = 7
        objectRecognizationTapped.layer.cornerRadius = 7
        
        
    }


}

