//
//  CellStation.swift
//  dirpol
//
//  Created by MYB on 02/08/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit

class CellStation: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPositionCompany: UILabel!
    
    @IBOutlet weak var lblPhones: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCell(people: EntidadPersonal, address: String) {
        lblAddress.text = address
        lblPositionCompany.text = people.cargo?.descripcion_cargo
        lblName.text = people.personal?.getName()
        if let phones : [String] = people.personal?.personalTelefonos.map({ $0.telefono! }) {
            lblPhones.text = phones.joined(separator: ",")
        }
    }
    
}
