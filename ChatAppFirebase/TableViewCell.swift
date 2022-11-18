//
//  TableViewCell.swift
//  ChatAppFirebase
//
//  Created by Mahmut Senbek on 17.11.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageView.layer.cornerRadius = messageView.frame.size.height / 5
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
