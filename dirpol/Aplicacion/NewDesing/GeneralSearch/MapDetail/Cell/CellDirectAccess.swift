//
//  CellDirectAccess.swift
//  dirpol
//
//  Created by Developer iOS on 7/30/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit

protocol DirectAccessDelegate {
    func call(identifier: Int)
    func web(identifier: Int)
    func eMail(identifier: Int)
    func photo(identifier: Int)
    func socialMedia(identifier: Int)
}

class CellDirectAccess: UITableViewCell {

    var delegate: DirectAccessDelegate!
    
    @IBOutlet weak var viewTel: UIView!
    @IBOutlet weak var viewWeb: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPhoto: UIView!
    @IBOutlet weak var viewSocial: UIView!
    
    @IBOutlet weak var imgTel: UIImageView!
    @IBOutlet weak var imgWeb: UIImageView!
    @IBOutlet weak var imgEmail: UIImageView!
    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var imgSocial: UIImageView!
    @IBOutlet weak var imgRepre: UIImageView!
    
    var identifier = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgTel.image = UIImage(named: "ic_call_\(Api.config_app.getShortName())")
        imgWeb.image = UIImage(named: "ic_web_\(Api.config_app.getShortName())")
        imgEmail.image = UIImage(named: "ic_mail_\(Api.config_app.getShortName())")
        imgPhoto.image = UIImage(named: "ic_photo_\(Api.config_app.getShortName())")
        imgSocial.image = UIImage(named: "ic_search_\(Api.config_app.getShortName())")
        imgRepre.image = UIImage(named: "ic_repre_\(Api.config_app.getShortName())")
    }

    @IBAction func call(_ sender: Any) {
        self.delegate.call(identifier: self.identifier)
    }
    
    @IBAction func web(_ sender: Any) {
        self.delegate.web(identifier: self.identifier)
    }
    
    @IBAction func eMail(_ sender: Any) {
        self.delegate.eMail(identifier: self.identifier)
    }
    
    @IBAction func photo(_ sender: Any) {
        self.delegate.photo(identifier: self.identifier)
    }
    
    @IBAction func socialMedia(_ sender: Any) {
        self.delegate.socialMedia(identifier: self.identifier)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
