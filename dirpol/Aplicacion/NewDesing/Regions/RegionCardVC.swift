//
//  CardViewController.swift
//  CardViewAnimation
//
//  Created by Brian Advent on 26.10.18.
//  Copyright © 2018 Brian Advent. All rights reserved.
//

import UIKit

protocol RegionCardVCDelegate {
    func selectedOption(option: SelectOption)
}

class RegionCardVC: UIViewController {
    var delegate: RegionCardVCDelegate!
 
    @IBOutlet weak var handleArea: UIView!

    @IBOutlet weak var btnDepto: UIButton!
    @IBOutlet weak var btnProvince: UIButton!
    @IBOutlet weak var btnCity: UIButton!
    @IBOutlet weak var btnDistrict: UIButton!

    @IBOutlet weak var txtDepto: UITextField!
    @IBOutlet weak var txtProvince: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtDistrict: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func openSelect(_ sender: UIButton) {
        switch sender {
        case btnProvince:
            self.delegate.selectedOption(option: .depto)
        case btnProvince:
            self.delegate.selectedOption(option: .province)
        case btnCity:
            self.delegate.selectedOption(option: .city)
        case btnDistrict:
            self.delegate.selectedOption(option: .districto)
        default:
            self.delegate.selectedOption(option: .depto)
        }
    }


}

enum SelectOption {
    case depto
    case province
    case city
    case districto
}
