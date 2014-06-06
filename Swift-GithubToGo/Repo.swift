//
//  Repo.swift
//  Swift-GithubToGo
//
//  Created by Bradley Johnson on 6/6/14.
//  Copyright (c) 2014 Bradley Johnson. All rights reserved.
//

import UIKit

class Repo: NSObject {
    
    var name = ""
    var repoURL = ""
    
    func parseJSONIntoRepos(json : NSMutableArray) -> Repo[] {
        
        var repos = Repo[]()
        
        for jsonRepo : AnyObject in json {
            var repo = Repo()
            repo.name = jsonRepo.objectForKey("name") as String
            repos += repo
        }
        return repos
    }
}
