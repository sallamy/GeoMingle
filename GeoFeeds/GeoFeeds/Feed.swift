//
//  Feed.swift
//  GeoFeeds
//
//  Created by sala7 on 4/26/17.
//  Copyright © 2017 GEO. All rights reserved.
//

import Foundation
class feed : NSObject{
    var Id = 0
   var ownername = ""
    var posttext = ""
    var ownerimage = ""
    var postImage = ""
    var numberoflikes = 0
    var numberofshare = 0
    var numberofcomments = 0
    var createddate  = ""
    var commentsList = [comment]()
}

class comment : NSObject{
    var Id = 0
    var comment  = ""
   var createddate = ""
    var name = ""
    var image = ""
}
