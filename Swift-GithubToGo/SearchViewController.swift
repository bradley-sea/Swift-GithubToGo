//
//  SearchViewController.swift
//  Swift-GithubToGo
//
//  Created by Daniel Fairbanks on 6/6/14.
//  Copyright (c) 2014 Bradley Johnson. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
 
    @IBOutlet var segmentControl : UISegmentedControl = nil
    @IBOutlet var searchBar : UISearchBar
    @IBOutlet var container : UIView = nil

    var userSearchVC : UserSearchViewController?
    var repoSearchVC : RepoSearchViewController?
   
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        self.userSearchVC = storyboard.instantiateViewControllerWithIdentifier("UserSearchVC") as? UserSearchViewController
        self.userSearchVC!.view.frame = self.container.bounds
        self.addChildViewController(self.userSearchVC!)
        self.userSearchVC!.didMoveToParentViewController(self)
        
        self.repoSearchVC = storyboard.instantiateViewControllerWithIdentifier("RepoSearchVC") as? RepoSearchViewController
        self.repoSearchVC!.view.frame = self.container.bounds
        self.addChildViewController(self.repoSearchVC!)
        self.repoSearchVC!.didMoveToParentViewController(self)
        self.container.addSubview(self.repoSearchVC!.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func searchBarSearchButtonClicked( searchBar: UISearchBar!) {
        if self.segmentControl.selectedSegmentIndex == 0 {
            self.repoSearchVC!.searchForRepo(searchBar.text)
            searchBar.resignFirstResponder()
        }
        else {
            self.userSearchVC!.searchForUsers(searchBar.text)
            searchBar.resignFirstResponder()
        }
    
    }
    
    @IBAction func segmentSelected(sender : UISegmentedControl) {

        if sender.selectedSegmentIndex == 0 {
            sender.enabled = false
            self.container.addSubview(self.repoSearchVC!.view)
            self.repoSearchVC!.view.alpha = 0
            
                        UIView.animateWithDuration(0.3, animations:{ ()  in
                            self.userSearchVC!.view.alpha = 0
                            self.repoSearchVC!.view.alpha = 1
                            }, completion: { (Bool) in
                                self.userSearchVC!.view.removeFromSuperview()
                                self.userSearchVC!.removeFromParentViewController()
                                sender.enabled = true
                            }
                        )
        }
        
        else {
            
            sender.enabled = false
            self.container.addSubview(self.userSearchVC!.view)
            self.userSearchVC!.view.alpha = 0
        
            UIView.animateWithDuration(0.3, animations:{ ()  in
                self.userSearchVC!.view.alpha = 1
                self.repoSearchVC!.view.alpha = 0
                }, completion: { (Bool) in
                    self.repoSearchVC!.view.removeFromSuperview()
                    self.repoSearchVC!.removeFromParentViewController()
                    sender.enabled = true
                }
            )
        }
    }
    

}
