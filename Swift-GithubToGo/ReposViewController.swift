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
    var myRepos = Repo[]()
    

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
            
            self.myRepos = repos
            
            NSOperationQueue.mainQueue().addOperationWithBlock() { () in
                
                
                self.tableView.reloadData()

            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return self.myRepos.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        var repo = self.myRepos[indexPath.row] as Repo
        
        cell.textLabel.text = repo.name
        
        return cell
    }
    


}
