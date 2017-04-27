//
//  PostTableViewCell.swift
//  GeoFeeds
//
//  Created by sala7 on 4/26/17.
//  Copyright © 2017 GEO. All rights reserved.
//

import UIKit
protocol postDelegate {
    func likeDelegate(cell:PostTableViewCell)
        func commentDelegate(cell:PostTableViewCell)
           func sharetDelegate(cell:PostTableViewCell)
}
class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var postImageHeight: NSLayoutConstraint!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var ownerImage: UIImageView!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var delegatePost:postDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ownerImage.layer.cornerRadius = self.ownerImage.frame.width / 2
        self.ownerImage.layer.masksToBounds = true
        // Initialization code
    }

    @IBAction func shareAction(_ sender: Any) {
        if let adel = self.delegatePost {
            adel.sharetDelegate(cell: self)
        }
    }
    @IBAction func commentAction(_ sender: Any) {
        if let adel = self.delegatePost {
            adel.commentDelegate(cell: self)
        }
    }
    @IBAction func LikeAction(_ sender: Any) {
        if let adel = self.delegatePost {
            adel.likeDelegate(cell: self)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
