//
//  SignUpViewController.swift
//  ChatAppFirebase
//
//  Created by Mahmut Şenbek on 16.11.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

  
    @IBAction func signupButton(_ sender: UIButton) {
        
        if passwordTextField.text != "" && emailTextField.text != "" {
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { data, error in
                
                if let err = error {
                    self.makeAlert(tittleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                    print(err)
                }else {
                    self.performSegue(withIdentifier: K.beetweenLoginAndSignupSegue, sender: nil)
                }
            }
         
        }
      
    }
    
    func makeAlert(tittleInput : String, messageInput: String) {
        let alert = UIAlertController(title: tittleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    

}
