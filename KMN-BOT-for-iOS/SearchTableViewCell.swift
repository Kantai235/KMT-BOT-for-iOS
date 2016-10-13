//
//  SearchTableViewCell.swift
//  KMN-BOT-for-iOS
//
//  Created by 熊谷乾太 on 2016/9/23.
//  Copyright © 2016年 乾太. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var SearchCellImageView: UIImageView!
    @IBOutlet weak var SearchCellMainTitle: UILabel!
    @IBOutlet weak var SearchCellSubTitle: UILabel!
    
    var cellPost: 寵物!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
