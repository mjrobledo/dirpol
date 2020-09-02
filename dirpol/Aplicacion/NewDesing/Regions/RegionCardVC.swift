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
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var btnDepto: UIButton!
    @IBOutlet weak var btnProvince: UIButton!
    @IBOutlet weak var btnCity: UIButton!
    @IBOutlet weak var btnDistrict: UIButton!
    
    @IBOutlet weak var txtDepto: UITextField!
    @IBOutlet weak var txtProvince: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtDistrict: UITextField!
    @IBOutlet weak var stackF: NSLayoutConstraint!
    
    @IBOutlet weak var collView: UICollectionView!
    
    var filter: [Dependencies] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configScreen()
        
        collView.register(UINib(nibName: "CellOption", bundle: nil), forCellWithReuseIdentifier: "cellOption")
        filter.append(Dependencies(title: "Bomberos", icon: #imageLiteral(resourceName: "ic_firefighter")))
        filter.append(Dependencies(title: "Comisaria", icon: #imageLiteral(resourceName: "ic_police")))
        filter.append(Dependencies(title: "Hospitales", icon: #imageLiteral(resourceName: "ic_hospital")))
        filter.append(Dependencies(title: "Serenazgos", icon: #imageLiteral(resourceName: "escudo_cara_principal")))
        filter.append(Dependencies(title: "Comisaria", icon: #imageLiteral(resourceName: "ic_police")))
        filter.append(Dependencies(title: "Hospitales", icon: #imageLiteral(resourceName: "ic_hospital")))
        filter.append(Dependencies(title: "Serenazgos", icon: #imageLiteral(resourceName: "escudo_cara_principal")))
        
        if filter.count > 4 {
            stackF.constant = 200
        }
    }
    
    func configScreen() {
        switch Api.config_app {
        case .Colombia:
            viewLine.backgroundColor = UIColor.cYelowCo()
        case .Peru:
            viewLine.backgroundColor = UIColor.cGreenPe()
        case .Mexico:
            viewLine.backgroundColor = UIColor.cGreenPe()
        }
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

extension RegionCardVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filter.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellOption", for: indexPath)
        let title: UILabel = cell.viewWithTag(2) as! UILabel
        let img: UIImageView = cell.viewWithTag(1) as! UIImageView
        
        let item = filter[indexPath.row]
        title.text = item.title
        img.image = item.icon
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 4
        return CGSize(width: width, height: width)
    }
    
}

struct Dependencies {
    var title: String = ""
    var icon: UIImage = UIImage()
}
