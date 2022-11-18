//
//  SignInViewController.swift
//  ChatAppFirebase
//
//  Created by Mahmut Şenbek on 16.11.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func loginButton(_ sender: UIButton) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { data, error in
                
                if error != nil {
                    self.makeAlert(tittleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                }else {
                    self.performSegue(withIdentifier: K.chatSegue, sender: nil)
                }
            }
        }else {
            makeAlert(tittleInput: "Error", messageInput: "Please Fill Sections.")
        }
        

        
    }
    func makeAlert(tittleInput : String, messageInput: String) {
        let alert = UIAlertController(title: tittleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
    

}
