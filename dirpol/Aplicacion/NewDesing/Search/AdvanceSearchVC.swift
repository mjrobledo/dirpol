//
//  AdvanceSearchVC.swift
//  dirpol
//
//  Created by Developer iOS on 7/18/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit
import SVProgressHUD

class AdvanceSearchVC: UIViewController {

    @IBOutlet weak var btnMenu: UIBarButtonItem!
    @IBOutlet weak var btnPostion: UIButton!
    
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
    
    @IBOutlet weak var imgBackground: UIImageView!
    
    @IBOutlet weak var stackF: NSLayoutConstraint!
    @IBOutlet weak var collView: UICollectionView!
    
    private var ubigeoN1: UbigeosModel!
    private var ubigeoN2: UbigeosModel!
    private var ubigeoN3: UbigeosModel!
    
    var items: [TypeEntity] = []
    private var entidades : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collView.register(UINib(nibName: "CellOption", bundle: nil), forCellWithReuseIdentifier: "cellOption")
        
        viewN1.isHidden = true
        viewN2.isHidden = true
        viewN3.isHidden = true
        viewN4.isHidden = true
        
        btnMenu.colorMenu()
        self.configScreen()
        if revealViewController() != nil {
            btnMenu.target = revealViewController()
            btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.getTypeEntity()
        self.getNivels()
    }
    
    private func getTypeEntity() {
        SVProgressHUD.show()
        Singleton.instance.services.getTypeEntity { (response) in
            SVProgressHUD.dismiss()
            if response != nil && response?.status == 200 {
                self.items = (response?.data)!
                self.loadTypes()
            }
        }
    }
    
    private func getNivels() {
        Singleton.instance.services.getNiveles { (response) in
            if response != nil && response?.status == 200 {
                response?.data?.forEach({ (nivel) in
                    switch nivel.nivel {
                    case 1:
                        self.viewN1.isHidden = false
                        self.lblNivel1.placeholder = nivel.descripcion
                        self.btnNivel1.tag = 1
                    case 2:
                        self.viewN2.isHidden = false
                        self.lblNivel2.placeholder = nivel.descripcion
                        self.btnNivel2.tag = 2
                    case 3:
                        self.viewN3.isHidden = false
                        self.lblNivel3.placeholder = nivel.descripcion
                        self.btnNivel3.tag = 3
                    case 4:
                        self.viewN4.isHidden = false
                        self.lblNivel4.placeholder = nivel.descripcion
                        self.btnNivel3.tag = 4
                    default : print("nivel desconocido")
                    }
                })
            }
        }
    }
    
    func loadTypes() {
        if items.count > 4 {
            stackF.constant = 200
        }
        self.collView.reloadData()
    }
    
    private func configScreen(){
        switch Api.config_app {
        case .Colombia:
            imgBackground.image = #imageLiteral(resourceName: "img_bacground_co")
        case .Peru:
            imgBackground.image = UIImage(named: "img_login")
        case .Mexico:
            imgBackground.image = UIImage(named: "img_login")
        }
    }
    
    @IBAction func selectedList(_ sender: UIButton) {
        let n = NivelOption(rawValue: sender.tag)
        self.performSegue(withIdentifier: "segueList", sender: n)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueList" {
            let vc = segue.destination as! ListVC
            vc.nivel = (sender as! NivelOption)
            if vc.nivel == .Nivel2 {
                vc.ubigeo = ubigeoN1
            } else if vc.nivel == .Nivel3 {
                vc.ubigeo = ubigeoN2
            } else if vc.nivel == .Nivel4 {
                vc.ubigeo = ubigeoN3
            }
            vc.delegate = self
            vc.setPopPup()
        }
    }
}

extension AdvanceSearchVC : ListDelegate {
    func setNivel(nivel: NivelOption, ubigeo: UbigeosModel) {
        switch nivel {
        case .Nivel1:
            if self.ubigeoN1 != nil && ubigeoN1.ubigeo_id == ubigeo.ubigeo_id {
                self.ubigeoN2 = nil
                self.ubigeoN3 = nil
                self.lblNivel2.text = ""
                self.lblNivel3.text = ""
            }
            self.lblNivel1.text = ubigeo.descripcion_ubigeo
            self.ubigeoN1 = ubigeo
            
        case .Nivel2:
            if self.ubigeoN2 != nil && ubigeoN2.ubigeo_id == ubigeo.ubigeo_id {
                self.ubigeoN3 = nil
                self.lblNivel3.text = ""
            }
            self.lblNivel2.text = ubigeo.descripcion_ubigeo
            self.ubigeoN2 = ubigeo
            
        case .Nivel3:
            self.ubigeoN3 = ubigeo
            self.lblNivel3.text = ubigeo.descripcion_ubigeo
        case .Nivel4:
            print("vacio")
            
        }
    }
}

extension AdvanceSearchVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
