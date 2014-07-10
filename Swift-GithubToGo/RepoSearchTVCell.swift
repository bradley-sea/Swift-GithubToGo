//
//  RepoSearchTVCell.swift
//  Swift-GithubToGo
//
//  Created by Bradley Johnson on 6/8/14.
//  Copyright (c) 2014 Bradley Johnson. All rights reserved.
//

import UIKit

class RepoSearchTVCell: UITableViewCell {

    @IBOutlet var titleLabel : UILabel = nil
    @IBOutlet var descriptionLabel : UILabel = nil
    
    @IBOutlet var watchers : UILabel = nil
    @IBOutlet var forks : UILabel = nil
    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
