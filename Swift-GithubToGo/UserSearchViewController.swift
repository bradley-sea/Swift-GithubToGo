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
    
    func collectionView(collectionView: UICollectionView!,
        numberOfItemsInSection section: Int) -> Int {
            return 20
    }
    
    func collectionView(collectionView: UICollectionView!,
        cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("userSearchCell", forIndexPath: indexPath) as UICollectionViewCell
            cell.backgroundColor = UIColor.blueColor()
            cell.contentView.backgroundColor = UIColor.purpleColor()
            
            return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
