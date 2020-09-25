//
//  CellGeneralSearchDetail.swift
//  dirpol
//
//  Created by Developer iOS on 7/29/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit

class CellGeneralSearchDetail: UITableViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var imgPhoto: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgIcon.image = UIImage(named: "ic_call_\(Api.config_app.getShortName())")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
