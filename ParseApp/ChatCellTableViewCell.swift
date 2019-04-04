//
//  ChatCellTableViewCell.swift
//  ParseApp
//
//  Created by Sarah Gemperle on 4/3/19.
//  Copyright © 2019 Sarah Gemperle. All rights reserved.
//

import UIKit

class ChatCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
