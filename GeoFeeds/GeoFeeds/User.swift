//
//  User.swift
//  RESTClient
//
//  Created by Alexander Gaidukov on 11/18/16.
//  Copyright © 2016 Alexander Gaidukov. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

class User: NSObject, NSCoding{

    var image: String?
    var AccessToken: String?
   
    var Name: String?

    var Gender :Int  = 0


    init?(json: JSON) {
        
  
        self.AccessToken = json["AccessToken"] as? String
   

        self.Name = json["Name"] as? String
    }
    required init(coder decoder: NSCoder) {
          self.Name = decoder.decodeObject(forKey: "Name")as? String
        self.AccessToken = decoder.decodeObject(forKey: "AccessToken") as? String
        
        
    }
    
    func encode(with coder: NSCoder) {
   
        coder.encode(Name, forKey: "Name")
        
        coder.encode(AccessToken, forKey: "AccessToken")
     
        
    }
    func save(){
        let data  = NSKeyedArchiver.archivedData(withRootObject: self)
        let defaults = UserDefaults.standard
        defaults.set(data, forKey:"User" )
    }
    func clear(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "User")
    }
    
    static func sharedUser()->User?{
        if let data = UserDefaults.standard.object(forKey: "User") as? Data
        {
           return NSKeyedUnarchiver.unarchiveObject(with: data) as! User?
           
        }
        return nil
    }
    

}
