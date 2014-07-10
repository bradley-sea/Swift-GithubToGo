//
//  UserSearchViewController.swift
//  Swift-GithubToGo
//
//  Created by Bradley Johnson on 6/8/14.
//  Copyright (c) 2014 Bradley Johnson. All rights reserved.
//

import UIKit

class UserSearchViewController: UIViewController, UICollectionViewDataSource{
    
     var networkController : NetworkController?
     var searchUsers = User[]()

    @IBOutlet var collectionView : UICollectionView = nil
    
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
    
    func searchForUsers(string : String) {
        
//        self.networkController!.searchUsersWithSearchTerm("Dr.Dre") {  (users: User[]) in
//           
//            self.searchUsers = users
//            
//            NSOperationQueue.mainQueue().addOperationWithBlock() { () in
//                
//                self.collectionView.reloadData()
//                
//            }
        
            self.networkController!.searchUsersWithSearchTerm("hello", completionClosure: { (users: User[]) in
                self.searchUsers = users
                
                NSOperationQueue.mainQueue().addOperationWithBlock() { () in
                    
                    self.collectionView.reloadData() }
        })
    }
    
    func collectionView(collectionView: UICollectionView!,
        numberOfItemsInSection section: Int) -> Int {
            return self.searchUsers.count
    }
    
    func collectionView(collectionView: UICollectionView!,
        cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
            
            var cell : UserCVCell? = collectionView.dequeueReusableCellWithReuseIdentifier("Users", forIndexPath: indexPath) as? UserCVCell
            
             var user : User = self.searchUsers[indexPath.row]
            cell!.nameLbl.text = user.name
            return cell!
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
