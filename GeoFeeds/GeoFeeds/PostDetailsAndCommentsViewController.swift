//
//  PostDetailsAndCommentsViewController.swift
//  GeoFeeds
//
//  Created by sala7 on 4/27/17.
//  Copyright © 2017 GEO. All rights reserved.
//

import UIKit

class PostDetailsAndCommentsViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,postDelegate{
    @IBOutlet weak var commentTextView: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var feed:feed?
    @IBOutlet weak var inputViewBottomConstraint: NSLayoutConstraint!
    var previousConstant:CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView?.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "postcell")
        tableView?.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "commentCell")
        // Do any additional setup after loading the view.
  
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
//                 self.commentTextView.becomeFirstResponder()
//        }
        
  
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        
        IQKeyboardManager.shared().isEnabled = false
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = true
        
        
    }

    
    
    func keyboardWillShow(notification : NSNotification) {
        
        let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size
        
        previousConstant = self.inputViewBottomConstraint.constant
        self.inputViewBottomConstraint.constant = keyboardSize.height
        
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func keyboardWillHide(notification : NSNotification) {
        
        self.inputViewBottomConstraint.constant = previousConstant
        self.view.layoutIfNeeded()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  (self.feed?.commentsList.count)! + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if(indexPath.row == 0){
     
        
        
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "postcell", for: indexPath) as! PostTableViewCell
        cell.ownerLabel.text = feed?.ownername
        cell.timeLabel.text = feed?.createddate
        cell.likeBtn.setTitle("\((feed?.numberoflikes)!) Like", for: .normal)
        cell.shareBtn.setTitle("\(( feed?.numberofshare)!) Share", for: .normal)
        cell.commentBtn.setTitle("\(( feed?.numberofshare)!) Comment", for: .normal)
        cell.postTextLabel.text = feed?.posttext
        cell.ownerImage?.sd_setImage(with:         URL(string: (feed?.ownerimage)!), completed: { (image, error, hh, url) in
            if((error) != nil){
                
            }else {
                
            }
        })
        cell.postImageView?.sd_setImage(with:         URL(string: (feed?.postImage)!), completed: { (image, error, hh, url) in
            if((error) != nil){
                cell.postImageHeight.constant = 0
                
            }else {
                if(  cell.postImageHeight.constant == 0){
                    cell.postImageHeight.constant = 272
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.tableView.beginUpdates()
                        self.tableView.reloadRows(
                            at: [indexPath],
                            with: .none)
                        self.tableView.endUpdates()
                    })
                }
                
                
            }
        })
            
                   return cell
        }
                 let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentTableViewCell
        
        let comment  = feed?.commentsList[indexPath.row - 1]
        cell.ownerLabel.text = comment?.name
        cell.timeLabel.text = comment?.createddate
        cell.ownerImage?.sd_setImage(with:         URL(string: (comment?.image)!), completed: { (image, error, hh, url) in
            if((error) != nil){
                
            }else {
                
            }
        })
        cell.postTextLabel.text = comment?.comment
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableViewAutomaticDimension
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  
        return UITableViewAutomaticDimension
    }

    @IBAction func postAction(_ sender: Any) {
        
        self.view.endEditing(true)
    }
  
    
    //MARK:- post methods
    
    func likeDelegate(cell: PostTableViewCell) {
        
    }
    func commentDelegate(cell: PostTableViewCell) {
        
    }
    func sharetDelegate(cell: PostTableViewCell) {
        
    }

}
