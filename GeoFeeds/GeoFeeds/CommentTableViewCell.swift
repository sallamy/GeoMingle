//
//  CommentTableViewCell.swift
//  GeoFeeds
//
//  Created by sala7 on 4/27/17.
//  Copyright © 2017 GEO. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var ownerImage: UIImageView!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ownerImage.layer.cornerRadius = self.ownerImage.frame.width / 2
        self.ownerImage.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
