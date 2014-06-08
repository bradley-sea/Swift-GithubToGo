//
//  SearchViewController.swift
//  Swift-GithubToGo
//
//  Created by Daniel Fairbanks on 6/6/14.
//  Copyright (c) 2014 Bradley Johnson. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet var searchBar : UISearchBar
    @IBOutlet var tableView : UITableView
    
    var networkController : NetworkController?
    var searchRepos = Repo[]()
    
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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.searchRepos.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath: indexPath) as UITableViewCell
        
        var repo : Repo = self.searchRepos[indexPath.row]
        cell.textLabel.text = repo.name
        
        return cell
    }
    
    func searchBarSearchButtonClicked( searchBar: UISearchBar!) {
        
        
        self.networkController!.searchReposWithString(self.searchBar.text) {
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
