//
//  ViewController.swift
//  ChatAppFirebase
//
//  Created by Mahmut Şenbek on 16.11.2022.
//

import UIKit


class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = ""
        var charIndex = 0.0
        let tittleText = K.appName
        for letter in tittleText {
           // print(0.1 * charIndex)
            //print(letter)
         Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
         
        
    }

    @IBAction func signUpButton(_ sender: Any) {
    }
    
    @IBAction func loginButton(_ sender: Any) {
    }
}

