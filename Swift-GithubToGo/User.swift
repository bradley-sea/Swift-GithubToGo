//
//  User.swift
//  Swift-GithubToGo
//
//  Created by Bradley Johnson on 6/8/14.
//  Copyright (c) 2014 Bradley Johnson. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name = ""
    
    func parseJSONIntoUsers(json : NSMutableArray) -> User[] {
        
        var users = User[]()
        
        for jsonUser : AnyObject in json {
            var user = User()
            user.name = jsonUser.objectForKey("login") as String
            users += user
        }
        return users
    }
   
}

