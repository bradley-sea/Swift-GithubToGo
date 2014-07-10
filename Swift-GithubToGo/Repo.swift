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
    var isPrivate = false
    var starGazers = 0
    var forks = 0
    var repoDescription = ""

    func parseJSONIntoRepos(json : NSMutableArray) -> Repo[] {
        
        var repos = Repo[]()
        
        for jsonRepo : AnyObject in json {
            var repo = Repo()
            repo.name = jsonRepo.objectForKey("name") as String
            repo.isPrivate = jsonRepo.objectForKey("private") as Bool
            repo.forks = jsonRepo.objectForKey("forks_count") as Int
            repo.starGazers = jsonRepo.objectForKey("stargazers_count") as Int
            repo.repoDescription = jsonRepo.objectForKey("description") as String
            repos += repo
        }
        return repos
    }
}
