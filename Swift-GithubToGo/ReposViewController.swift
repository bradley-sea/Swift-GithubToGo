//
//  ReposViewController.swift
//  Swift-GithubToGo
//
//  Created by Reed Sweeney on 6/6/14.
//  Copyright (c) 2014 Bradley Johnson. All rights reserved.
//

import UIKit

class ReposViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var networkController : NetworkController?
    @IBOutlet var tableView : UITableView
    var myPublicRepos = Repo[]()
    var myPrivateRepos = Repo[]()

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate

        self.networkController = appDelegate.networkController
        
        self.networkController!.retrieveMyReposWithCompletion() {
            (repos: Repo[]) in
            
            self.seperateIntoPublicAndPrivate(repos)
            NSOperationQueue.mainQueue().addOperationWithBlock() { () in
                self.tableView.reloadData()
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView!,
        titleForHeaderInSection section: Int) -> String! {
            if (section == 0) {
                return "My Public Repos"
            }
            else {
                return "My Private Repos"
            }
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return self.myPublicRepos.count
        }
        else {
            return self.myPrivateRepos.count
        }
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        var repo : Repo
        if (indexPath.section == 0) {
            repo = self.myPublicRepos[indexPath.row]
        }
        else {
            repo = self.myPrivateRepos[indexPath.row] as Repo
        }
        
        cell.textLabel.text = repo.name
        
        return cell
    }
    
    func seperateIntoPublicAndPrivate( repos : Repo[])
    {
       
        for repo : Repo in repos {
           
            if repo.isPrivate {
                self.myPrivateRepos += repo
            }
            else {
                self.myPublicRepos += repo
            }
        }
    }
}
