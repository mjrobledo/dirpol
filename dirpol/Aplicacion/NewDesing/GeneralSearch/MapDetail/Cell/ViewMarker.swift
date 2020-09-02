//
//  ViewMarcker.swift
//  dirpol
//
//  Created by macbook on 22/09/18.
//  Copyright © 2018 gravittas. All rights reserved.
//

import UIKit

class ViewMarker: UIView {

    
    @IBOutlet weak var lblRegion: UILabel!
    @IBOutlet weak var imgMarker: UIImageView!
    
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        imgMarker.image = UIImage(named: "img_marker_\(Api.config_app.getShortName())")
    }
}
