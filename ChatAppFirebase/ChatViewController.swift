//
//  ChatViewController.swift
//  ChatAppFirebase
//
//  Created by Mahmut Şenbek on 16.11.2022.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import IQKeyboardManager

class ChatViewController: UIViewController {
    
    var messages : [Messages] = []

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.tableViewCellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadMessages()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hiddenKeyboard))
        view.addGestureRecognizer(gesture)
    }
    
    @objc func hiddenKeyboard() {
        view.endEditing(true)
    }
    func loadMessages() {
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
            self.messages = []
            if let err = error {
                print(err)
            }else {
                if let snapShotDocument =  querySnapshot?.documents {
                   
                    for doc in snapShotDocument {
                        let data = doc.data()
                        if let sender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Messages(sender: sender, body: messageBody)
                            self.messages.append(newMessage)
                            self.textField.text = ""
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                // mesaj gönderildiğinde en son gönderilen mesaja gösterir. ekranda 
                                let indexPathCopy = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPathCopy, at: UITableView.ScrollPosition.top, animated: true)
                            }
                       
                        }
                    }
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
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if textField.text != "" {
            if let messageBody = textField.text, let sender = Auth.auth().currentUser?.email {
                db.collection(K.FStore.collectionName).addDocument(data: [
                    K.FStore.senderField: sender,
                    K.FStore.bodyField: messageBody,
                    K.FStore.dateField: Date().timeIntervalSince1970]) { error in
                    
                        if let err = error {
                            self.makeAlert(tittleInput: "Error", messageInput: err.localizedDescription)
                        }else {
                            print("saved")
                        }
                }
            }
        }else {
            print("error")
        }
        
     
        
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        do {
           try Auth.auth().signOut()
            self.performSegue(withIdentifier: K.logOut, sender: nil)
        }catch {
            print(error.localizedDescription )
        }
        
    }

}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! TableViewCell
        
        let message = messages[indexPath.row]
        
        if  message.sender == Auth.auth().currentUser?.email {
            
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageView.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.messageLabel.textColor = UIColor(named: K.BrandColors.purple)
        }else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageView.backgroundColor = UIColor(named: K.BrandColors.lightBlue)
            cell.messageLabel.textColor = UIColor(named: K.BrandColors.brandBlue)
            
        }

        cell.messageLabel.text = message.body
        
     
        return cell
    }
    
    
    
    
    
}
