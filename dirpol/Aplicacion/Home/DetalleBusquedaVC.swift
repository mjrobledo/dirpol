//
//  DetalleBusquedaVC.swift
//  dirpol
//
//  Created by macbook on 19/09/18.
//  Copyright © 2018 gravittas. All rights reserved.
//

import UIKit
import GoogleMaps

class DetalleBusquedaVC: UIViewController {

    @IBOutlet weak var lblTitulo: UILabel!
    
    @IBOutlet weak var lblDescripcionExpande: UILabel!
    @IBOutlet weak var lblDireccionExpande: UILabel!
    
    
    @IBOutlet weak var mapa: GMSMapView!
    
    @IBOutlet weak var telefono1: UILabel!
    @IBOutlet weak var telefono2: UILabel!
    @IBOutlet weak var telefono3: UILabel!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var cargo: UILabel!
    @IBOutlet weak var descripcion: UILabel!
    @IBOutlet weak var direccion: UILabel!
    @IBOutlet weak var localizacion: UILabel!
    
    var institucion:Institucion!
    
    @IBOutlet weak var viewFrame: UIView!
    @IBOutlet weak var viewMapaExpande: GMSMapView!
    
    @IBOutlet var viewFrameMapa: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        if institucion != nil{
            lblTitulo.text = "\(institucion.Descripcion) \(institucion.Districto)"
            
        }
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        if institucion != nil{
            self.llenarInformacion()
            
            self.viewFrameMapa.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.viewFrame.addSubview(self.viewFrameMapa)
            self.viewFrameMapa.alpha = 0
        }
    }
    
    func llenarInformacion(){
        if institucion.Telefonos.count >= 1{
            telefono1.text = institucion.Telefonos[0]
            telefono1.textColor = UIColor.cPrincipal()
            let tap1 = UITapGestureRecognizer(target: self, action: #selector(llamaTelefonoUno))
            self.telefono1.addGestureRecognizer(tap1)
        }
        if institucion.Telefonos.count >= 2{
            telefono2.text = institucion.Telefonos[1]
            telefono2.textColor = UIColor.cPrincipal()
            let tap1 = UITapGestureRecognizer(target: self, action: #selector(llamaTelefonoDos))
            self.telefono2.addGestureRecognizer(tap1)
        }
        if institucion.Telefonos.count >= 3{
            telefono3.text = institucion.Telefonos[2]
            telefono3.textColor = UIColor.cPrincipal()
            let tap1 = UITapGestureRecognizer(target: self, action: #selector(llamaTelefonoTres))
            self.telefono3.addGestureRecognizer(tap1)
        }
        
        nombre.text = institucion.NombreFuncionario
        cargo.text = institucion.Cargo
        descripcion.text = institucion.Descripcion
        direccion.text = institucion.Direccion
        localizacion.text = institucion.Districto
        
        lblDireccionExpande.text = institucion.Direccion
        lblDescripcionExpande.text = institucion.Descripcion
        
        let camera = GMSCameraPosition.camera(withLatitude: institucion.Latitud, longitude: institucion.Longitud, zoom: 15.0)
        let camera2 = GMSCameraPosition.camera(withLatitude: institucion.Latitud, longitude: institucion.Longitud, zoom: 15.0)
        
        
        mapa.camera = camera
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: institucion.Latitud, longitude: institucion.Longitud)
        marker.map = mapa
        marker.icon =  #imageLiteral(resourceName: "ic_pin") //GMSMarker.markerImage(with: UIColor.cPrincipal())
        
        
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude: institucion.Latitud, longitude: institucion.Longitud)
        marker2.map = viewMapaExpande
        marker2.icon =  #imageLiteral(resourceName: "ic_pin") //GMSMarker.markerImage(with: UIColor.cPrincipal())
        viewMapaExpande.camera = camera2
        
    }
    
    @objc private func llamaTelefonoUno(){
        llamar(telefono: institucion.Telefonos[0])
    }
    @objc private func llamaTelefonoDos(){
        llamar(telefono: institucion.Telefonos[1])
    }
    @objc private func llamaTelefonoTres(){
        llamar(telefono: institucion.Telefonos[2])
    }
    
    func llamar(telefono:String){
        
        if let url = URL(string: "telprompt://\(telefono)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }else{
            Utileria().enviarAlerta(mensaje: "Número de teléfono no válido", titulo: "Alerta", controller: self)
        }
    }
    
    @IBAction func volver(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func expandeMapa(_ sender: Any) {
        
        UIView.animate(withDuration: 2, animations: {
            //self.viewFrame.addSubview(self.viewFrameMapa)
            self.viewFrameMapa.alpha = 1
        }, completion: nil)
    }
    
    @IBAction func vistaNormal(_ sender: Any) {
       
        
        UIView.animate(withDuration: 2, animations: {
            self.viewFrameMapa.alpha = 0
        }, completion: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
