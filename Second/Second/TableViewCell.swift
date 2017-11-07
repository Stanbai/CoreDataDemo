//
//  TableViewCell.swift
//  Second
//
//  Created by Stan on 2017-11-05.
//  Copyright © 2017 Stan Guo. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = min(avatarImageView.bounds.size.width, avatarImageView.bounds.size.height) * 0.5
        
        avatarImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
