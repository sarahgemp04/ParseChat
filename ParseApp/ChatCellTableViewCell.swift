//
//  ChatCellTableViewCell.swift
//  ParseApp
//
//  Created by Sarah Gemperle on 4/3/19.
//  Copyright © 2019 Sarah Gemperle. All rights reserved.
//

import UIKit
import Parse

class ChatCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red: 0, green: 0.54, blue: 1, alpha: 0.8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
