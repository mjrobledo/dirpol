//
//  RegionsVC.swift
//  dirpol
//
//  Created by Developer iOS on 7/18/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit
import GoogleMaps
import SVProgressHUD

class RegionsVC: UIViewController {
    enum CardState {
        case expanded
        case collapsed
    }

     @IBOutlet weak var viewMap: GMSMapView!
     @IBOutlet weak var btnMenu: UIBarButtonItem!
    
    var regionCard: RegionCardVC!
    var visualEffectView: UIVisualEffectView!

    var marker:[GMSMarker] = []

    var cardHeight:CGFloat = 400
    let cardHandleAreaHeight:CGFloat = 65

    var cardVisible = false
    private var labelDepto = ""
    
    private var markersCountry : [GMSMarker] = []
    private var markersSedes : [GMSMarker] = []
    
    var nextState: CardState {
        return cardVisible ? .collapsed : .expanded
    }

    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0

    private var typeEntitys: [TypeEntity] = []
    
    private var ubigeoN1: UbigeosModel!
    private var ubigeoN2: UbigeosModel!
    private var ubigeoN3: UbigeosModel!
    private var ubigeoN4: UbigeosModel!
    
    private var items: [UbigeosModel] = []
    var sedes: [[SedeModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            btnMenu.target = revealViewController()
            btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
                  view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        btnMenu.colorMenu()

        viewMap.camera = GMSCameraPosition(latitude: -10.190200, longitude: -75.538139, zoom: 6)
        viewMap.delegate = self
        DispatchQueue.main.async {
            self.getUbigeos()
        }
        
    }
    
    private func setMarkers() {
        self.markersCountry.removeAll()
        items.forEach { (ubigeo) in
            let marker2 = GMSMarker()
            if let lat = Double(ubigeo.latitud!), let lng = Double(ubigeo.longitud!) {
                
                marker2.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                marker2.iconView = UIImageView(image: UIImage(named: "ic_marker_red"))
                
                if let markerImage = Singleton.instance.business.ruta_marcador_ubigeo {
                    let imgv = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
                    imgv.imageFromServerURL(urlString: markerImage, defaultImage: UIImage(named: "ic_marker_red"))
                    marker2.iconView = imgv
                }
                
                marker2.title = ubigeo.descripcion_ubigeo
                marker2.snippet = Singleton.instance.business.nombre
                marker2.ubigeo = ubigeo
                
                self.markersCountry.append(marker2)
                marker2.map = self.viewMap
            }
        }
    }
    
    func setSedes(sedesM: [SedeModel]) {
        
        viewMap.clear()
        
        sedesM.forEach { (s) in
            let marker2 = GMSMarker()
            if let lat = Double(s.latitud!), let lng = Double(s.longitud!) {
                
                marker2.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                marker2.iconView = UIImageView(image: UIImage(named: "ic_marker_red"))
                
                if let markerImage = s.ruta_icono_marcador {
                    let imgv = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
                    imgv.imageFromServerURL(urlString: markerImage, defaultImage: UIImage(named: "ic_marker_red"))
                    marker2.iconView = imgv
                }
                
                marker2.title = s.razon_social
                marker2.snippet = Singleton.instance.business.nombre
                marker2.entidad_id = s.entidad_id!

                self.markersSedes.append(marker2)
                marker2.map = self.viewMap
            }
        }
    }

    private func getNivels() {
        Singleton.instance.services.getNiveles { (response) in
            if response != nil && response?.status == 200 {
                response?.data?.forEach({ (nivel) in
                    switch nivel.nivel {
                    case 1:
                        self.regionCard.viewN1.isHidden = false
                        self.regionCard.lblNivel1.placeholder = nivel.descripcion
                        self.regionCard.btnNivel1.tag = 1
                    case 2: 
                        self.regionCard.viewN2.isHidden = false
                        self.regionCard.lblNivel2.placeholder = nivel.descripcion
                        self.regionCard.btnNivel2.tag = 2
                    case 3:
                        self.regionCard.viewN3.isHidden = false
                        self.regionCard.lblNivel3.placeholder = nivel.descripcion
                        self.regionCard.btnNivel3.tag = 3
                    case 4:
                        self.regionCard.viewN4.isHidden = false
                        self.regionCard.lblNivel4.placeholder = nivel.descripcion
                        self.regionCard.btnNivel3.tag = 4
                    default : print("nivel desconocido")
                    }
                })
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if regionCard == nil {
            self.setupCard()
            self.getTypeEntity()
            self.getNivels()
        }
    }

    private func getTypeEntity() {
        SVProgressHUD.show()
        Singleton.instance.services.getTypeEntity { (response) in
            SVProgressHUD.dismiss()
            if response != nil && response?.status == 200 {
                self.regionCard.items = (response?.data)!
                self.regionCard.loadTypes()
                
            }
        }
    }
    
    private func getUbigeos() {
        SVProgressHUD.show()
        
        Singleton.instance.services.getUbigeos(nivel: "1", ubigeoSup: "") { (response) in
            if response != nil && response?.status == 200 {
                self.items = (response?.data)!
                if self.items.isEmpty {
                    SVProgressHUD.showInfo(withStatus: "No se encontraron resultados")
                    SVProgressHUD.dismiss(withDelay: 4)
                } else {
                    self.setMarkers()
                }
            } else {
                SVProgressHUD.showInfo(withStatus: "El servicio no responde, Intenta más tarde")
                SVProgressHUD.dismiss(withDelay: 4)
            }
            SVProgressHUD.dismiss()
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueProvince" {
            let vc = segue.destination as! ProvincesVC
            vc.depto = self.labelDepto
            vc.ubigeo = (sender as! UbigeosModel)
        } else  if segue.identifier == "segueList" {
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
        } else if segue.identifier == "segueMapDetail" {
            let vc = segue.destination as! MapDetailVC
            vc.entityID = (sender as! String)
        }
    }
}

extension RegionsVC : ListDelegate {
    func setNivel(nivel: NivelOption, ubigeo: UbigeosModel) {
        switch nivel {
        case .Nivel1:
            if self.ubigeoN1 != nil && ubigeoN1.ubigeo_id == ubigeo.ubigeo_id {
                self.ubigeoN2 = nil
                regionCard.lblNivel2.text = ""
                self.ubigeoN3 = nil
                regionCard.lblNivel3.text = ""
            }
            
            self.ubigeoN1 = ubigeo
            regionCard.lblNivel1.text = ubigeo.descripcion_ubigeo
        case .Nivel2:
            if self.ubigeoN2 != nil && ubigeoN2.ubigeo_id == ubigeo.ubigeo_id {
                self.ubigeoN3 = nil
                regionCard.lblNivel3.text = ""
            }
            self.ubigeoN2 = ubigeo
            regionCard.lblNivel2.text = ubigeo.descripcion_ubigeo
        case .Nivel3:
            self.ubigeoN3 = ubigeo
            regionCard.lblNivel3.text = ubigeo.descripcion_ubigeo
        case .Nivel4:
            self.ubigeoN4 = ubigeo
            regionCard.lblNivel4.text = ubigeo.descripcion_ubigeo
        }
    }
}

extension RegionsVC: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        self.labelDepto = marker.title!
        if marker.entidad_id.isEmpty {
            let ubigeoID = marker.ubigeo
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "segueProvince", sender: ubigeoID)
            }
        } else {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "segueMapDetail", sender: marker.entidad_id)
            }
        }
        
        return false // return false to display info window
    }
}
 
