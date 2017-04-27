//
//  ViewController.swift
//  GeoFeeds
//
//  Created by sala7 on 4/26/17.
//  Copyright © 2017 GEO. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
            self.navigationController!.navigationBar.backgroundColor = UIColor.orange
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func linkedinAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "TabSegue", sender: nil)
    }
    @IBAction func faceBookAction(_ sender: UIButton) {
         self.performSegue(withIdentifier: "TabSegue", sender: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

