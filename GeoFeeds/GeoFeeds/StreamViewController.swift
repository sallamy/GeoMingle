//
//  StreamViewController.swift
//  GeoFeeds
//
//  Created by sala7 on 4/26/17.
//  Copyright © 2017 GEO. All rights reserved.
//

import UIKit

class StreamViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,AddPostDelegate,postDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    var feeds:[feed]?
    var addPostHeight = 80
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView?.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "postcell")
        tableView?.register(UINib(nibName: "AddPostTableViewCell", bundle: nil), forCellReuseIdentifier: "AddPostCell")
        self.edgesForExtendedLayout = .all
        self.extendedLayoutIncludesOpaqueBars = false;
        self.automaticallyAdjustsScrollViewInsets = false;
        self.getFeeds()
        tableView.addPullToRefresh(actionHandler: { [weak self] in
//            self?.page = 1
//            self?.callService()
        })
        tableView.addInfiniteScrolling (actionHandler: { [weak self] in
//            if (self?.NextPage)!{
//                self?.page += 1
//                self?.callService()
//            }else{
//                self?.tableView.infiniteScrollingView.stopAnimating()
//            }
        })

        

        // Do any additional setup after loading the view.
    }
    func getFeeds(){
        GeoDataCenter.sharedInstance().feedsList { (list) in
            self.feeds = list as! [feed]
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.feeds!.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        

        if(indexPath.row == 0){
           let cell = tableView.dequeueReusableCell(withIdentifier: "AddPostCell", for: indexPath) as! AddPostTableViewCell
            if addPostHeight != 80 {
                cell.postBtn.isHidden = false
                cell.cancelBtn.isHidden = false
                cell.hintLabel.isHidden = true
                         cell.postTextView.isHidden = false
          cell.postTextView.becomeFirstResponder()
                
            }else {
                cell.postBtn.isHidden = true
                cell.cancelBtn.isHidden = true
                cell.hintLabel.isHidden = false
                cell.postTextView.text = ""
                cell.postTextView.isHidden = true
            }
            
            cell.delegateAddPost = self
            return cell
        }
        
        
     let feed = self.feeds?[indexPath.row-1]
            let cell = tableView.dequeueReusableCell(withIdentifier: "postcell", for: indexPath) as! PostTableViewCell
        cell.ownerLabel.text = feed?.ownername
        cell.delegatePost = self
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

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(addPostHeight)
        }
        return UITableViewAutomaticDimension
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(addPostHeight)
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if  (addPostHeight == 80){
            addPostHeight = 150
            self.tableView.reloadData()
            }
        }else {
            let postDetails = PostDetailsAndCommentsViewController()
            postDetails.feed = self.feeds?[indexPath.row - 1]
            self.navigationController?.pushViewController(postDetails, animated: true)
        }
    }
    
    @IBAction func action(_ sender: UISegmentedControl) {
        print("CustomTitleViewController IBAction invoked!")
    }
    
    //MARK:- post methods
    
    func likeDelegate(cell: PostTableViewCell) {
        
    }
    func commentDelegate(cell: PostTableViewCell) {
        let postDetails = PostDetailsAndCommentsViewController()
        postDetails.feed = self.feeds?[(self.tableView.indexPath(for: cell)?.row)! - 1]
        self.navigationController?.pushViewController(postDetails, animated: true)
        
        
    }
    func sharetDelegate(cell: PostTableViewCell) {
        
    }
    
    //MARK:- addpost methods
    
    func AddPostDelegate(cell: AddPostTableViewCell) {
        
    }
    
    
    
    func AddAttachmentDelegate() {
        let settingsActionSheet: UIAlertController = UIAlertController(title:nil, message:nil, preferredStyle:UIAlertControllerStyle.actionSheet)
        settingsActionSheet.addAction(UIAlertAction(title:"Camera", style:UIAlertActionStyle.default, handler:{ action in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .camera
                picker.allowsEditing = true
                self.present(picker, animated: true, completion: nil)
            }
        }))
        settingsActionSheet.addAction(UIAlertAction(title:"Photo Library", style:UIAlertActionStyle.default, handler:{ action in
            let img = UIImagePickerController()
            img.delegate = self
            img.sourceType = .photoLibrary
            //img.mediaTypes = [kUTTypeImage]; //whatever u want type
            img.allowsEditing = false
            self.present(img, animated: true, completion: nil)
        }))
        settingsActionSheet.addAction(UIAlertAction(title:"Cancel", style:UIAlertActionStyle.cancel, handler:nil))
            present(settingsActionSheet, animated:true, completion:nil)
    }
    
    
       //MARK:- image picker delegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: false, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! AddPostTableViewCell
        cell.imagePreview.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        addPostHeight = 350
        cell.imageHeight.constant = 150
        self.tableView.reloadData()
        dismiss(animated: true, completion: nil)
        
    }



    
    func cancelPostDelegate() {
    
        let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! AddPostTableViewCell
        cell.imageHeight.constant = 0
        cell.imagePreview.image = nil
        addPostHeight = 80
        self.tableView.reloadData()
    }

}
