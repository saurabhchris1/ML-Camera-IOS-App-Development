//
//  ViewTextViewController.swift
//  ML Camera
//
//  Created by Saurabh Jaiswal on 4/24/19.
//  Copyright © 2019 Saurabh Jaiswal. All rights reserved.
//

import UIKit

class ViewTextViewController: UIViewController {
    
    var completeTextReceivedFromSegue: Textclass!

    @IBOutlet weak var textViewFromTableRow: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textViewFromTableRow.text = completeTextReceivedFromSegue.textInDatabase
        textViewFromTableRow.isEditable = true
        textViewFromTableRow.isSelectable = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textViewFromTableRow.resignFirstResponder()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
