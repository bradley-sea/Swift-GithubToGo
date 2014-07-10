//
//  RepoSearchViewController.swift
//  Swift-GithubToGo
//
//  Created by Bradley Johnson on 6/8/14.
//  Copyright (c) 2014 Bradley Johnson. All rights reserved.
//

import UIKit

class RepoSearchViewController: UIViewController, UITableViewDataSource {
    
    var networkController : NetworkController?
    var searchRepos = Repo[]()
    
    @IBOutlet var tableView : UITableView = nil
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.networkController

        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.searchRepos.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell : RepoSearchTVCell = tableView.dequeueReusableCellWithIdentifier("repoSearchCell", forIndexPath: indexPath) as RepoSearchTVCell
        
        var repo : Repo = self.searchRepos[indexPath.row]
        cell.titleLabel.text = repo.name
        cell.descriptionLabel.text = repo.repoDescription
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchForRepo(repoSearch : String) {
        
        self.networkController!.searchReposWithString(repoSearch) {
            (repos: Repo[]) in
            
            self.searchRepos = repos
            
            NSOperationQueue.mainQueue().addOperationWithBlock() { () in
                self.tableView.reloadData()
                
            }
        }
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
