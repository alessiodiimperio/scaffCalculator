//
//  ItemCellTableViewCell.swift
//  scaffCalc
//
//  Created by Alessio on 2020-03-12.
//  Copyright © 2020 Alessio. All rights reserved.
//

import UIKit

class ItemCellTableViewCell: UITableViewCell {
    @IBOutlet weak var itemIcon: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemQtyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