extension UIButton {
    func colorMenu () {
        switch Api.config_app {
        case .Colombia:
            self.tintColor = UIColor.cYelowCo()
        case .Peru:
            self.tintColor = UIColor.white
        case .Mexico:
            self.tintColor = UIColor.white
        }
    }
}

extension UIBarButtonItem {
    func colorMenu () {
        switch Api.config_app {
        case .Colombia:
            self.tintColor = UIColor.cYelowCo()
        case .Peru:
            self.tintColor = UIColor.white
        case .Mexico:
            self.tintColor = UIColor.white
        }
    }

    func colorBack () {
        switch Api.config_app {
        case .Colombia:
            self.tintColor = UIColor.cYelowCo()
        case .Peru:
            self.tintColor = .cgreenMenu()
        case .Mexico:
            self.tintColor = UIColor.white
        }
    }

}

extension GMSMarker {
    
    struct Holder {
        static var _ubigeo : UbigeosModel!
        static var _entidad_id : String = ""
    }
    var ubigeo : UbigeosModel {
        get {
            return Holder._ubigeo
        }
        set(newValue) {
            Holder._ubigeo = newValue
        }
    }
    
    var entidad_id : String {
        get {
            return Holder._entidad_id
        }
        set(newValue) {
            Holder._entidad_id = newValue
        }
    }
    
}
