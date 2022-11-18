//
//  Constants.swift
//  ChatAppFirebase
//
//  Created by Mahmut Senbek on 17.11.2022.
//


struct K {
    
    static let signupSegue = "toBetween"
    static let beetweenLoginAndSignupSegue = "toBetween"
    static let chatSegue = "toChat"
    static let logOut = "logOut"
    static let appName = "⚡️ChatApp"
    static let cellIdentifier = "cell"
    static let tableViewCellNibName = "TableViewCell"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let brandBlue = "BrandBlue"
        static let lightBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
     
    }
 
}
