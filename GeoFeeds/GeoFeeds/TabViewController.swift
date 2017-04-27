//
//  TabViewController.swift
//  GeoFeeds
//
//  Created by sala7 on 4/26/17.
//  Copyright © 2017 GEO. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController,UITabBarControllerDelegate {
    var segmentedControl:UISegmentedControl!
      let stream = StreamViewController()
       let messages = MessagesViewController()
        let requests = RequestsViewController()
            let notifications = NotificationsViewController()
         let friends = FriendsViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
      setProfileImageOnBarButton()
        //Where tableview is the IBOutlet for your storyboard tableview.
     

        self.navigationController?.isNavigationBarHidden = false
        self.tabBar.tintColor = UIColor.orange
       setControllers()
       setSegment()
        
        // Do any additional setup after loading the view.
    }
    
    
    func setControllers(){
      
        stream.title = "Stream"
    
        requests.title =  "Requests"
     
        messages.title = "Messages"
   
        friends.title = "Friends"

        notifications.title = "Notifications"
        self.viewControllers = [stream,requests,messages,friends,notifications]
    }
    
    func setSegment(){
        let segmentTextContent = [
            "Nearby",
            "Feeeds"
            
        ]
        
        // Segmented control as the custom title view
        segmentedControl = UISegmentedControl(items: segmentTextContent)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = UIColor.white
        segmentedControl.autoresizingMask = .flexibleWidth
        segmentedControl.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        segmentedControl.addTarget(stream, action: #selector(stream.action(_:)), for: .valueChanged)
        self.navigationItem.titleView = segmentedControl

    }
    func setProfileImageOnBarButton() {
       
        let button = UIButton()
      
        button.setImage( #imageLiteral(resourceName: "profile-icon-9.png") , for: UIControlState.normal)
        button.addTarget(self, action:#selector(self.openUserProfile), for: UIControlEvents.touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
    
        button.layer.cornerRadius = button.frame.width / 2
        button.layer.masksToBounds = true
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.navigationController?.isNavigationBarHidden = false
    }
    @IBAction func openUserProfile(_ sender: Any) {
        print("CustomTitleViewController IBAction invoked!")
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if !viewController.isKind(of: StreamViewController.self) {
          self.navigationItem.titleView = nil
        }else {
            self.navigationItem.titleView = segmentedControl
        }
        if viewController.isKind(of: FriendsViewController.self) {
                         self.title = "Friends"
        
        }else  if viewController.isKind(of: MessagesViewController.self) {
                   self.title = "Messages"
        }
        else  if viewController.isKind(of: RequestsViewController.self) {
                  self.title = "Requests"
        }
        else  if viewController.isKind(of: NotificationsViewController.self) {
            self.title = "Notifcations"
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
