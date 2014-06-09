//
//  UserCVCell.swift
//  Swift-GithubToGo
//
//  Created by Bradley Johnson on 6/8/14.
//  Copyright (c) 2014 Bradley Johnson. All rights reserved.
//

import UIKit

class UserCVCell: UICollectionViewCell {
    
    var nameLbl = UILabel(frame: CGRectMake(10, 100, 120, 30))
    
    init(frame: CGRect) {
        super.init(frame: frame)
        
        // Initialization code
    }
    
    
    
    
    
    
    
    
    
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        self.contentView.addSubview(self.nameLbl)
        self.nameLbl.textAlignment = NSTextAlignment.Center
    }
    
}
