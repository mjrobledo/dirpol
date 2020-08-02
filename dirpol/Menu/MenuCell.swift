//
//  MenuCell.swift
//  Proyecto
//
//  Created by DESAPP-1 on 16/03/17.
//  Copyright © 2017 Lisyx. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var imgIcono: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //lblTitulo.numberOfLines = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
