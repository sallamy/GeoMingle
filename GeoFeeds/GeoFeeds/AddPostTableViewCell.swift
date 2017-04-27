//
//  AddPostTableViewCell.swift
//  GeoFeeds
//
//  Created by sala7 on 4/26/17.
//  Copyright © 2017 GEO. All rights reserved.
//

import UIKit
protocol AddPostDelegate {
    func AddAttachmentDelegate()
    func cancelPostDelegate()
    func AddPostDelegate(cell:AddPostTableViewCell)
    

}
class AddPostTableViewCell: UITableViewCell,UITextViewDelegate {

    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var attachmentsBtn: UIButton!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var myImageView: UIImageView!
        var delegateAddPost:AddPostDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.myImageView.layer.cornerRadius = self.myImageView.frame.width / 2
        self.myImageView.layer.masksToBounds = true
        // Initialization code
    }

    @IBAction func attachMentAction(_ sender: UIButton) {
        if let adel = self.delegateAddPost {
            adel.AddAttachmentDelegate()
        }
        
    }
    @IBAction func cancelAction(_ sender: Any) {
        if let adel = self.delegateAddPost {
            adel.cancelPostDelegate()
        }
    }
    @IBAction func postAction(_ sender: Any) {
        if let adel = self.delegateAddPost {
            adel.AddPostDelegate(cell: self)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
}
