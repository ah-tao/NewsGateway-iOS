//
//  SourcesTableViewCell.swift
//  News Gateway
//
//  Created by Taotao Ma on 6/12/19.
//  Copyright © 2019 Taotao Ma. All rights reserved.
//

import UIKit

class SourcesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var sourceIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
