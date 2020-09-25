//
//  CardViewController.swift
//  CardViewAnimation
//
//  Created by Brian Advent on 26.10.18.
//  Copyright © 2018 Brian Advent. All rights reserved.
//

import UIKit

protocol RegionCardVCDelegate {
    func selectedOption(option: NivelOption)
    func filter(entidadID : [String])
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
    
    @IBOutlet weak var viewN1: UIView!
    @IBOutlet weak var viewN2: UIView!
    @IBOutlet weak var viewN3: UIView!
    @IBOutlet weak var viewN4: UIView!
    
    @IBOutlet weak var lblNivel1: UITextField!
    @IBOutlet weak var lblNivel2: UITextField!
    @IBOutlet weak var lblNivel3: UITextField!
    @IBOutlet weak var lblNivel4: UITextField!
    
    @IBOutlet weak var btnNivel1: UIButton!
    @IBOutlet weak var btnNivel2: UIButton!
    @IBOutlet weak var btnNivel3: UIButton!
    @IBOutlet weak var btnNivel4: UIButton!
    
    //var filter: [Dependencies] = []
    var items: [TypeEntity] = []
    private var entidades : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configScreen()
        viewN1.isHidden = true
        viewN2.isHidden = true
        viewN3.isHidden = true
        viewN4.isHidden = true
        
        collView.register(UINib(nibName: "CellOption", bundle: nil), forCellWithReuseIdentifier: "cellOption")
       
        
    }
    
    func loadTypes() {
        if items.count > 4 {
            stackF.constant = 200
        }
        self.collView.reloadData()
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
        let n = NivelOption(rawValue: sender.tag)
        self.delegate.selectedOption(option: n!)
    }
    
    @IBAction func filter(_ sender: UIButton) {
        if lblNivel3.text!.isEmpty || entidades.isEmpty {
            Util().enviarAlerta(mensaje: "Todos los campos son obligatorios", titulo: .Alerta, controller: self)
        } else {
            self.delegate.filter(entidadID: self.entidades)
        }
    }
}

enum NivelOption : Int {
    case Nivel1 = 1
    case Nivel2 = 2
    case Nivel3 = 3
    case Nivel4 = 4
}

extension RegionCardVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellOption", for: indexPath) as! CellOption
        let title: UILabel = cell.viewWithTag(2) as! UILabel
        let img: UIImageView = cell.viewWithTag(1) as! UIImageView
        
        let item = items[indexPath.row]
        title.text = item.descripcion
        img.imageFromServerURL(urlString: item.ruta_icono_seleccionado!, defaultImage: UIImage(named: "LOGO2"))
        
        if item.selected {
            cell.viewButton.backgroundColor = UIColor.cPrincipal()
            title.textColor = .white
        } else {
            cell.viewButton.backgroundColor = UIColor.white
            title.textColor = .cPrincipal()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 4
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        item.selected = !item.selected
        
        if item.selected {
            entidades.append(item.tipo_entidad_id!)
        } else {
            entidades.removeAll(where: { $0 == item.tipo_entidad_id! })
        }
        
        self.collView.reloadData()
    }
    
}

struct Dependencies {
    var title: String = ""
    var icon: UIImage = UIImage()
}
