//
//  CellHeaderMap.swift
//  dirpol
//
//  Created by Developer iOS on 7/30/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit

class CellHeaderMap: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDivision: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
